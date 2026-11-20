#!mainFile "../main.opy"

def feskaRefreshMods():
    @Name "Feska - refresh damage modifiers"

    if eventPlayer.Damage_Modification_Id == null or eventPlayer.Damage_Modification_Percent != feskaDamagePercent(eventPlayer):
        if eventPlayer.Damage_Modification_Id != null:
            stopDamageModification(eventPlayer.Damage_Modification_Id)
        startDamageModification(getPlayers(Team.1), eventPlayer, feskaDamagePercent(eventPlayer), DamageReeval.RECEIVERS_DAMAGERS_AND_DMGPERCENT)
        eventPlayer.Damage_Modification_Id = getLastDamageModification()
        eventPlayer.Damage_Modification_Percent = feskaDamagePercent(eventPlayer)
    if feskaReceivedPercent(eventPlayer) >= 100:
        if eventPlayer.Received_Modification_Id != null:
            stopDamageModification(eventPlayer.Received_Modification_Id)
            eventPlayer.Received_Modification_Id = null
        eventPlayer.Received_Modification_Percent = 100
    elif eventPlayer.Received_Modification_Id == null or eventPlayer.Received_Modification_Percent != feskaReceivedPercent(eventPlayer):
        if eventPlayer.Received_Modification_Id != null:
            stopDamageModification(eventPlayer.Received_Modification_Id)
        startDamageModification(eventPlayer, getPlayers(Team.1), feskaReceivedPercent(eventPlayer), DamageReeval.RECEIVERS_DAMAGERS_AND_DMGPERCENT)
        eventPlayer.Received_Modification_Id = getLastDamageModification()
        eventPlayer.Received_Modification_Percent = feskaReceivedPercent(eventPlayer)


def feskaApplyUpgradeStats():
    @Name "Feska - apply upgrade stats"

    # 纯数值科技在各自文件里累加 Bonus_By_Stat 后调用这里, 保证只有一个属性写入点。
    # 科技只累加不移除, 重放仍由 Restore stats 规则负责。
    eventPlayer.setMaxHealth(feskaHealthPercent(eventPlayer))
    eventPlayer.setHealingDealt(100 + eventPlayer.Bonus_By_Stat[Stat_Bonus.HEALING])
    feskaRefreshMods()


def feskaStopBerserk():
    @Name "Feska - stop berserk"

    # 结束(波次切换/换英雄)时恢复正常生命口径与禁疗; 移动约束由对应阶段的规则恢复。
    if Target_Player.Is_Berserk == true:
        Target_Player.Is_Berserk = false
        Target_Player.setMaxHealth(feskaHealthPercent(Target_Player))
        Target_Player.setHealingReceived(100 + 10 * Target_Player.Bonus_By_Stat[Stat_Bonus.HEALING_RECEIVED])
        Target_Player.setKnockbackReceived(100 - 10 * Target_Player.Bonus_By_Stat[Stat_Bonus.KNOCKBACK_RESISTANCE])


def feskaRefreshShields():
    @Name "Feska - refresh photon shields"

    if len(shieldTechHolders()) > 0:
        Player_List = getLivingPlayers(Team.2).filter(lambda player: not player.isDummy())
        for Loop_Index in range(len(Player_List)):
            Target_Player = Player_List[Loop_Index]
            feskaApplyShieldToPlayer()


def feskaBuildPool():
    @Name "Feska - build candidate pool"

    if Target_Player.Current_Choice_Kind == Choice_Kind.TECH:
        Target_Player.Candidate_Upgrade_Ids = Tech_Catalog_Indexes.filter(lambda upgrade: upgrade not in Target_Player.Owned_Tech_Ids and not (upgrade == Tech_Id.NO_ULTIMATE and (Tech_Id.ULTIMATE_CHARGE in Target_Player.Owned_Tech_Ids or Tech_Id.FREEZE_ALL in Target_Player.Owned_Tech_Ids or Target_Player.Bonus_By_Stat[Stat_Bonus.ULTIMATE_CHARGE] > 0)) and not (upgrade in [Tech_Id.FREEZE_ALL, Tech_Id.ULTIMATE_CHARGE] and Tech_Id.NO_ULTIMATE in Target_Player.Owned_Tech_Ids))
        # 技能强化只对英雄池内的当前英雄入池; 其他行的英雄池是空数组, 不会被选中。
        Target_Player.Candidate_Upgrade_Ids = Target_Player.Candidate_Upgrade_Ids.filter(lambda upgrade: Upgrade_Catalog[upgrade][UPGRADE_COLUMN_KIND] != UPGRADE_KIND_SKILL or Target_Player.getHero() in Upgrade_Catalog[upgrade][UPGRADE_COLUMN_HERO_POOL])
        if len(shieldTechHolders()) > 0:
            Target_Player.Candidate_Upgrade_Ids = Target_Player.Candidate_Upgrade_Ids.filter(lambda upgrade: upgrade != Tech_Id.SHIELD)
    else:
        Target_Player.Candidate_Upgrade_Ids = Stat_Catalog_Indexes.filter(lambda upgrade: not (upgrade == Stat_Upgrade_Id.ULTIMATE_CHARGE and Tech_Id.NO_ULTIMATE in Target_Player.Owned_Tech_Ids))


