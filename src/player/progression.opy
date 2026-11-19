#!mainFile "../main.opy"

def feskaRefreshMods():
    @Name "Feska - refresh damage modifiers"

    if eventPlayer.damage_mod == null or eventPlayer.damage_value != feskaDamagePercent(eventPlayer):
        if eventPlayer.damage_mod != null:
            stopDamageModification(eventPlayer.damage_mod)
        startDamageModification(getPlayers(Team.1), eventPlayer, feskaDamagePercent(eventPlayer), DamageReeval.RECEIVERS_DAMAGERS_AND_DMGPERCENT)
        eventPlayer.damage_mod = getLastDamageModification()
        eventPlayer.damage_value = feskaDamagePercent(eventPlayer)
    if feskaReceivedPercent(eventPlayer) >= 100:
        if eventPlayer.recv_mod != null:
            stopDamageModification(eventPlayer.recv_mod)
            eventPlayer.recv_mod = null
        eventPlayer.recv_value = 100
    elif eventPlayer.recv_mod == null or eventPlayer.recv_value != feskaReceivedPercent(eventPlayer):
        if eventPlayer.recv_mod != null:
            stopDamageModification(eventPlayer.recv_mod)
        startDamageModification(eventPlayer, getPlayers(Team.1), feskaReceivedPercent(eventPlayer), DamageReeval.RECEIVERS_DAMAGERS_AND_DMGPERCENT)
        eventPlayer.recv_mod = getLastDamageModification()
        eventPlayer.recv_value = feskaReceivedPercent(eventPlayer)


def feskaApplyUpgradeStats():
    @Name "Feska - apply upgrade stats"

    # 纯数值科技在各自文件里累加 bonus 后调用这里, 保证只有一个属性写入点。
    # 科技只累加不移除, 重放仍由 Restore stats 规则负责。
    eventPlayer.setMaxHealth(feskaHealthPercent(eventPlayer))
    eventPlayer.setHealingDealt(100 + eventPlayer.bonus[FeskaBonus.HEALING])
    feskaRefreshMods()


def feskaStopBerserk():
    @Name "Feska - stop berserk"

    # 结束(波次切换/换英雄)时恢复正常生命口径与禁疗; 移动约束由对应阶段的规则恢复。
    if Target_Player.berserk == true:
        Target_Player.berserk = false
        Target_Player.setMaxHealth(feskaHealthPercent(Target_Player))
        Target_Player.setHealingReceived(100 + 10 * Target_Player.bonus[FeskaBonus.HEALING_RECEIVED])
        Target_Player.setKnockbackReceived(100 - 10 * Target_Player.bonus[FeskaBonus.KNOCKBACK_RESIST])


def feskaRefreshShields():
    @Name "Feska - refresh photon shields"

    if len(shieldHolders()) > 0:
        P = getLivingPlayers(Team.2).filter(lambda player: not player.isDummy())
        for Work_Index in range(len(P)):
            Target_Player = P[Work_Index]
            feskaApplyShieldToPlayer()


def feskaBuildPool():
    @Name "Feska - build candidate pool"

    if Target_Player.choice_type == 1:
        Target_Player.pool = Tech_Ids.filter(lambda upgrade: upgrade not in Target_Player.tech and not (upgrade == TechId.BASICS and (TechId.BATTERY in Target_Player.tech or TechId.FREEZE_ALL in Target_Player.tech or Target_Player.bonus[FeskaBonus.ULT_CHARGE] > 0)) and not (upgrade in [TechId.FREEZE_ALL, TechId.BATTERY] and TechId.BASICS in Target_Player.tech))
        if len(shieldHolders()) > 0:
            Target_Player.pool = Target_Player.pool.filter(lambda upgrade: upgrade != TechId.SHIELD)
    else:
        Target_Player.pool = Stat_Ids.filter(lambda upgrade: not (upgrade == StatId.ULT and TechId.BASICS in Target_Player.tech))


def feskaDealCards():
    @Name "Feska - deal cards"

    Target_Player.cursor = 0
    Target_Player.rerolled = [false, false, false]
    Target_Player.visible = true
    if len(Target_Player.tech) < MAX_TECH and len(Target_Player.tech) < floor(Completed_Attacks / 2):
        Target_Player.choice_type = 1
    elif len(Target_Player.tech) == MAX_TECH and Target_Player.forge_pending > 0:
        Target_Player.choice_type = 2
    else:
        Target_Player.choice_type = 0
    if Target_Player.choice_type != 0:
        feskaBuildPool()
        # 候选不足三张时不开牌, 保证界面索引不会读到空值。
        if len(Target_Player.pool) < 3:
            Target_Player.choice_type = 0
            Target_Player.options = []
        else:
            Target_Player.options = random.shuffle(Target_Player.pool).slice(0, 3)