def feskaDealCards():
    @Name "Feska - deal cards"

    Target_Player.Selected_Card_Index = 0
    Target_Player.Card_Rerolled_Flags = [false, false, false]
    Target_Player.Is_Card_Panel_Visible = true
    if len(Target_Player.Owned_Tech_Ids) < MAX_TECH_COUNT and len(Target_Player.Owned_Tech_Ids) < feskaTechAllowance():
        Target_Player.Current_Choice_Kind = Choice_Kind.TECH
    elif len(Target_Player.Owned_Tech_Ids) == MAX_TECH_COUNT and Target_Player.Pending_Stat_Upgrade_Count > 0:
        Target_Player.Current_Choice_Kind = Choice_Kind.STAT_UPGRADE
    else:
        Target_Player.Current_Choice_Kind = Choice_Kind.NONE
    if Target_Player.Current_Choice_Kind != Choice_Kind.NONE:
        feskaBuildPool()
        # 候选不足三张时不开牌, 保证界面索引不会读到空值。
        if len(Target_Player.Candidate_Upgrade_Ids) < 3:
            Target_Player.Current_Choice_Kind = Choice_Kind.NONE
            Target_Player.Card_Upgrade_Ids = []
        else:
            Target_Player.Card_Upgrade_Ids = random.shuffle(Target_Player.Candidate_Upgrade_Ids).slice(0, 3)


rule "Feska - Initialize player":
    @Event eachPlayer
    @Team 2
    @Condition not eventPlayer.isDummy()
    @Condition not eventPlayer.Is_Initialized

    eventPlayer.Owned_Tech_Ids = []
    eventPlayer.Bonus_By_Stat = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    # 首次生成时没有任何本模式生命池与 setMaxHealth 修改, 读取到的就是英雄原始最大生命。
    eventPlayer.Base_Max_Health = eventPlayer.getMaxHealth()
    eventPlayer.Card_Upgrade_Ids = []
    eventPlayer.Candidate_Upgrade_Ids = []
    eventPlayer.Pending_Stat_Upgrade_Count = 0
    eventPlayer.Taken_Stat_Upgrade_Count = 0
    eventPlayer.Current_Choice_Kind = Choice_Kind.NONE
    eventPlayer.Chosen_Upgrade_Id = null
    eventPlayer.Is_Card_Panel_Visible = true
    eventPlayer.Is_Choice_Locked = false
    eventPlayer.Selected_Card_Index = 0
    eventPlayer.Card_Rerolled_Flags = [false, false, false]
    eventPlayer.Restored_For_Hero = eventPlayer.getHero()
    eventPlayer.Needs_Stat_Restore = false
    eventPlayer.Armor_Health_Pool = null
    eventPlayer.Elimination_Baseline = 0
    eventPlayer.Heartsteel_Flat_Health = 0
    eventPlayer.Heartsteel_Stacks = 0
    eventPlayer.Heartsteel_Health_Pool = null
    eventPlayer.Shield_Health_Pool = null
    eventPlayer.Regeneration_Health_Pool = null
    eventPlayer.Victory_Will_Used_This_Wave = false
    eventPlayer.Is_Alone = false
    eventPlayer.Is_Spawning_Derived_Damage = false
    eventPlayer.Is_Berserk = false
    eventPlayer.Is_Berserk_Guard_Armed = false
    eventPlayer.Damage_Modification_Id = null
    eventPlayer.Received_Modification_Id = null
    eventPlayer.Sword_Range_Modification_Id = null
    eventPlayer.Damage_Modification_Percent = 0
    eventPlayer.Received_Modification_Percent = 100
    feskaRefreshMods()
    eventPlayer.Is_Initialized = true


rule "Feska - Release player modifier":
    @Event playerLeft
    @Team 2
    @Condition eventPlayer.Is_Initialized

    if eventPlayer.Damage_Modification_Id != null:
        stopDamageModification(eventPlayer.Damage_Modification_Id)
    if eventPlayer.Received_Modification_Id != null:
        stopDamageModification(eventPlayer.Received_Modification_Id)
    if eventPlayer.Sword_Range_Modification_Id != null:
        stopDamageModification(eventPlayer.Sword_Range_Modification_Id)
    eventPlayer.Damage_Modification_Id = null
    eventPlayer.Received_Modification_Id = null
    eventPlayer.Sword_Range_Modification_Id = null
    if Tech_Id.SHIELD in eventPlayer.Owned_Tech_Ids:
        # 持有者离场则科技失效: 清掉其他玩家身上本来源的护盾池, 不留常驻残血池。
        Player_List = getPlayers(Team.2)
        for Loop_Index in range(len(Player_List)):
            if Player_List[Loop_Index].Shield_Health_Pool != null:
                removeHealthPool(Player_List[Loop_Index].Shield_Health_Pool)
            Player_List[Loop_Index].Shield_Health_Pool = null


rule "Feska - Offer upgrade":
    @Event eachPlayer
    @Team 2
    @Condition eventPlayer.Is_Initialized
    @Condition isGameInProgress()
    @Condition not Is_Attack_Phase
    @Condition not eventPlayer.Is_Choice_Locked
    @Condition eventPlayer.Current_Choice_Kind == Choice_Kind.NONE
    @Condition (len(eventPlayer.Owned_Tech_Ids) < MAX_TECH_COUNT and len(eventPlayer.Owned_Tech_Ids) < feskaTechAllowance()) or (len(eventPlayer.Owned_Tech_Ids) == MAX_TECH_COUNT and eventPlayer.Pending_Stat_Upgrade_Count > 0)

    Target_Player = eventPlayer
    feskaDealCards()


rule "Feska - Toggle selection":
    @Event eachPlayer
    @Team 2
    @Condition not eventPlayer.Is_Choice_Locked
    @Condition eventPlayer.Current_Choice_Kind != Choice_Kind.NONE
    @Condition eventPlayer.isHoldingButton(Button.INTERACT)

    eventPlayer.Is_Card_Panel_Visible = not eventPlayer.Is_Card_Panel_Visible


rule "Feska - Next card":
    @Event eachPlayer
    @Team 2
    @Condition not eventPlayer.Is_Choice_Locked
    @Condition eventPlayer.Current_Choice_Kind != Choice_Kind.NONE
    @Condition eventPlayer.Is_Card_Panel_Visible
    @Condition eventPlayer.isHoldingButton(Button.MELEE)

    eventPlayer.Selected_Card_Index = (eventPlayer.Selected_Card_Index + 1) % 3


rule "Feska - Reroll card":
    @Event eachPlayer
    @Team 2
    @Condition not eventPlayer.Is_Choice_Locked
    @Condition eventPlayer.Current_Choice_Kind != Choice_Kind.NONE
    @Condition eventPlayer.Is_Card_Panel_Visible
    @Condition eventPlayer.isHoldingButton(Button.RELOAD)

    if eventPlayer.Card_Rerolled_Flags[eventPlayer.Selected_Card_Index]:
        smallMessage(eventPlayer, "这张卡已刷新过")
    else:
        Target_Player = eventPlayer
        feskaBuildPool()
        Reroll_Candidates = Target_Player.Candidate_Upgrade_Ids.filter(lambda upgrade: upgrade not in eventPlayer.Card_Upgrade_Ids)
        if len(Reroll_Candidates) == 0:
            smallMessage(eventPlayer, "没有可刷新的卡")
            return
        eventPlayer.Card_Upgrade_Ids[eventPlayer.Selected_Card_Index] = random.choice(Reroll_Candidates)
        eventPlayer.Card_Rerolled_Flags[eventPlayer.Selected_Card_Index] = true


rule "Feska - Replace taken unique card":
    @Event eachPlayer
    @Team 2
    @Condition not eventPlayer.Is_Choice_Locked
    @Condition eventPlayer.Current_Choice_Kind == Choice_Kind.TECH
    @Condition len(shieldTechHolders()) > 0
    @Condition Tech_Id.SHIELD in eventPlayer.Card_Upgrade_Ids

    # 唯一科技被其他玩家先选走后, 在场候选也要换掉, 不能只在抽取时过滤。
    Target_Player = eventPlayer
    feskaBuildPool()
    Reroll_Candidates = Target_Player.Candidate_Upgrade_Ids.filter(lambda upgrade: upgrade not in eventPlayer.Card_Upgrade_Ids)
    if len(Reroll_Candidates) > 0:
        for Loop_Index in range(3):
            if eventPlayer.Card_Upgrade_Ids[Loop_Index] == Tech_Id.SHIELD:
                eventPlayer.Card_Upgrade_Ids[Loop_Index] = random.choice(Reroll_Candidates)