rule "Feska - Initialize player":
    @Event eachPlayer
    @Team 2
    @Condition not eventPlayer.isDummy()
    @Condition not eventPlayer.initialized

    eventPlayer.tech = []
    eventPlayer.bonus = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    # 首次生成时没有任何本模式生命池与 setMaxHealth 修改, 读取到的就是英雄原始最大生命。
    eventPlayer.base_hp = eventPlayer.getMaxHealth()
    eventPlayer.options = []
    eventPlayer.pool = []
    eventPlayer.forge_pending = 0
    eventPlayer.forge_count = 0
    eventPlayer.choice_type = 0
    eventPlayer.choice = null
    eventPlayer.visible = true
    eventPlayer.lock = false
    eventPlayer.cursor = 0
    eventPlayer.rerolled = [false, false, false]
    eventPlayer.stat_hero = eventPlayer.getHero()
    eventPlayer.stat_dirty = false
    eventPlayer.armor_pool = null
    eventPlayer.elim_mark = 0
    eventPlayer.heartsteel_flat = 0
    eventPlayer.heartsteel_pool = null
    eventPlayer.shield_pool = null
    eventPlayer.blood_pool = null
    eventPlayer.will_used = false
    eventPlayer.lone = false
    eventPlayer.chain = false
    eventPlayer.berserk = false
    eventPlayer.berserk_guard = false
    eventPlayer.damage_mod = null
    eventPlayer.recv_mod = null
    eventPlayer.damage_value = 0
    eventPlayer.recv_value = 100
    feskaRefreshMods()
    eventPlayer.initialized = true


rule "Feska - Release player modifier":
    @Event playerLeft
    @Team 2
    @Condition eventPlayer.initialized

    if eventPlayer.damage_mod != null:
        stopDamageModification(eventPlayer.damage_mod)
    if eventPlayer.recv_mod != null:
        stopDamageModification(eventPlayer.recv_mod)
    eventPlayer.damage_mod = null
    eventPlayer.recv_mod = null
    if TechId.SHIELD in eventPlayer.tech:
        # 持有者离场则科技失效: 清掉其他玩家身上本来源的护盾池, 不留常驻残血池。
        P = getPlayers(Team.2)
        for Work_Index in range(len(P)):
            if P[Work_Index].shield_pool != null:
                removeHealthPool(P[Work_Index].shield_pool)
            P[Work_Index].shield_pool = null


rule "Feska - Offer upgrade":
    @Event eachPlayer
    @Team 2
    @Condition eventPlayer.initialized
    @Condition isGameInProgress()
    @Condition not Under_Attack
    @Condition not eventPlayer.lock
    @Condition eventPlayer.choice_type == 0
    @Condition (len(eventPlayer.tech) < MAX_TECH and len(eventPlayer.tech) < floor(Completed_Attacks / 2)) or (len(eventPlayer.tech) == MAX_TECH and eventPlayer.forge_pending > 0)

    Target_Player = eventPlayer
    feskaDealCards()


rule "Feska - Toggle selection":
    @Event eachPlayer
    @Team 2
    @Condition not Under_Attack
    @Condition not eventPlayer.lock
    @Condition eventPlayer.choice_type != 0
    @Condition eventPlayer.isHoldingButton(Button.INTERACT)

    eventPlayer.visible = not eventPlayer.visible


rule "Feska - Next card":
    @Event eachPlayer
    @Team 2
    @Condition not Under_Attack
    @Condition not eventPlayer.lock
    @Condition eventPlayer.choice_type != 0
    @Condition eventPlayer.visible
    @Condition eventPlayer.isHoldingButton(Button.MELEE)

    eventPlayer.cursor = (eventPlayer.cursor + 1) % 3


rule "Feska - Reroll card":
    @Event eachPlayer
    @Team 2
    @Condition not Under_Attack
    @Condition not eventPlayer.lock
    @Condition eventPlayer.choice_type != 0
    @Condition eventPlayer.visible
    @Condition eventPlayer.isHoldingButton(Button.RELOAD)

    if eventPlayer.rerolled[eventPlayer.cursor]:
        smallMessage(eventPlayer, "这张卡已刷新过")
    else:
        Target_Player = eventPlayer
        feskaBuildPool()
        C = Target_Player.pool.filter(lambda upgrade: upgrade not in eventPlayer.options)
        if len(C) == 0:
            smallMessage(eventPlayer, "没有可刷新的卡")
            return
        eventPlayer.options[eventPlayer.cursor] = random.choice(C)
        eventPlayer.rerolled[eventPlayer.cursor] = true