rule "Feska - Confirm card":
    @Event eachPlayer
    @Team 2
    @Condition eventPlayer.isAlive()
    @Condition not eventPlayer.Is_Choice_Locked
    @Condition eventPlayer.Current_Choice_Kind != Choice_Kind.NONE
    @Condition eventPlayer.Is_Card_Panel_Visible
    @Condition eventPlayer.isHoldingButton(Button.CROUCH)

    # 确认期间上锁; 等待忽略条件, 结束后再核对按键, 防止松手后仍被确认。
    eventPlayer.Is_Choice_Locked = true
    wait(0.35, Wait.IGNORE_CONDITION)
    if not eventPlayer.isAlive() or not eventPlayer.isHoldingButton(Button.CROUCH):
        eventPlayer.Is_Choice_Locked = false
        return
    eventPlayer.Chosen_Upgrade_Id = eventPlayer.Card_Upgrade_Ids[eventPlayer.Selected_Card_Index]
    if eventPlayer.Current_Choice_Kind == Choice_Kind.TECH:
        if eventPlayer.Chosen_Upgrade_Id == Tech_Id.SHIELD and len(shieldTechHolders()) > 0:
            smallMessage(eventPlayer, "该科技已被其他玩家选走")
            eventPlayer.Current_Choice_Kind = Choice_Kind.NONE
            eventPlayer.Is_Card_Panel_Visible = true
            eventPlayer.Is_Choice_Locked = false
            return
        if eventPlayer.Chosen_Upgrade_Id == Tech_Id.NO_ULTIMATE and (Tech_Id.ULTIMATE_CHARGE in eventPlayer.Owned_Tech_Ids or Tech_Id.FREEZE_ALL in eventPlayer.Owned_Tech_Ids or eventPlayer.Bonus_By_Stat[Stat_Bonus.ULTIMATE_CHARGE] > 0):
            smallMessage(eventPlayer, "与已持有的科技冲突")
            eventPlayer.Current_Choice_Kind = Choice_Kind.NONE
            eventPlayer.Is_Card_Panel_Visible = true
            eventPlayer.Is_Choice_Locked = false
            return
        eventPlayer.Owned_Tech_Ids.append(eventPlayer.Chosen_Upgrade_Id)
    else:
        if eventPlayer.Chosen_Upgrade_Id == Stat_Upgrade_Id.ULTIMATE_CHARGE and Tech_Id.NO_ULTIMATE in eventPlayer.Owned_Tech_Ids:
            smallMessage(eventPlayer, "与已持有的科技冲突")
            eventPlayer.Current_Choice_Kind = Choice_Kind.NONE
            eventPlayer.Is_Card_Panel_Visible = true
            eventPlayer.Is_Choice_Locked = false
            return
        eventPlayer.Pending_Stat_Upgrade_Count -= 1
        eventPlayer.Taken_Stat_Upgrade_Count += 1
        # 属性强化可重复选择且没有"持有"状态, 无法用科技的条件触发, 只能在选牌处累加。
        eventPlayer.Bonus_By_Stat[Stat_Bonus.DAMAGE] += Upgrade_Catalog[eventPlayer.Chosen_Upgrade_Id][UPGRADE_COLUMN_DAMAGE]
        eventPlayer.Bonus_By_Stat[Stat_Bonus.HEALTH] += Upgrade_Catalog[eventPlayer.Chosen_Upgrade_Id][UPGRADE_COLUMN_HEALTH]
        eventPlayer.Bonus_By_Stat[Stat_Bonus.HEALING] += Upgrade_Catalog[eventPlayer.Chosen_Upgrade_Id][UPGRADE_COLUMN_HEALING]
        feskaApplyUpgradeStats()
    Target_Player = eventPlayer
    # 科技数值由各科技文件在自己的规则里累加 Bonus_By_Stat 后调用 feskaApplyUpgradeStats();
    # 条件由假变真即"获得科技", 科技不移除所以只触发一次。
    if eventPlayer.Chosen_Upgrade_Id == Tech_Id.SHIELD:
        feskaRefreshShields()
    elif eventPlayer.Chosen_Upgrade_Id == Tech_Id.HEARTSTEEL:
        # 只统计获得该科技之后的消灭, 不追认此前累计的统计值。
        eventPlayer.Elimination_Baseline = eventPlayer.getNumberOfElims()
    elif eventPlayer.Chosen_Upgrade_Id == Stat_Upgrade_Id.ARMOR:
        eventPlayer.Bonus_By_Stat[Stat_Bonus.ARMOR] += 1
        feskaApplyArmorPool()
    elif eventPlayer.Chosen_Upgrade_Id == Stat_Upgrade_Id.DAMAGE_REDUCTION:
        # 成长系统减伤总上限 50%, 避免重复选择后完全免伤。
        eventPlayer.Bonus_By_Stat[Stat_Bonus.DAMAGE_REDUCTION] = min(eventPlayer.Bonus_By_Stat[Stat_Bonus.DAMAGE_REDUCTION] + 3, 50)
        feskaRefreshMods()
    elif eventPlayer.Chosen_Upgrade_Id == Stat_Upgrade_Id.REGENERATION:
        eventPlayer.Bonus_By_Stat[Stat_Bonus.REGENERATION] += 1
    elif eventPlayer.Chosen_Upgrade_Id == Stat_Upgrade_Id.HEALING_RECEIVED:
        eventPlayer.Bonus_By_Stat[Stat_Bonus.HEALING_RECEIVED] += 1
        eventPlayer.setHealingReceived(100 + 10 * eventPlayer.Bonus_By_Stat[Stat_Bonus.HEALING_RECEIVED])
    elif eventPlayer.Chosen_Upgrade_Id == Stat_Upgrade_Id.ULTIMATE_CHARGE:
        eventPlayer.Bonus_By_Stat[Stat_Bonus.ULTIMATE_CHARGE] += 1
    elif eventPlayer.Chosen_Upgrade_Id == Stat_Upgrade_Id.KNOCKBACK_RESISTANCE:
        eventPlayer.Bonus_By_Stat[Stat_Bonus.KNOCKBACK_RESISTANCE] = min(eventPlayer.Bonus_By_Stat[Stat_Bonus.KNOCKBACK_RESISTANCE] + 1, 8)
        eventPlayer.setKnockbackReceived(100 - 10 * eventPlayer.Bonus_By_Stat[Stat_Bonus.KNOCKBACK_RESISTANCE])
    Target_Player = eventPlayer
    smallMessage(eventPlayer, "已选择：{0}".format(Upgrade_Catalog[eventPlayer.Chosen_Upgrade_Id][UPGRADE_COLUMN_NAME]))
    eventPlayer.Card_Upgrade_Ids = []
    eventPlayer.Current_Choice_Kind = Choice_Kind.NONE
    eventPlayer.Is_Card_Panel_Visible = false
    # 必须真正松开蹲才能确认下一次; 不设超时, 防止长按跨多次发牌连续误选积攒的奖励。
    waitUntil(not eventPlayer.isHoldingButton(Button.CROUCH))
    eventPlayer.Is_Choice_Locked = false
    eventPlayer.Is_Card_Panel_Visible = true


rule "Feska - Restore stats on hero change or respawn":
    @Event eachPlayer
    @Team 2
    @Condition eventPlayer.Is_Initialized
    @Condition eventPlayer.isAlive()
    @Condition eventPlayer.hasSpawned()
    @Condition eventPlayer.Restored_For_Hero != eventPlayer.getHero() or eventPlayer.Needs_Stat_Restore

    # 先清理本模式生命池: 生命池是否跨死亡/换英雄保留未在工坊文档中明确, 先移除再重建,
    # 避免旧池若保留下来导致每次重生多叠一层。
    if eventPlayer.Armor_Health_Pool != null:
        removeHealthPool(eventPlayer.Armor_Health_Pool)
    if eventPlayer.Heartsteel_Health_Pool != null:
        removeHealthPool(eventPlayer.Heartsteel_Health_Pool)
    if eventPlayer.Shield_Health_Pool != null:
        removeHealthPool(eventPlayer.Shield_Health_Pool)
    if eventPlayer.Regeneration_Health_Pool != null:
        removeHealthPool(eventPlayer.Regeneration_Health_Pool)
    if eventPlayer.Reactive_Armor_Health_Pool != null:
        removeHealthPool(eventPlayer.Reactive_Armor_Health_Pool)
    eventPlayer.Armor_Health_Pool = null
    eventPlayer.Heartsteel_Health_Pool = null
    eventPlayer.Shield_Health_Pool = null
    eventPlayer.Regeneration_Health_Pool = null
    eventPlayer.Reactive_Armor_Health_Pool = null
    # stat_dirty 是死亡后的重生路径; 英雄确实变了才是真正换英雄。
    # 换英雄后工坊重置 setMaxHealth 百分比, 清理生命池后读到的 getMaxHealth() 即新英雄原始最大生命。
    if eventPlayer.Restored_For_Hero != eventPlayer.getHero():
        eventPlayer.Base_Max_Health = eventPlayer.getMaxHealth()
    eventPlayer.Restored_For_Hero = eventPlayer.getHero()
    eventPlayer.Needs_Stat_Restore = false
    eventPlayer.Is_Choice_Locked = false
    # 换英雄/重生都结束狂战士; 若仍在进攻阶段, 重新套上定点油门(狂战士之前解除过)。
    Target_Player = eventPlayer
    feskaStopBerserk()
    if Is_Attack_Phase:
        eventPlayer.startForcingThrottle(0, 0.01, 0, 0.01, 0, 0.01)
    # setMaxHealth 的参数是百分比, 不是生命点数; 点数口径见 feskaMaxHealth。
    eventPlayer.setMaxHealth(feskaHealthPercent(eventPlayer))
    if Tech_Id.GIANT in eventPlayer.Owned_Tech_Ids or Tech_Id.HEARTSTEEL in eventPlayer.Owned_Tech_Ids:
        eventPlayer.startScalingSize((1.3 if Tech_Id.GIANT in eventPlayer.Owned_Tech_Ids else 1) + 0.05 * eventPlayer.Heartsteel_Stacks, false)
    eventPlayer.setHealingDealt(100 + eventPlayer.Bonus_By_Stat[Stat_Bonus.HEALING])
    # 重生/换英雄会清掉英雄属性修改, 这里按累计状态无条件重放, 不能只在有堆叠时恢复。
    eventPlayer.setHealingReceived(100 + 10 * eventPlayer.Bonus_By_Stat[Stat_Bonus.HEALING_RECEIVED])
    eventPlayer.setKnockbackReceived(100 - 10 * eventPlayer.Bonus_By_Stat[Stat_Bonus.KNOCKBACK_RESISTANCE])
    if Tech_Id.NO_ULTIMATE in eventPlayer.Owned_Tech_Ids:
        eventPlayer.setUltEnabled(false)
    Target_Player = eventPlayer
    feskaApplyArmorPool()
    feskaApplyHeartsteelPool()
    feskaApplyShieldToPlayer()
    # 反应装甲的护甲池由 reactive.opy 的补池规则重建, 这里只清旧池句柄(见上)。
    feskaRefreshMods()