rule "Feska - Replace taken unique card":
    @Event eachPlayer
    @Team 2
    @Condition not Under_Attack
    @Condition not eventPlayer.lock
    @Condition eventPlayer.choice_type == 1
    @Condition len(shieldHolders()) > 0
    @Condition TechId.SHIELD in eventPlayer.options

    # 唯一科技被其他玩家先选走后, 在场候选也要换掉, 不能只在抽取时过滤。
    Target_Player = eventPlayer
    feskaBuildPool()
    C = Target_Player.pool.filter(lambda upgrade: upgrade not in eventPlayer.options)
    if len(C) > 0:
        for Work_Index in range(3):
            if eventPlayer.options[Work_Index] == TechId.SHIELD:
                eventPlayer.options[Work_Index] = random.choice(C)


rule "Feska - Confirm card":
    @Event eachPlayer
    @Team 2
    @Condition not Under_Attack
    @Condition eventPlayer.isAlive()
    @Condition not eventPlayer.lock
    @Condition eventPlayer.choice_type != 0
    @Condition eventPlayer.visible
    @Condition eventPlayer.isHoldingButton(Button.CROUCH)

    # 确认期间上锁; 等待忽略条件, 结束后再核对阶段与按键, 防止跨阶段误选。
    eventPlayer.lock = true
    wait(0.35, Wait.IGNORE_CONDITION)
    if Under_Attack or not eventPlayer.isAlive() or not eventPlayer.isHoldingButton(Button.CROUCH):
        eventPlayer.lock = false
        return
    eventPlayer.choice = eventPlayer.options[eventPlayer.cursor]
    if eventPlayer.choice_type == 1:
        if eventPlayer.choice == TechId.SHIELD and len(shieldHolders()) > 0:
            smallMessage(eventPlayer, "该科技已被其他玩家选走")
            eventPlayer.choice_type = 0
            eventPlayer.visible = true
            eventPlayer.lock = false
            return
        if eventPlayer.choice == TechId.BASICS and (TechId.BATTERY in eventPlayer.tech or TechId.FREEZE_ALL in eventPlayer.tech or eventPlayer.bonus[FeskaBonus.ULT_CHARGE] > 0):
            smallMessage(eventPlayer, "与已持有的科技冲突")
            eventPlayer.choice_type = 0
            eventPlayer.visible = true
            eventPlayer.lock = false
            return
        eventPlayer.tech.append(eventPlayer.choice)
    else:
        if eventPlayer.choice == StatId.ULT and TechId.BASICS in eventPlayer.tech:
            smallMessage(eventPlayer, "与已持有的科技冲突")
            eventPlayer.choice_type = 0
            eventPlayer.visible = true
            eventPlayer.lock = false
            return
        eventPlayer.forge_pending -= 1
        eventPlayer.forge_count += 1
        # 属性强化可重复选择且没有"持有"状态, 无法用科技的条件触发, 只能在选牌处累加。
        eventPlayer.bonus[FeskaBonus.DAMAGE] += Upgrades[eventPlayer.choice][UPGRADE_COL_DAMAGE]
        eventPlayer.bonus[FeskaBonus.HEALTH] += Upgrades[eventPlayer.choice][UPGRADE_COL_HEALTH]
        eventPlayer.bonus[FeskaBonus.HEALING] += Upgrades[eventPlayer.choice][UPGRADE_COL_HEALING]
        feskaApplyUpgradeStats()
    Target_Player = eventPlayer
    # 科技数值由各科技文件在自己的规则里累加 bonus 后调用 feskaApplyUpgradeStats();
    # 条件由假变真即"获得科技", 科技不移除所以只触发一次。
    if eventPlayer.choice == TechId.SHIELD:
        feskaRefreshShields()
    elif eventPlayer.choice == TechId.HEARTSTEEL:
        # 只统计获得该科技之后的消灭, 不追认此前累计的统计值。
        eventPlayer.elim_mark = eventPlayer.getNumberOfElims()
    elif eventPlayer.choice == StatId.ARMOR:
        eventPlayer.bonus[FeskaBonus.ARMOR] += 1
        feskaApplyArmorPool()
    elif eventPlayer.choice == StatId.DR:
        # 成长系统减伤总上限 50%, 避免重复选择后完全免伤。
        eventPlayer.bonus[FeskaBonus.DAMAGE_REDUCTION] = min(eventPlayer.bonus[FeskaBonus.DAMAGE_REDUCTION] + 3, 50)
        feskaRefreshMods()
    elif eventPlayer.choice == StatId.REGEN:
        eventPlayer.bonus[FeskaBonus.REGEN] += 1
    elif eventPlayer.choice == StatId.HEAL_RECEIVED:
        eventPlayer.bonus[FeskaBonus.HEALING_RECEIVED] += 1
        eventPlayer.setHealingReceived(100 + 10 * eventPlayer.bonus[FeskaBonus.HEALING_RECEIVED])
    elif eventPlayer.choice == StatId.ULT:
        eventPlayer.bonus[FeskaBonus.ULT_CHARGE] += 1
    elif eventPlayer.choice == StatId.KBR:
        eventPlayer.bonus[FeskaBonus.KNOCKBACK_RESIST] = min(eventPlayer.bonus[FeskaBonus.KNOCKBACK_RESIST] + 1, 8)
        eventPlayer.setKnockbackReceived(100 - 10 * eventPlayer.bonus[FeskaBonus.KNOCKBACK_RESIST])
    Target_Player = eventPlayer
    smallMessage(eventPlayer, "已选择：{0}".format(Upgrades[eventPlayer.choice][UPGRADE_COL_NAME]))
    eventPlayer.options = []
    eventPlayer.choice_type = 0
    eventPlayer.visible = false
    # 必须真正松开蹲才能确认下一次; 不设超时, 防止长按跨多次发牌连续误选积攒的奖励。
    waitUntil(not eventPlayer.isHoldingButton(Button.CROUCH))
    eventPlayer.lock = false
    eventPlayer.visible = true


rule "Feska - Restore stats on hero change or respawn":
    @Event eachPlayer
    @Team 2
    @Condition eventPlayer.initialized
    @Condition eventPlayer.isAlive()
    @Condition eventPlayer.hasSpawned()
    @Condition eventPlayer.stat_hero != eventPlayer.getHero() or eventPlayer.stat_dirty

    # 先清理本模式生命池: 生命池是否跨死亡/换英雄保留未在工坊文档中明确, 先移除再重建,
    # 避免旧池若保留下来导致每次重生多叠一层。
    if eventPlayer.armor_pool != null:
        removeHealthPool(eventPlayer.armor_pool)
    if eventPlayer.heartsteel_pool != null:
        removeHealthPool(eventPlayer.heartsteel_pool)
    if eventPlayer.shield_pool != null:
        removeHealthPool(eventPlayer.shield_pool)
    if eventPlayer.blood_pool != null:
        removeHealthPool(eventPlayer.blood_pool)
    if eventPlayer.reactive_pool != null:
        removeHealthPool(eventPlayer.reactive_pool)
    eventPlayer.armor_pool = null
    eventPlayer.heartsteel_pool = null
    eventPlayer.shield_pool = null
    eventPlayer.blood_pool = null
    eventPlayer.reactive_pool = null
    # stat_dirty 是死亡后的重生路径; 英雄确实变了才是真正换英雄。
    # 换英雄后工坊重置 setMaxHealth 百分比, 清理生命池后读到的 getMaxHealth() 即新英雄原始最大生命。
    if eventPlayer.stat_hero != eventPlayer.getHero():
        eventPlayer.base_hp = eventPlayer.getMaxHealth()
    eventPlayer.stat_hero = eventPlayer.getHero()
    eventPlayer.stat_dirty = false
    eventPlayer.lock = false
    # 换英雄/重生都结束狂战士; 若仍在进攻阶段, 重新套上定点油门(狂战士之前解除过)。
    Target_Player = eventPlayer
    feskaStopBerserk()
    if Under_Attack:
        eventPlayer.startForcingThrottle(0, 0.01, 0, 0.01, 0, 0.01)
    # setMaxHealth 的参数是百分比, 不是生命点数; 点数口径见 feskaMaxHP。
    eventPlayer.setMaxHealth(feskaHealthPercent(eventPlayer))
    eventPlayer.setHealingDealt(100 + eventPlayer.bonus[FeskaBonus.HEALING])
    # 重生/换英雄会清掉英雄属性修改, 这里按累计状态无条件重放, 不能只在有堆叠时恢复。
    eventPlayer.setHealingReceived(100 + 10 * eventPlayer.bonus[FeskaBonus.HEALING_RECEIVED])
    eventPlayer.setKnockbackReceived(100 - 10 * eventPlayer.bonus[FeskaBonus.KNOCKBACK_RESIST])
    if TechId.BASICS in eventPlayer.tech:
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
    eventPlayer.stat_dirty = true
    eventPlayer.berserk = false
    eventPlayer.berserk_guard = false
    eventPlayer.lock = false