rule "Feska - Invalidate hero on death":
    @Event playerDied
    @Team 2

    # 只标记需要重放属性恢复; 不置空 stat_hero, 否则死亡后换英雄会被误判成重生而不重捕基准。
    eventPlayer.Needs_Stat_Restore = true
    eventPlayer.Is_Berserk = false
    eventPlayer.Is_Berserk_Guard_Armed = false
    eventPlayer.Is_Choice_Locked = false


rule "Feska - Wave start":
    @Condition isGameInProgress()
    @Condition Is_Attack_Phase

    wait(0.016)
    getPlayers(Team.2).Victory_Will_Used_This_Wave = false
    feskaRefreshShields()


rule "Feska - Wave end cleanup":
    @Condition isGameInProgress()
    @Condition not Is_Attack_Phase

    Player_List = getPlayers(Team.2)
    for Loop_Index in range(len(Player_List)):
        Target_Player = Player_List[Loop_Index]
        feskaStopBerserk()
        if Player_List[Loop_Index].Regeneration_Health_Pool != null:
            removeHealthPool(Player_List[Loop_Index].Regeneration_Health_Pool)
        Player_List[Loop_Index].Regeneration_Health_Pool = null
        Player_List[Loop_Index].Victory_Will_Used_This_Wave = false


# 科技: 每个科技一个文件, 内含目录行宏(UPGRADE_ROW_*)与该科技的规则。
# include 顺序决定编译后的规则顺序, 所以有规则的科技按原规则顺序排列;
# 只有目录行、没有独立规则的科技不影响规则顺序, 统一放在前面。
#!include "feska/tech/brutal.opy"
#!include "feska/tech/giant.opy"
#!include "feska/tech/healing.opy"
#!include "feska/tech/cannon.opy"
#!include "feska/tech/basics.opy"
#!include "feska/tech/sword.opy"
#!include "feska/tech/aidkit.opy"
#!include "feska/tech/crusader.opy"
#!include "feska/tech/lone.opy"
#!include "feska/tech/repair.opy"
#!include "feska/tech/battery.opy"
#!include "feska/tech/lifesteal.opy"
#!include "feska/tech/heartsteel.opy"
#!include "feska/tech/thorns.opy"
#!include "feska/tech/cooker.opy"
#!include "feska/tech/purge.opy"
#!include "feska/tech/ice.opy"
#!include "feska/tech/sniper.opy"
#!include "feska/tech/freeze_all.opy"
#!include "feska/tech/f5.opy"
#!include "feska/tech/flesh.opy"
#!include "feska/tech/tower.opy"
#!include "feska/tech/will.opy"
#!include "feska/tech/berserk.opy"
#!include "feska/tech/radiant.opy"
#!include "feska/tech/reactive.opy"
#!include "feska/tech/ignite.opy"
#!include "feska/tech/crit.opy"
#!include "feska/tech/ultloop.opy"
#!include "feska/tech/execute.opy"