rule "Feska - Wave start":
    @Condition isGameInProgress()
    @Condition Under_Attack

    wait(0.016)
    getPlayers(Team.2).will_used = false
    feskaRefreshShields()


rule "Feska - Wave end cleanup":
    @Condition isGameInProgress()
    @Condition not Under_Attack

    P = getPlayers(Team.2)
    for Work_Index in range(len(P)):
        Target_Player = P[Work_Index]
        feskaStopBerserk()
        if P[Work_Index].blood_pool != null:
            removeHealthPool(P[Work_Index].blood_pool)
        P[Work_Index].blood_pool = null
        P[Work_Index].will_used = false


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


rule "Feska - Upgrade catalog":
    # 行序必须与 env/vars.opy 的 T_*/A_* 索引一致, 新条目只追加到末尾。
    Upgrades = [
        UPGRADE_ROW_BRUTAL,
        UPGRADE_ROW_GIANT,
        UPGRADE_ROW_HEALING,
        UPGRADE_ROW_REPAIR,
        UPGRADE_ROW_LIFESTEAL,
        UPGRADE_ROW_THORNS,
        UPGRADE_ROW_COOKER,
        UPGRADE_ROW_CANNON,
        ["属性强化：伤害", "伤害加成 +8%", 2, 0, 1, 8, 0, 0],
        ["属性强化：生命", "最大生命值加成 +12%", 2, 0, 1, 0, 12, 0],
        ["属性强化：治疗", "造成的治疗加成 +12%", 2, 0, 1, 0, 0, 12],
        ["属性强化：均衡", "伤害加成 +4%\n最大生命值加成 +6%", 2, 0, 1, 4, 6, 0],
        ["属性强化：共鸣", "伤害加成 +4%\n造成的治疗加成 +6%", 2, 0, 1, 4, 0, 6],
        ["属性强化：养护", "最大生命值加成 +6%\n造成的治疗加成 +6%", 2, 0, 1, 0, 6, 6],
        UPGRADE_ROW_PURGE,
        UPGRADE_ROW_ICE,
        UPGRADE_ROW_BASICS,
        UPGRADE_ROW_SWORD,
        UPGRADE_ROW_SNIPER,
        UPGRADE_ROW_FREEZE_ALL,
        UPGRADE_ROW_F5,
        UPGRADE_ROW_HEARTSTEEL,
        UPGRADE_ROW_SHIELD,
        UPGRADE_ROW_FLESH,
        UPGRADE_ROW_TOWER,
        UPGRADE_ROW_WILL,
        UPGRADE_ROW_BATTERY,
        UPGRADE_ROW_LONE,
        ["属性强化：护甲", "永久增加 25 点可治疗的护甲", 2, 0, 1, 0, 0, 0],
        ["属性强化：减伤", "额外获得 3% 伤害减免", 2, 0, 1, 0, 0, 0],
        ["属性强化：再生", "进攻期间每秒额外恢复\n0.3% 最大生命值", 2, 0, 1, 0, 0, 0],
        ["属性强化：受疗", "受到的治疗加成 +10%", 2, 0, 1, 0, 0, 0],
        ["属性强化：充能", "进攻期间每秒额外获得\n0.2% 终极技能充能", 2, 0, 1, 0, 0, 0],
        ["属性强化：抗击退", "额外获得 10% 击退抵抗, 上限 80%", 2, 0, 1, 0, 0, 0],
        # 索引 34..38 由 vars.opy 的 TechId.AIDKIT..TechId.BERSERK 固定, 必须排在属性强化之后。
        UPGRADE_ROW_AIDKIT,
        UPGRADE_ROW_RADIANT,
        UPGRADE_ROW_CRUSADER,
        UPGRADE_ROW_REACTIVE,
        UPGRADE_ROW_BERSERK
    ]
    Tech_Ids = []
    Stat_Ids = []
    for Work_Index in range(len(Upgrades)):
        if Upgrades[Work_Index][UPGRADE_COL_ENABLED] != 1:
            continue
        if Upgrades[Work_Index][UPGRADE_COL_TYPE] == UPGRADE_TYPE_TECH:
            Tech_Ids.append(Work_Index)
        else:
            Stat_Ids.append(Work_Index)