rule "Feska - Upgrade catalog":
    # 行序必须与 env/vars.opy 的 Tech_Id / Stat_Upgrade_Id 一致, 新条目只追加到末尾。
    Upgrade_Catalog = [
        UPGRADE_ROW_BRUTAL,
        UPGRADE_ROW_GIANT,
        UPGRADE_ROW_HEALING,
        UPGRADE_ROW_SELF_REPAIR,
        UPGRADE_ROW_LIFESTEAL,
        UPGRADE_ROW_THORNS,
        UPGRADE_ROW_PRESSURE_COOKER,
        UPGRADE_ROW_GLASS_CANNON,
        ["属性强化：伤害", "造成的伤害提高 8%", UPGRADE_KIND_STAT, 0, 1, 8, 0, 0, 0, []],
        ["属性强化：生命", "最大生命值提高 12%", UPGRADE_KIND_STAT, 0, 1, 0, 12, 0, 0, []],
        ["属性强化：治疗", "造成的治疗效果提高 12%", UPGRADE_KIND_STAT, 0, 1, 0, 0, 12, 0, []],
        ["属性强化：均衡", "伤害提高 4%\n最大生命值提高 6%", UPGRADE_KIND_STAT, 0, 1, 4, 6, 0, 0, []],
        ["属性强化：共鸣", "伤害提高 4%\n造成的治疗效果提高 6%", UPGRADE_KIND_STAT, 0, 1, 4, 0, 6, 0, []],
        ["属性强化：养护", "最大生命值提高 6%\n造成的治疗效果提高 6%", UPGRADE_KIND_STAT, 0, 1, 0, 6, 6, 0, []],
        UPGRADE_ROW_SOUL_PURGE,
        UPGRADE_ROW_ICE,
        UPGRADE_ROW_NO_ULTIMATE,
        UPGRADE_ROW_DRAW_SWORD,
        UPGRADE_ROW_SNIPER,
        UPGRADE_ROW_FREEZE_ALL,
        UPGRADE_ROW_ABILITY_REFRESH,
        UPGRADE_ROW_HEARTSTEEL,
        UPGRADE_ROW_SHIELD,
        UPGRADE_ROW_FLESH_REGENERATION,
        UPGRADE_ROW_HEALING_TOWER,
        UPGRADE_ROW_VICTORY_WILL,
        UPGRADE_ROW_ULTIMATE_CHARGE,
        UPGRADE_ROW_LONE_WOLF,
        ["属性强化：护甲", "永久获得 25 点可治疗护甲", UPGRADE_KIND_STAT, 0, 1, 0, 0, 0, 0, []],
        ["属性强化：减伤", "受到的伤害降低 3%（上限 50%）", UPGRADE_KIND_STAT, 0, 1, 0, 0, 0, 0, []],
        ["属性强化：再生", "进攻期间，每秒恢复 0.3% 最大生命值", UPGRADE_KIND_STAT, 0, 1, 0, 0, 0, 0, []],
        ["属性强化：受疗", "受到的治疗效果提高 10%", UPGRADE_KIND_STAT, 0, 1, 0, 0, 0, 0, []],
        ["属性强化：充能", "进攻期间，每秒额外获得 0.2% 终极技能充能", UPGRADE_KIND_STAT, 0, 1, 0, 0, 0, 0, []],
        ["属性强化：抗击退", "获得 10% 击退抗性（上限 80%）", UPGRADE_KIND_STAT, 0, 1, 0, 0, 0, 0, []],
        # 索引 34..38 由 vars.opy 的 Tech_Id.FIRST_AID_KIT..Tech_Id.BERSERK 固定, 必须排在属性强化之后。
        UPGRADE_ROW_FIRST_AID_KIT,
        UPGRADE_ROW_RADIANT,
        UPGRADE_ROW_CRUSADER,
        UPGRADE_ROW_REACTIVE,
        UPGRADE_ROW_BERSERK,
        UPGRADE_ROW_IGNITE,
        UPGRADE_ROW_CRIT,
        UPGRADE_ROW_ULTIMATE_LOOP,
        UPGRADE_ROW_EXECUTE
    ]
    Tech_Catalog_Indexes = []
    Stat_Catalog_Indexes = []
    for Loop_Index in range(len(Upgrade_Catalog)):
        if Upgrade_Catalog[Loop_Index][UPGRADE_COLUMN_ENABLED] != 1:
            continue
        if Upgrade_Catalog[Loop_Index][UPGRADE_COLUMN_KIND] == UPGRADE_KIND_STAT:
            Stat_Catalog_Indexes.append(Loop_Index)
        else:
            # 科技与技能强化共用同一抽池; 技能强化再按英雄池过滤。
            Tech_Catalog_Indexes.append(Loop_Index)