rule "Feska - Selection HUD":
    createInWorldText(localPlayer if not Under_Attack and localPlayer.choice_type != 0 and localPlayer.visible else [], "{0}\n[近战]切换  长按[蹲]确认\n[换弹]刷新当前卡（每张一次）  [互动]隐藏".format("选择费斯卡科技（{0}/4）".format(len(localPlayer.tech) + 1) if localPlayer.choice_type == 1 else "属性强化（待选 {0} 次）".format(localPlayer.forge_pending)), feskaCardPosition(0, 0.95), 1.6, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.YELLOW, SpecVisibility.NEVER)
    createInWorldText(localPlayer if not Under_Attack and localPlayer.choice_type != 0 and localPlayer.visible else [], "┌── {0} ──┐\n\n{1}\n\n剩余刷新：{2}/1".format(Upgrades[localPlayer.options[0]][UPGRADE_COL_NAME], Upgrades[localPlayer.options[0]][UPGRADE_COL_DESC], 0 if localPlayer.rerolled[0] else 1), feskaCardPosition(1.6, 0.1), 1.2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.YELLOW if localPlayer.cursor == 0 else Color.WHITE, SpecVisibility.NEVER)
    createInWorldText(localPlayer if not Under_Attack and localPlayer.choice_type != 0 and localPlayer.visible else [], "┌── {0} ──┐\n\n{1}\n\n剩余刷新：{2}/1".format(Upgrades[localPlayer.options[1]][UPGRADE_COL_NAME], Upgrades[localPlayer.options[1]][UPGRADE_COL_DESC], 0 if localPlayer.rerolled[1] else 1), feskaCardPosition(0, 0.1), 1.2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.YELLOW if localPlayer.cursor == 1 else Color.WHITE, SpecVisibility.NEVER)
    createInWorldText(localPlayer if not Under_Attack and localPlayer.choice_type != 0 and localPlayer.visible else [], "┌── {0} ──┐\n\n{1}\n\n剩余刷新：{2}/1".format(Upgrades[localPlayer.options[2]][UPGRADE_COL_NAME], Upgrades[localPlayer.options[2]][UPGRADE_COL_DESC], 0 if localPlayer.rerolled[2] else 1), feskaCardPosition(-1.6, 0.1), 1.2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.YELLOW if localPlayer.cursor == 2 else Color.WHITE, SpecVisibility.NEVER)
    hudSubtext(getPlayers(Team.2), "费斯卡科技 {0}/4  |  属性强化 {1} 次\n伤害 +{2}%  生命 {3}%  治疗 +{4}%  护甲 +{5}  减伤 {6}%".format(len(localPlayer.tech), localPlayer.forge_count, localPlayer.bonus[FeskaBonus.DAMAGE], 100 + localPlayer.bonus[FeskaBonus.HEALTH], localPlayer.bonus[FeskaBonus.HEALING], 25 * localPlayer.bonus[FeskaBonus.ARMOR], localPlayer.bonus[FeskaBonus.DAMAGE_REDUCTION]), HudPosition.LEFT, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    hudSubtext(getPlayers(Team.2), "已选：{0}".format(localPlayer.tech.map(lambda upgrade: Upgrades[upgrade][UPGRADE_COL_NAME])), HudPosition.LEFT, 1, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING)
    hudSubtext(getPlayers(Team.2), "成长基准：第 {0} 波进攻  |  心之钢 +{1}  护盾/血肉 +{2}\n受疗 +{3}%  充能 +{4}%/秒  抗击退 {5}%".format(Current_Round if Under_Attack else Completed_Attacks + 1, round(1 + 24 * feskaPreviewProgress()), round(50 + 200 * feskaPreviewProgress()), 10 * localPlayer.bonus[FeskaBonus.HEALING_RECEIVED], 0.2 * localPlayer.bonus[FeskaBonus.ULT_CHARGE], 10 * localPlayer.bonus[FeskaBonus.KNOCKBACK_RESIST]), HudPosition.LEFT, 2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    hudSubtext(getPlayers(Team.2).filter(lambda player: not Under_Attack and player.choice_type != 0 and not player.visible), "[互动]打开科技 / 属性强化选择", HudPosition.LEFT, 3, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING)