# 提示用 HUD 子文本(标题类 HUD 不渲染按键图标); 卡片用世界文本, 名字大、描述小, 不画边框。
rule "Feska - Selection HUD":
    hudSubheader(localPlayer if localPlayer.Current_Choice_Kind != Choice_Kind.NONE and localPlayer.Is_Card_Panel_Visible else [], "选择费斯卡科技（{0}/4）".format(len(localPlayer.Owned_Tech_Ids) + 1) if localPlayer.Current_Choice_Kind == Choice_Kind.TECH else "属性强化（待选 {0} 次）".format(localPlayer.Pending_Stat_Upgrade_Count), HudPosition.TOP, 2, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING)
    hudSubtext(localPlayer if localPlayer.Current_Choice_Kind != Choice_Kind.NONE and localPlayer.Is_Card_Panel_Visible else [], "{0} 切换    长按 {1} 确认".format(inputBindingString(Button.MELEE), inputBindingString(Button.CROUCH)), HudPosition.TOP, 3, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    hudSubtext(localPlayer if localPlayer.Current_Choice_Kind != Choice_Kind.NONE and localPlayer.Is_Card_Panel_Visible else [], "{0} 刷新    {1} 隐藏".format(inputBindingString(Button.RELOAD), inputBindingString(Button.INTERACT)), HudPosition.TOP, 4, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    createInWorldText(localPlayer if localPlayer.Current_Choice_Kind != Choice_Kind.NONE and localPlayer.Is_Card_Panel_Visible else [], "▶ 【{0}】 ◀".format(Upgrade_Catalog[localPlayer.Card_Upgrade_Ids[0]][UPGRADE_COLUMN_NAME]) if localPlayer.Selected_Card_Index == 0 else "【{0}】".format(Upgrade_Catalog[localPlayer.Card_Upgrade_Ids[0]][UPGRADE_COLUMN_NAME]), feskaCardPosition(1.7, 0.4), 2.2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.YELLOW if localPlayer.Selected_Card_Index == 0 else Color.WHITE, SpecVisibility.NEVER)
    createInWorldText(localPlayer if localPlayer.Current_Choice_Kind != Choice_Kind.NONE and localPlayer.Is_Card_Panel_Visible else [], "{0}\n\n刷新 {1}/1".format(Upgrade_Catalog[localPlayer.Card_Upgrade_Ids[0]][UPGRADE_COLUMN_DESCRIPTION], 0 if localPlayer.Card_Rerolled_Flags[0] else 1), feskaCardPosition(1.7, -0.15), 1.1, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.YELLOW if localPlayer.Selected_Card_Index == 0 else Color.WHITE, SpecVisibility.NEVER)
    createInWorldText(localPlayer if localPlayer.Current_Choice_Kind != Choice_Kind.NONE and localPlayer.Is_Card_Panel_Visible else [], "▶ 【{0}】 ◀".format(Upgrade_Catalog[localPlayer.Card_Upgrade_Ids[1]][UPGRADE_COLUMN_NAME]) if localPlayer.Selected_Card_Index == 1 else "【{0}】".format(Upgrade_Catalog[localPlayer.Card_Upgrade_Ids[1]][UPGRADE_COLUMN_NAME]), feskaCardPosition(0, 0.4), 2.2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.YELLOW if localPlayer.Selected_Card_Index == 1 else Color.WHITE, SpecVisibility.NEVER)
    createInWorldText(localPlayer if localPlayer.Current_Choice_Kind != Choice_Kind.NONE and localPlayer.Is_Card_Panel_Visible else [], "{0}\n\n刷新 {1}/1".format(Upgrade_Catalog[localPlayer.Card_Upgrade_Ids[1]][UPGRADE_COLUMN_DESCRIPTION], 0 if localPlayer.Card_Rerolled_Flags[1] else 1), feskaCardPosition(0, -0.15), 1.1, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.YELLOW if localPlayer.Selected_Card_Index == 1 else Color.WHITE, SpecVisibility.NEVER)
    createInWorldText(localPlayer if localPlayer.Current_Choice_Kind != Choice_Kind.NONE and localPlayer.Is_Card_Panel_Visible else [], "▶ 【{0}】 ◀".format(Upgrade_Catalog[localPlayer.Card_Upgrade_Ids[2]][UPGRADE_COLUMN_NAME]) if localPlayer.Selected_Card_Index == 2 else "【{0}】".format(Upgrade_Catalog[localPlayer.Card_Upgrade_Ids[2]][UPGRADE_COLUMN_NAME]), feskaCardPosition(-1.7, 0.4), 2.2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.YELLOW if localPlayer.Selected_Card_Index == 2 else Color.WHITE, SpecVisibility.NEVER)
    createInWorldText(localPlayer if localPlayer.Current_Choice_Kind != Choice_Kind.NONE and localPlayer.Is_Card_Panel_Visible else [], "{0}\n\n刷新 {1}/1".format(Upgrade_Catalog[localPlayer.Card_Upgrade_Ids[2]][UPGRADE_COLUMN_DESCRIPTION], 0 if localPlayer.Card_Rerolled_Flags[2] else 1), feskaCardPosition(-1.7, -0.15), 1.1, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.YELLOW if localPlayer.Selected_Card_Index == 2 else Color.WHITE, SpecVisibility.NEVER)
