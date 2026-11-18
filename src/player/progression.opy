# 费斯卡科技与属性强化。目录每行一项, 列见 env/vars.opy 的 FESKA_COL_*。
# 三选一卡片沿用海克斯割草的眼前地图文本布局, 只在准备阶段交互。
rule "Feska - Upgrade catalog":
    Feska_Upgrades = [
        ["残暴之力", "造成的伤害 +35%", 1, 0, 1, 35, 0, 0],
        ["歌利亚巨人", "最大生命值 +40%", 1, 0, 1, 0, 40, 0],
        ["生机增幅", "造成的治疗 +40%", 1, 0, 1, 0, 0, 40],
        ["自我修复", "进攻期间每秒恢复 2% 最大生命值", 1, 0, 1, 0, 0, 0],
        ["吸血习性", "每参与消灭一只僵尸恢复 5% 最大生命值", 1, 0, 1, 0, 0, 0],
        ["反甲", "最大生命值 +20%\n向攻击自己的僵尸返还所受伤害的 50%", 1, 0, 1, 0, 20, 0],
        ["高压锅", "每秒对 9 米内僵尸造成\n自身最大生命值 4% 的伤害", 1, 0, 1, 0, 0, 0],
        ["玻璃大炮", "造成的伤害 +55%\n最大生命值 -20%", 1, 0, 1, 55, -20, 0],
        ["属性强化：伤害", "伤害加成 +8%", 2, 0, 1, 8, 0, 0],
        ["属性强化：生命", "最大生命值加成 +12%", 2, 0, 1, 0, 12, 0],
        ["属性强化：治疗", "造成的治疗加成 +12%", 2, 0, 1, 0, 0, 12],
        ["属性强化：均衡", "伤害加成 +4%\n最大生命值加成 +6%", 2, 0, 1, 4, 6, 0],
        ["属性强化：共鸣", "伤害加成 +4%\n造成的治疗加成 +6%", 2, 0, 1, 4, 0, 6],
        ["属性强化：养护", "最大生命值加成 +6%\n造成的治疗加成 +6%", 2, 0, 1, 0, 6, 6],
        ["心灵净化", "最后一击引爆目标\n对其 5 米内其他僵尸造成 60 点伤害", 1, 0, 1, 0, 0, 0],
        ["冰寒之刃", "武器命中有 15% 概率冰冻目标 0.6 秒\n每个目标冷却 5 秒", 1, 0, 1, 0, 0, 0],
        ["回归基本功", "禁用终极技能\n伤害、最大生命值、造成的治疗 +50%", 1, 0, 1, 50, 50, 50],
        # 亮出你的剑目标效果(7 米外不能造成伤害)无法在伤害前拦截, 细节未定, 暂不进入候选池。
        ["亮出你的剑", "以牺牲远程攻击能力换取近战收益", 1, 0, 0, 0, 0, 0],
        ["老练狙神", "对 15 米外敌人造成伤害时\n返还该技能 70% 剩余冷却", 1, 0, 1, 0, 0, 0],
        ["绝对零度", "施放终极技能时\n冰冻所有存活僵尸 2.5 秒", 1, 0, 1, 0, 0, 0],
        ["F5", "每 5 秒随机重置一个\n正在冷却的普通技能", 1, 0, 1, 0, 0, 0],
        ["心之钢", "每参与消灭 20 次永久增加生命上限\n数值为成长固定值 + 自身最大生命值的 2%", 1, 0, 1, 0, 0, 0],
        ["费斯卡光子护盾", "全体玩家获得可恢复护盾\n数值为成长固定值 + 持有者最大生命值的 15%", 1, 1, 1, 0, 0, 0],
        ["血肉再生", "每 10 秒获得临时生命值\n数值为成长固定值 + 自身最大生命值的 5%", 1, 0, 1, 0, 0, 0],
        ["治疗光塔 ProMax", "每 2 秒治疗全体存活队友\n数值为持有者最大生命值的 2%", 1, 0, 1, 0, 0, 0],
        ["胜利意志", "每波生命值首次低于 25% 时\n获得 8 秒无敌并恢复全部生命", 1, 0, 1, 0, 0, 0],
        ["我按Q辣", "进攻期间每秒额外获得\n0.8% 终极技能充能", 1, 0, 1, 0, 0, 0],
        ["一夫当关", "10 米内没有其他存活队友时\n伤害 +20%, 受到的伤害 -15%", 1, 0, 1, 0, 0, 0],
        ["属性强化：护甲", "永久增加 25 点可治疗的护甲", 2, 0, 1, 0, 0, 0],
        ["属性强化：减伤", "额外获得 3% 伤害减免", 2, 0, 1, 0, 0, 0],
        ["属性强化：再生", "进攻期间每秒额外恢复\n0.3% 最大生命值", 2, 0, 1, 0, 0, 0],
        ["属性强化：受疗", "受到的治疗加成 +10%", 2, 0, 1, 0, 0, 0],
        ["属性强化：充能", "进攻期间每秒额外获得\n0.2% 终极技能充能", 2, 0, 1, 0, 0, 0],
        ["属性强化：抗击退", "额外获得 10% 击退抵抗, 上限 80%", 2, 0, 1, 0, 0, 0],
        # 以下为本轮确认的五项新科技, 固定目录索引 34..38(见 vars.opy 的 T_AIDKIT..T_BERSERK),
        # 必须排在属性强化之后, 不能插入已占用索引, 否则 ID 与目录行失配。
        # T23 急救用具: 用户指定的纯治疗强度。与 T03 生机增幅是同一乘区, 现均计入 feska_bonus[2] 叠加;
        # 是否统一名称只保留一张, 待用户决定, 不擅自合并或删除 T03。
        ["急救用具", "造成的治疗 +35%", 1, 0, 1, 0, 0, 35],
        # T24 神圣光辉: 每 10 秒为 15 米内所有友方(含持有者)提供 2.5 秒无敌。
        ["神圣光辉", "每 10 秒为 15 米内所有友方\n提供 2.5 秒无敌", 1, 0, 1, 0, 0, 0],
        # T25 十字军铠甲: 工坊没有伤前固定点数减伤手段(startDamageModification 只接受百分比,
        # 也没有可在受伤前拦截并改写伤害的动作), 按交接要求不交付伪减伤, 暂不进候选池, 待用户定方案。
        ["十字军铠甲", "使受到的每次伤害降低 15～80 点", 1, 0, 0, 0, 0, 0],
        # T26 反应装甲: 100+可计入最大生命 10% 的可恢复护甲; 本来源护甲拦下伤害时眩晕攻击者 1.2 秒。
        ["反应装甲", "获得 100+自身最大生命值 10% 的可恢复护甲\n僵尸未击穿护甲时, 眩晕攻击者 1.2 秒", 1, 0, 1, 0, 0, 0],
        # T27 狂战士之魂: 致命伤后总生命上限变为可计入最大生命值的 21 倍并回满; 期间禁疗、每秒自损、可自由移动。
        ["狂战士之魂", "受到致命伤害后获得 2000% 额外生命值\n无法被治疗, 每秒损失 10% 最大生命值\n可以自由移动", 1, 0, 1, 0, 0, 0]
    ]
    Feska_Tech_Ids = []
    Feska_Stat_Ids = []
    for Feska_Index in range(len(Feska_Upgrades)):
        if Feska_Upgrades[Feska_Index][FESKA_COL_ENABLED] != 1:
            continue
        if Feska_Upgrades[Feska_Index][FESKA_COL_TYPE] == FESKA_TYPE_TECH:
            Feska_Tech_Ids.append(Feska_Index)
        else:
            Feska_Stat_Ids.append(Feska_Index)


def feskaRefreshMods():
    @Name "Feska - refresh damage modifiers"

    # 修正百分比只在创建时取值, 变化时重建, 不用逐帧写 setter。
    if Feska_P.feska_damage_mod == null or Feska_P.feska_damage_value != feskaDamagePercent(Feska_P):
        if Feska_P.feska_damage_mod != null:
            stopDamageModification(Feska_P.feska_damage_mod)
        startDamageModification(getPlayers(Team.1), Feska_P, feskaDamagePercent(Feska_P), DamageReeval.RECEIVERS_DAMAGERS_AND_DMGPERCENT)
        Feska_P.feska_damage_mod = getLastDamageModification()
        Feska_P.feska_damage_value = feskaDamagePercent(Feska_P)
    if feskaReceivedPercent(Feska_P) >= 100:
        if Feska_P.feska_recv_mod != null:
            stopDamageModification(Feska_P.feska_recv_mod)
            Feska_P.feska_recv_mod = null
        Feska_P.feska_recv_value = 100
    elif Feska_P.feska_recv_mod == null or Feska_P.feska_recv_value != feskaReceivedPercent(Feska_P):
        if Feska_P.feska_recv_mod != null:
            stopDamageModification(Feska_P.feska_recv_mod)
        startDamageModification(Feska_P, getPlayers(Team.1), feskaReceivedPercent(Feska_P), DamageReeval.RECEIVERS_DAMAGERS_AND_DMGPERCENT)
        Feska_P.feska_recv_mod = getLastDamageModification()
        Feska_P.feska_recv_value = feskaReceivedPercent(Feska_P)


def feskaApplyArmorPool():
    @Name "Feska - apply armor pool"

    # 子程序里的 return 会结束整个调用规则, 因此这里只用条件包裹。
    if Feska_P.feska_armor_count > 0:
        if Feska_P.feska_armor_pool != null:
            removeHealthPool(Feska_P.feska_armor_pool)
        Feska_P.addHealthPool(Health.ARMOR, 25 * Feska_P.feska_armor_count, true, false)
        Feska_P.feska_armor_pool = getLastCreatedHealthPool()


def feskaApplyHeartsteelPool():
    @Name "Feska - apply heartsteel pool"

    if Feska_P.feska_heartsteel_flat > 0:
        if Feska_P.feska_heartsteel_pool != null:
            removeHealthPool(Feska_P.feska_heartsteel_pool)
        Feska_P.addHealthPool(Health.NORMAL, Feska_P.feska_heartsteel_flat, true, false)
        Feska_P.feska_heartsteel_pool = getLastCreatedHealthPool()


def feskaApplyShieldToPlayer():
    @Name "Feska - apply photon shield"

    if Feska_Shield_Holder != null and Feska_P.isAlive():
        if Feska_P.feska_shield_pool != null:
            removeHealthPool(Feska_P.feska_shield_pool)
        Feska_P.addHealthPool(Health.SHIELDS, ceil(feskaGrowthPool() + feskaMaxHP(Feska_Shield_Holder) * 0.15), true, false)
        Feska_P.feska_shield_pool = getLastCreatedHealthPool()


def feskaApplyReactivePool():
    @Name "Feska - apply reactive armor"

    # 护甲量按当前可计入最大生命结算; 池自身不计入 feskaMaxHP, 重新应用不会自我放大。
    if T_REACTIVE in Feska_P.feska_tech:
        if Feska_P.feska_reactive_pool != null:
            removeHealthPool(Feska_P.feska_reactive_pool)
        Feska_P.addHealthPool(Health.ARMOR, feskaReactiveArmor(Feska_P), true, false)
        Feska_P.feska_reactive_pool = getLastCreatedHealthPool()
        # 镜像与游戏池同步重置; 工坊不能读取生命池余量, 未击穿判定只能靠镜像。
        Feska_P.feska_reactive_value = feskaReactiveArmor(Feska_P)
        Feska_P.feska_reactive_last_hit = null


def feskaStopBerserk():
    @Name "Feska - stop berserk"

    # 结束(波次切换/换英雄)时恢复正常生命口径与禁疗; 移动约束由对应阶段的规则恢复。
    if Feska_P.feska_berserk == true:
        Feska_P.feska_berserk = false
        Feska_P.setMaxHealth(feskaHealthPercent(Feska_P))
        Feska_P.setHealingReceived(100 + 10 * Feska_P.feska_heal_received)
        Feska_P.setKnockbackReceived(100 - 10 * Feska_P.feska_kbr)


def feskaRefreshShields():
    @Name "Feska - refresh photon shields"

    if Feska_Shield_Holder != null:
        P = getLivingPlayers(Team.2).filter(lambda player: not player.isDummy())
        for Feska_Index in range(len(P)):
            Feska_P = P[Feska_Index]
            feskaApplyShieldToPlayer()


def feskaBuildPool():
    @Name "Feska - build candidate pool"

    if Feska_P.feska_choice_type == 1:
        Feska_P.feska_pool = Feska_Tech_Ids.filter(lambda upgrade: upgrade not in Feska_P.feska_tech and not (upgrade == T_SHIELD and Feska_Shield_Holder != null) and not (upgrade == T_BASICS and (T_BATTERY in Feska_P.feska_tech or T_FREEZE_ALL in Feska_P.feska_tech or Feska_P.feska_ult_rate > 0)) and not (upgrade in [T_FREEZE_ALL, T_BATTERY] and T_BASICS in Feska_P.feska_tech))
    else:
        Feska_P.feska_pool = Feska_Stat_Ids.filter(lambda upgrade: not (upgrade == A_ULT and T_BASICS in Feska_P.feska_tech))


def feskaDealCards():
    @Name "Feska - deal cards"

    Feska_P.feska_cursor = 0
    Feska_P.feska_rerolled = [false, false, false]
    Feska_P.feska_visible = true
    if len(Feska_P.feska_tech) < FESKA_MAX_TECH and len(Feska_P.feska_tech) < floor(Completed_Attacks / 2):
        Feska_P.feska_choice_type = 1
    elif len(Feska_P.feska_tech) == FESKA_MAX_TECH and Feska_P.feska_forge_pending > 0:
        Feska_P.feska_choice_type = 2
    else:
        Feska_P.feska_choice_type = 0
    if Feska_P.feska_choice_type != 0:
        feskaBuildPool()
        # 候选不足三张时不开牌, 保证界面索引不会读到空值。
        if len(Feska_P.feska_pool) < 3:
            Feska_P.feska_choice_type = 0
            Feska_P.feska_options = []
        else:
            Feska_P.feska_options = random.shuffle(Feska_P.feska_pool).slice(0, 3)


rule "Feska - Initialize player":
    @Event eachPlayer
    @Team 2
    @Condition not eventPlayer.isDummy()
    @Condition not eventPlayer.feska_initialized

    eventPlayer.feska_tech = []
    eventPlayer.feska_bonus = [0, 0, 0]
    # 首次生成时没有任何本模式生命池与 setMaxHealth 修改, 读取到的就是英雄原始最大生命。
    eventPlayer.feska_base_hp = eventPlayer.getMaxHealth()
    eventPlayer.feska_options = []
    eventPlayer.feska_pool = []
    eventPlayer.feska_forge_pending = 0
    eventPlayer.feska_forge_count = 0
    eventPlayer.feska_choice_type = 0
    eventPlayer.feska_choice = null
    eventPlayer.feska_visible = true
    eventPlayer.feska_lock = false
    eventPlayer.feska_cursor = 0
    eventPlayer.feska_rerolled = [false, false, false]
    eventPlayer.feska_stat_hero = eventPlayer.getHero()
    eventPlayer.feska_stat_dirty = false
    eventPlayer.feska_armor_count = 0
    eventPlayer.feska_armor_pool = null
    eventPlayer.feska_dr = 0
    eventPlayer.feska_regen = 0
    eventPlayer.feska_heal_received = 0
    eventPlayer.feska_ult_rate = 0
    eventPlayer.feska_kbr = 0
    eventPlayer.feska_elim_count = 0
    eventPlayer.feska_heartsteel_flat = 0
    eventPlayer.feska_heartsteel_pool = null
    eventPlayer.feska_shield_pool = null
    eventPlayer.feska_blood_pool = null
    eventPlayer.feska_will_used = false
    eventPlayer.feska_lone = false
    eventPlayer.feska_chain = false
    eventPlayer.feska_reactive_value = 0
    eventPlayer.feska_berserk = false
    eventPlayer.feska_damage_mod = null
    eventPlayer.feska_recv_mod = null
    eventPlayer.feska_damage_value = 0
    eventPlayer.feska_recv_value = 100
    Feska_P = eventPlayer
    feskaRefreshMods()
    eventPlayer.feska_initialized = true


rule "Feska - Release player modifier":
    @Event playerLeft
    @Team 2
    @Condition eventPlayer.feska_initialized

    if eventPlayer.feska_damage_mod != null:
        stopDamageModification(eventPlayer.feska_damage_mod)
    if eventPlayer.feska_recv_mod != null:
        stopDamageModification(eventPlayer.feska_recv_mod)
    eventPlayer.feska_damage_mod = null
    eventPlayer.feska_recv_mod = null
    if Feska_Shield_Holder == eventPlayer:
        Feska_Shield_Holder = null
        # 持有者离场则科技失效: 清掉其他玩家身上本来源的护盾池, 不留常驻残血池。
        P = getPlayers(Team.2)
        for Feska_Index in range(len(P)):
            if P[Feska_Index].feska_shield_pool != null:
                removeHealthPool(P[Feska_Index].feska_shield_pool)
            P[Feska_Index].feska_shield_pool = null


rule "Feska - Offer upgrade":
    @Event eachPlayer
    @Team 2
    @Condition eventPlayer.feska_initialized
    @Condition isGameInProgress()
    @Condition not Under_Attack
    @Condition not eventPlayer.feska_lock
    @Condition eventPlayer.feska_choice_type == 0
    @Condition (len(eventPlayer.feska_tech) < FESKA_MAX_TECH and len(eventPlayer.feska_tech) < floor(Completed_Attacks / 2)) or (len(eventPlayer.feska_tech) == FESKA_MAX_TECH and eventPlayer.feska_forge_pending > 0)

    Feska_P = eventPlayer
    feskaDealCards()


rule "Feska - Toggle selection":
    @Event eachPlayer
    @Team 2
    @Condition not Under_Attack
    @Condition not eventPlayer.feska_lock
    @Condition eventPlayer.feska_choice_type != 0
    @Condition eventPlayer.isHoldingButton(Button.INTERACT)

    eventPlayer.feska_visible = not eventPlayer.feska_visible


rule "Feska - Next card":
    @Event eachPlayer
    @Team 2
    @Condition not Under_Attack
    @Condition not eventPlayer.feska_lock
    @Condition eventPlayer.feska_choice_type != 0
    @Condition eventPlayer.feska_visible
    @Condition eventPlayer.isHoldingButton(Button.MELEE)

    eventPlayer.feska_cursor = (eventPlayer.feska_cursor + 1) % 3


rule "Feska - Reroll card":
    @Event eachPlayer
    @Team 2
    @Condition not Under_Attack
    @Condition not eventPlayer.feska_lock
    @Condition eventPlayer.feska_choice_type != 0
    @Condition eventPlayer.feska_visible
    @Condition eventPlayer.isHoldingButton(Button.RELOAD)

    if eventPlayer.feska_rerolled[eventPlayer.feska_cursor]:
        smallMessage(eventPlayer, "这张卡已刷新过")
    else:
        # 池子随唯一性与互斥变化重建, 再排除手上已有的三张。
        Feska_P = eventPlayer
        feskaBuildPool()
        C = Feska_P.feska_pool.filter(lambda upgrade: upgrade not in eventPlayer.feska_options)
        if len(C) == 0:
            smallMessage(eventPlayer, "没有可刷新的卡")
            return
        eventPlayer.feska_options[eventPlayer.feska_cursor] = random.choice(C)
        eventPlayer.feska_rerolled[eventPlayer.feska_cursor] = true


rule "Feska - Replace taken unique card":
    @Event eachPlayer
    @Team 2
    @Condition not Under_Attack
    @Condition not eventPlayer.feska_lock
    @Condition eventPlayer.feska_choice_type == 1
    @Condition Feska_Shield_Holder != null
    @Condition T_SHIELD in eventPlayer.feska_options

    # 唯一科技被其他玩家先选走后, 在场候选也要换掉, 不能只在抽取时过滤。
    Feska_P = eventPlayer
    feskaBuildPool()
    C = Feska_P.feska_pool.filter(lambda upgrade: upgrade not in eventPlayer.feska_options)
    if len(C) > 0:
        for Feska_Index in range(3):
            if eventPlayer.feska_options[Feska_Index] == T_SHIELD:
                eventPlayer.feska_options[Feska_Index] = random.choice(C)


rule "Feska - Confirm card":
    @Event eachPlayer
    @Team 2
    @Condition not Under_Attack
    @Condition eventPlayer.isAlive()
    @Condition not eventPlayer.feska_lock
    @Condition eventPlayer.feska_choice_type != 0
    @Condition eventPlayer.feska_visible
    @Condition eventPlayer.isHoldingButton(Button.CROUCH)

    # 确认期间上锁; 等待忽略条件, 结束后再核对阶段与按键, 防止跨阶段误选。
    eventPlayer.feska_lock = true
    wait(0.35, Wait.IGNORE_CONDITION)
    if Under_Attack or not eventPlayer.isAlive() or not eventPlayer.isHoldingButton(Button.CROUCH):
        eventPlayer.feska_lock = false
        return
    eventPlayer.feska_choice = eventPlayer.feska_options[eventPlayer.feska_cursor]
    if eventPlayer.feska_choice_type == 1:
        if eventPlayer.feska_choice == T_SHIELD and Feska_Shield_Holder != null:
            smallMessage(eventPlayer, "该科技已被其他玩家选走")
            eventPlayer.feska_choice_type = 0
            eventPlayer.feska_visible = true
            eventPlayer.feska_lock = false
            return
        if eventPlayer.feska_choice == T_BASICS and (T_BATTERY in eventPlayer.feska_tech or T_FREEZE_ALL in eventPlayer.feska_tech or eventPlayer.feska_ult_rate > 0):
            smallMessage(eventPlayer, "与已持有的科技冲突")
            eventPlayer.feska_choice_type = 0
            eventPlayer.feska_visible = true
            eventPlayer.feska_lock = false
            return
        eventPlayer.feska_tech.append(eventPlayer.feska_choice)
    else:
        if eventPlayer.feska_choice == A_ULT and T_BASICS in eventPlayer.feska_tech:
            smallMessage(eventPlayer, "与已持有的科技冲突")
            eventPlayer.feska_choice_type = 0
            eventPlayer.feska_visible = true
            eventPlayer.feska_lock = false
            return
        eventPlayer.feska_forge_pending -= 1
        eventPlayer.feska_forge_count += 1
    eventPlayer.feska_bonus[0] += Feska_Upgrades[eventPlayer.feska_choice][FESKA_COL_DAMAGE]
    eventPlayer.feska_bonus[1] += Feska_Upgrades[eventPlayer.feska_choice][FESKA_COL_HEALTH]
    eventPlayer.feska_bonus[2] += Feska_Upgrades[eventPlayer.feska_choice][FESKA_COL_HEALING]
    # setMaxHealth 的参数是百分比, 不是生命点数; 点数口径见 feskaMaxHP。
    eventPlayer.setMaxHealth(feskaHealthPercent(eventPlayer))
    eventPlayer.setHealingDealt(100 + eventPlayer.feska_bonus[2])
    Feska_P = eventPlayer
    if eventPlayer.feska_choice == T_BASICS:
        eventPlayer.setUltEnabled(false)
    elif eventPlayer.feska_choice == T_SHIELD:
        Feska_Shield_Holder = eventPlayer
        feskaRefreshShields()
    elif eventPlayer.feska_choice == T_REACTIVE:
        Feska_P = eventPlayer
        feskaApplyReactivePool()
    elif eventPlayer.feska_choice == A_ARMOR:
        eventPlayer.feska_armor_count += 1
        feskaApplyArmorPool()
    elif eventPlayer.feska_choice == A_DR:
        # 成长系统减伤总上限 50%, 避免重复选择后完全免伤。
        eventPlayer.feska_dr = min(eventPlayer.feska_dr + 3, 50)
    elif eventPlayer.feska_choice == A_REGEN:
        eventPlayer.feska_regen += 1
    elif eventPlayer.feska_choice == A_HEAL_RECEIVED:
        eventPlayer.feska_heal_received += 1
        eventPlayer.setHealingReceived(100 + 10 * eventPlayer.feska_heal_received)
    elif eventPlayer.feska_choice == A_ULT:
        eventPlayer.feska_ult_rate += 1
    elif eventPlayer.feska_choice == A_KBR:
        eventPlayer.feska_kbr = min(eventPlayer.feska_kbr + 1, 8)
        eventPlayer.setKnockbackReceived(100 - 10 * eventPlayer.feska_kbr)
    Feska_P = eventPlayer
    feskaRefreshMods()
    smallMessage(eventPlayer, "已选择：{0}".format(Feska_Upgrades[eventPlayer.feska_choice][FESKA_COL_NAME]))
    eventPlayer.feska_options = []
    eventPlayer.feska_choice_type = 0
    eventPlayer.feska_visible = false
    # 必须真正松开蹲才能确认下一次; 不设超时, 防止长按跨多次发牌连续误选积攒的奖励。
    waitUntil(not eventPlayer.isHoldingButton(Button.CROUCH))
    eventPlayer.feska_lock = false
    eventPlayer.feska_visible = true


rule "Feska - Restore stats on hero change or respawn":
    @Event eachPlayer
    @Team 2
    @Condition eventPlayer.feska_initialized
    @Condition eventPlayer.isAlive()
    @Condition eventPlayer.hasSpawned()
    @Condition eventPlayer.feska_stat_hero != eventPlayer.getHero() or eventPlayer.feska_stat_dirty

    # 先清理本模式生命池: 生命池是否跨死亡/换英雄保留未在工坊文档中明确, 先移除再重建,
    # 避免旧池若保留下来导致每次重生多叠一层。
    if eventPlayer.feska_armor_pool != null:
        removeHealthPool(eventPlayer.feska_armor_pool)
    if eventPlayer.feska_heartsteel_pool != null:
        removeHealthPool(eventPlayer.feska_heartsteel_pool)
    if eventPlayer.feska_shield_pool != null:
        removeHealthPool(eventPlayer.feska_shield_pool)
    if eventPlayer.feska_blood_pool != null:
        removeHealthPool(eventPlayer.feska_blood_pool)
    if eventPlayer.feska_reactive_pool != null:
        removeHealthPool(eventPlayer.feska_reactive_pool)
    eventPlayer.feska_armor_pool = null
    eventPlayer.feska_heartsteel_pool = null
    eventPlayer.feska_shield_pool = null
    eventPlayer.feska_blood_pool = null
    eventPlayer.feska_reactive_pool = null
    eventPlayer.feska_reactive_value = 0
    eventPlayer.feska_reactive_last_hit = null
    # feska_stat_dirty 是死亡后的重生路径; 英雄确实变了才是真正换英雄。
    # 换英雄后工坊重置 setMaxHealth 百分比, 清理生命池后读到的 getMaxHealth() 即新英雄原始最大生命。
    if eventPlayer.feska_stat_hero != eventPlayer.getHero():
        eventPlayer.feska_base_hp = eventPlayer.getMaxHealth()
    eventPlayer.feska_stat_hero = eventPlayer.getHero()
    eventPlayer.feska_stat_dirty = false
    eventPlayer.feska_lock = false
    # 换英雄/重生都结束狂战士; 若仍在进攻阶段, 重新套上定点油门(狂战士之前解除过)。
    Feska_P = eventPlayer
    feskaStopBerserk()
    if Under_Attack:
        eventPlayer.startForcingThrottle(0, 0.01, 0, 0.01, 0, 0.01)
    # setMaxHealth 的参数是百分比, 不是生命点数; 点数口径见 feskaMaxHP。
    eventPlayer.setMaxHealth(feskaHealthPercent(eventPlayer))
    eventPlayer.setHealingDealt(100 + eventPlayer.feska_bonus[2])
    # 重生/换英雄会清掉英雄属性修改, 这里按累计状态无条件重放, 不能只在有堆叠时恢复。
    eventPlayer.setHealingReceived(100 + 10 * eventPlayer.feska_heal_received)
    eventPlayer.setKnockbackReceived(100 - 10 * eventPlayer.feska_kbr)
    if T_BASICS in eventPlayer.feska_tech:
        eventPlayer.setUltEnabled(false)
    Feska_P = eventPlayer
    feskaApplyArmorPool()
    feskaApplyHeartsteelPool()
    feskaApplyShieldToPlayer()
    feskaApplyReactivePool()
    feskaRefreshMods()


rule "Feska - Invalidate hero on death":
    @Event playerDied
    @Team 2

    # 只标记需要重放属性恢复; 不置空 feska_stat_hero, 否则死亡后换英雄会被误判成重生而不重捕基准。
    eventPlayer.feska_stat_dirty = true
    # 狂战士随本次生命结束; 下一次生命可重新触发。
    eventPlayer.feska_berserk = false
    eventPlayer.feska_lock = false


rule "Feska - Wave start":
    @Condition isGameInProgress()
    @Condition Under_Attack

    wait(0.016)
    getPlayers(Team.2).feska_will_used = false
    feskaRefreshShields()


rule "Feska - Wave end cleanup":
    @Condition isGameInProgress()
    @Condition not Under_Attack

    P = getPlayers(Team.2)
    for Feska_Index in range(len(P)):
        # 波次切换结束狂战士: 恢复正常生命口径与禁疗, 移动约束由进攻锁定规则负责恢复。
        Feska_P = P[Feska_Index]
        feskaStopBerserk()
        if P[Feska_Index].feska_blood_pool != null:
            removeHealthPool(P[Feska_Index].feska_blood_pool)
        P[Feska_Index].feska_blood_pool = null
        P[Feska_Index].feska_lone = false
        P[Feska_Index].feska_will_used = false


rule "Feska - Lone wolf":
    @Event eachPlayer
    @Team 2
    @Condition Under_Attack
    @Condition eventPlayer.isAlive()
    @Condition T_LONE in eventPlayer.feska_tech

    eventPlayer.feska_lone = len(getLivingPlayers(Team.2).filter(lambda player: player != eventPlayer and not player.isDummy() and distance(player, eventPlayer) <= 10)) == 0
    Feska_P = eventPlayer
    feskaRefreshMods()
    wait(0.5, Wait.ABORT_WHEN_FALSE)
    if ruleCondition:
        loop()


rule "Feska - Regeneration":
    @Event eachPlayer
    @Team 2
    @Condition Under_Attack
    @Condition eventPlayer.isAlive()
    # 狂战士禁疗: 自我修复与再生强化都不回血。
    @Condition eventPlayer.feska_berserk != true
    @Condition (T_REPAIR in eventPlayer.feska_tech) or eventPlayer.feska_regen > 0

    wait(1, Wait.ABORT_WHEN_FALSE)
    heal(eventPlayer, null, feskaMaxHP(eventPlayer) * ((0.02 if T_REPAIR in eventPlayer.feska_tech else 0) + 0.003 * eventPlayer.feska_regen))
    if ruleCondition:
        loop()


rule "Feska - Ultimate charge":
    @Event eachPlayer
    @Team 2
    @Condition Under_Attack
    @Condition eventPlayer.isAlive()
    @Condition (T_BATTERY in eventPlayer.feska_tech) or eventPlayer.feska_ult_rate > 0

    wait(1, Wait.ABORT_WHEN_FALSE)
    eventPlayer.setUltCharge(min(eventPlayer.getUltCharge() + (0.8 if T_BATTERY in eventPlayer.feska_tech else 0) + 0.2 * eventPlayer.feska_ult_rate, 100))
    if ruleCondition:
        loop()


rule "Feska - Lifesteal on elimination":
    @Event playerEarnedElimination
    @Team 2
    @Condition Under_Attack
    @Condition eventPlayer.isAlive()
    @Condition victim.getTeam() == Team.1
    # 狂战士禁疗。
    @Condition eventPlayer.feska_berserk != true
    @Condition T_LIFESTEAL in eventPlayer.feska_tech

    heal(eventPlayer, null, feskaMaxHP(eventPlayer) * 0.05)


rule "Feska - Heartsteel":
    @Event playerEarnedElimination
    @Team 2
    @Condition victim.getTeam() == Team.1
    @Condition T_HEARTSTEEL in eventPlayer.feska_tech

    eventPlayer.feska_elim_count += 1
    if eventPlayer.feska_elim_count >= 20:
        eventPlayer.feska_elim_count -= 20
        # 固定增量只结算一次并保存, 不追踪包含自身生命池的表达式。
        eventPlayer.feska_heartsteel_flat += round(feskaGrowthHeartsteel() + feskaMaxHP(eventPlayer) * 0.02)
        Feska_P = eventPlayer
        feskaApplyHeartsteelPool()
        smallMessage(eventPlayer, "心之钢：生命上限 +{0}".format(eventPlayer.feska_heartsteel_flat))


rule "Feska - Thorns":
    @Event playerTookDamage
    @Team 2
    @Condition Under_Attack
    @Condition attacker.getTeam() == Team.1
    @Condition T_THORNS in eventPlayer.feska_tech
    @Condition eventPlayer.feska_chain != true

    damage(attacker, eventPlayer, eventDamage * 0.5)


rule "Feska - Pressure cooker":
    @Event eachPlayer
    @Team 2
    @Condition Under_Attack
    @Condition eventPlayer.isAlive()
    @Condition T_COOKER in eventPlayer.feska_tech

    wait(1, Wait.ABORT_WHEN_FALSE)
    damage(getPlayersInRadius(eventPlayer, 9, Team.1, LosCheck.SURFACES), eventPlayer, feskaMaxHP(eventPlayer) * 0.04)
    if ruleCondition:
        loop()


rule "Feska - Soul purge":
    @Event playerDealtFinalBlow
    @Team 2
    @Condition victim.getTeam() == Team.1
    @Condition T_PURGE in eventPlayer.feska_tech
    @Condition eventPlayer.feska_chain != true

    # 派生伤害期间关闭引爆, 避免连锁爆炸递归。
    eventPlayer.feska_chain = true
    playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, Color.BLUE, victim, 1)
    damage(getPlayersInRadius(victim, 5, Team.1, LosCheck.SURFACES).filter(lambda player: player != victim), eventPlayer, 60)
    wait(0.032)
    eventPlayer.feska_chain = false


rule "Feska - Ice blade":
    @Event playerDealtDamage
    @Team 2
    @Condition victim.getTeam() == Team.1
    @Condition T_ICE in eventPlayer.feska_tech
    @Condition eventAbility in [Button.PRIMARY_FIRE, Button.SECONDARY_FIRE, Button.MELEE]
    @Condition victim.feska_freeze_cd != true
    @Condition random.uniform(0, 100) < 15

    victim.feska_freeze_cd = true
    victim.setStatusEffect(eventPlayer, Status.FROZEN, 0.6)
    wait(5)
    victim.feska_freeze_cd = false


rule "Feska - Sniper":
    @Event playerDealtDamage
    @Team 2
    @Condition victim.getTeam() == Team.1
    @Condition T_SNIPER in eventPlayer.feska_tech
    # 普通技能含右键; 只有该技能确实处于可读写冷却时才返还, 普攻与无冷却技能不参与。
    @Condition eventAbility in [Button.ABILITY_1, Button.ABILITY_2, Button.SECONDARY_FIRE]
    @Condition distance(eventPlayer, victim) >= 15

    # 只在技能确实处于冷却时返还剩余冷却的 70%, 弹丸命中时冷却尚未启动的技能不参与。
    if eventPlayer.getAbilityCooldown(eventAbility) > 0:
        eventPlayer.setAbilityCooldown(eventAbility, eventPlayer.getAbilityCooldown(eventAbility) * 0.3)


rule "Feska - Absolute zero":
    @Event eachPlayer
    @Team 2
    @Condition T_FREEZE_ALL in eventPlayer.feska_tech
    @Condition eventPlayer.isUsingUltimate()

    getLivingPlayers(Team.1).setStatusEffect(eventPlayer, Status.FROZEN, 2.5)


rule "Feska - F5":
    @Event eachPlayer
    @Team 2
    @Condition Under_Attack
    @Condition eventPlayer.isAlive()
    @Condition T_F5 in eventPlayer.feska_tech

    wait(5, Wait.ABORT_WHEN_FALSE)
    B = [Button.ABILITY_1, Button.ABILITY_2, Button.SECONDARY_FIRE].filter(lambda button: eventPlayer.getAbilityCooldown(button) > 0)
    if len(B) > 0:
        eventPlayer.setAbilityCooldown(random.choice(B), 0)
    if ruleCondition:
        loop()


rule "Feska - Blood regeneration":
    @Event eachPlayer
    @Team 2
    @Condition Under_Attack
    @Condition eventPlayer.isAlive()
    @Condition T_FLESH in eventPlayer.feska_tech

    wait(10, Wait.ABORT_WHEN_FALSE)
    if eventPlayer.feska_blood_pool != null:
        removeHealthPool(eventPlayer.feska_blood_pool)
    eventPlayer.addHealthPool(Health.NORMAL, ceil(feskaGrowthPool() + feskaMaxHP(eventPlayer) * 0.05), true, false)
    eventPlayer.feska_blood_pool = getLastCreatedHealthPool()
    if ruleCondition:
        loop()


rule "Feska - Healing tower":
    @Event eachPlayer
    @Team 2
    @Condition Under_Attack
    @Condition eventPlayer.isAlive()
    @Condition T_TOWER in eventPlayer.feska_tech

    wait(2, Wait.ABORT_WHEN_FALSE)
    # 全体治疗不含狂战士(禁疗); 其余存活真人队友都治, 含持有者。
    heal(getLivingPlayers(Team.2).filter(lambda player: not player.isDummy() and player.feska_berserk != true), eventPlayer, feskaMaxHP(eventPlayer) * 0.02)
    if ruleCondition:
        loop()


rule "Feska - Victory will":
    @Event eachPlayer
    @Team 2
    @Condition Under_Attack
    @Condition eventPlayer.isAlive()
    @Condition T_WILL in eventPlayer.feska_tech
    # 狂战士优先: 激活期间胜利意志不触发, 避免禁疗状态被回血和无敌覆盖。
    @Condition eventPlayer.feska_berserk != true
    @Condition eventPlayer.feska_will_used != true
    @Condition eventPlayer.getHealth() <= feskaMaxHP(eventPlayer) * 0.25

    eventPlayer.feska_will_used = true
    heal(eventPlayer, null, feskaMaxHP(eventPlayer))
    eventPlayer.setStatusEffect(eventPlayer, Status.INVINCIBLE, 8)
    smallMessage(eventPlayer, "胜利意志：8 秒无敌")


rule "Feska - Berserk trigger":
    @Event playerTookDamage
    @Team 2
    @Condition Under_Attack
    @Condition T_BERSERK in eventPlayer.feska_tech
    @Condition eventPlayer.feska_berserk != true
    @Condition eventPlayer.isAlive()
    @Condition attacker != null
    @Condition attacker.getTeam() == Team.1
    # playerTookDamage 在死亡结算前触发, 此时 getHealth() 是受伤后的数值; ≤0 即本次伤害致命。
    # 该先后语义未在工坊文档中写明, 需游戏内验证; 若实际是受伤前数值, 本科技不会触发而非误触发。
    @Condition eventPlayer.getHealth() <= 0

    # 真实拦截致命伤: 事件内抬生命上限并回满即不会阵亡, 不是先阵亡再复活。
    eventPlayer.feska_berserk = true
    eventPlayer.setMaxHealth(feskaBerserkPercent(eventPlayer))
    eventPlayer.setHealth(feskaBerserkMaxHP(eventPlayer))
    # 禁疗: 挡掉英雄治疗与模式治疗动作; setHealth 与生命池创建不受影响。
    eventPlayer.setHealingReceived(0)
    # 解除进攻定点油门; 状态结束/死亡/换英雄/波次切换时由对应规则恢复。
    eventPlayer.stopForcingThrottle()
    smallMessage(eventPlayer, "狂战士之魂：无法被治疗，每秒损失生命")


rule "Feska - Berserk drain":
    @Event eachPlayer
    @Team 2
    @Condition Under_Attack
    @Condition eventPlayer.feska_berserk == true
    @Condition eventPlayer.isAlive()

    wait(1, Wait.ABORT_WHEN_FALSE)
    # 每秒损失当前最大生命值(21 倍口径)的 10%, 约 10 秒后耗尽; 死亡即状态结束。
    damage(eventPlayer, eventPlayer, ceil(feskaBerserkMaxHP(eventPlayer) * 0.1))
    if ruleCondition:
        loop()


rule "Feska - Radiant light":
    @Event eachPlayer
    @Team 2
    @Condition Under_Attack
    @Condition eventPlayer.isAlive()
    @Condition T_RADIANT in eventPlayer.feska_tech

    # 进攻期间每 10 秒一轮; 持有者中途死亡则本规则中止, 不补发。
    wait(10, Wait.ABORT_WHEN_FALSE)
    # 15 米内所有友方(含持有者)获得 2.5 秒无敌。setStatusEffect 只叠加时长,
    # 不会清除其他来源的无敌; 不要求视线, 与卡面"15 米内所有友方"一致。
    getLivingPlayers(Team.2).filter(lambda player: not player.isDummy() and distance(player, eventPlayer) <= 15).setStatusEffect(eventPlayer, Status.INVINCIBLE, 2.5)
    if ruleCondition:
        loop()


rule "Feska - Reactive armor":
    @Event playerTookDamage
    @Team 2
    @Condition T_REACTIVE in eventPlayer.feska_tech
    @Condition attacker != null
    @Condition attacker != eventPlayer

    # 工坊不能读取生命池余量: 用镜像值近似本来源护甲。任何受伤都记录时间(游戏池离战才恢复),
    # 本次伤害被护甲拦下时眩晕攻击者 1.2 秒。镜像按本来源口径扣减, 打在英雄护盾/护甲上的伤害
    # 也会扣减镜像, 只会少判不会多判; 1.2 秒眩晕不设内置冷却, 频率由护甲量自然限制。
    eventPlayer.feska_reactive_last_hit = getTotalTimeElapsed()
    if eventDamage <= eventPlayer.feska_reactive_value:
        attacker.setStatusEffect(eventPlayer, Status.STUNNED, 1.2)
    eventPlayer.feska_reactive_value = max(eventPlayer.feska_reactive_value - eventDamage, 0)


rule "Feska - Reactive armor recover":
    @Event eachPlayer
    @Team 2
    @Condition T_REACTIVE in eventPlayer.feska_tech
    @Condition eventPlayer.isAlive()

    wait(1, Wait.ABORT_WHEN_FALSE)
    # 离战 3 秒后镜像回满, 近似护甲池的恢复节奏(实际池恢复曲线不能读取, 需游戏内核对)。
    if eventPlayer.feska_reactive_last_hit != null and getTotalTimeElapsed() - eventPlayer.feska_reactive_last_hit >= 3:
        eventPlayer.feska_reactive_value = feskaReactiveArmor(eventPlayer)
        eventPlayer.feska_reactive_last_hit = null
    if ruleCondition:
        loop()


rule "Feska - Selection HUD":
    createInWorldText(localPlayer if not Under_Attack and localPlayer.feska_choice_type != 0 and localPlayer.feska_visible else [], "{0}\n[近战]切换  长按[蹲]确认\n[换弹]刷新当前卡（每张一次）  [互动]隐藏".format("选择费斯卡科技（{0}/4）".format(len(localPlayer.feska_tech) + 1) if localPlayer.feska_choice_type == 1 else "属性强化（待选 {0} 次）".format(localPlayer.feska_forge_pending)), feskaCardPosition(0, 0.95), 1.6, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.YELLOW, SpecVisibility.NEVER)
    createInWorldText(localPlayer if not Under_Attack and localPlayer.feska_choice_type != 0 and localPlayer.feska_visible else [], "┌── {0} ──┐\n\n{1}\n\n剩余刷新：{2}/1".format(Feska_Upgrades[localPlayer.feska_options[0]][FESKA_COL_NAME], Feska_Upgrades[localPlayer.feska_options[0]][FESKA_COL_DESC], 0 if localPlayer.feska_rerolled[0] else 1), feskaCardPosition(1.6, 0.1), 1.2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.YELLOW if localPlayer.feska_cursor == 0 else Color.WHITE, SpecVisibility.NEVER)
    createInWorldText(localPlayer if not Under_Attack and localPlayer.feska_choice_type != 0 and localPlayer.feska_visible else [], "┌── {0} ──┐\n\n{1}\n\n剩余刷新：{2}/1".format(Feska_Upgrades[localPlayer.feska_options[1]][FESKA_COL_NAME], Feska_Upgrades[localPlayer.feska_options[1]][FESKA_COL_DESC], 0 if localPlayer.feska_rerolled[1] else 1), feskaCardPosition(0, 0.1), 1.2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.YELLOW if localPlayer.feska_cursor == 1 else Color.WHITE, SpecVisibility.NEVER)
    createInWorldText(localPlayer if not Under_Attack and localPlayer.feska_choice_type != 0 and localPlayer.feska_visible else [], "┌── {0} ──┐\n\n{1}\n\n剩余刷新：{2}/1".format(Feska_Upgrades[localPlayer.feska_options[2]][FESKA_COL_NAME], Feska_Upgrades[localPlayer.feska_options[2]][FESKA_COL_DESC], 0 if localPlayer.feska_rerolled[2] else 1), feskaCardPosition(-1.6, 0.1), 1.2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.YELLOW if localPlayer.feska_cursor == 2 else Color.WHITE, SpecVisibility.NEVER)
    hudSubtext(getPlayers(Team.2), "费斯卡科技 {0}/4  |  属性强化 {1} 次\n伤害 +{2}%  生命 {3}%  治疗 +{4}%  护甲 +{5}  减伤 {6}%".format(len(localPlayer.feska_tech), localPlayer.feska_forge_count, localPlayer.feska_bonus[0], 100 + localPlayer.feska_bonus[1], localPlayer.feska_bonus[2], 25 * localPlayer.feska_armor_count, localPlayer.feska_dr), HudPosition.LEFT, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    hudSubtext(getPlayers(Team.2), "已选：{0}".format(localPlayer.feska_tech.map(lambda upgrade: Feska_Upgrades[upgrade][FESKA_COL_NAME])), HudPosition.LEFT, 1, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING)
    hudSubtext(getPlayers(Team.2), "成长基准：第 {0} 波进攻  |  心之钢 +{1}  护盾/血肉 +{2}\n受疗 +{3}%  充能 +{4}%/秒  抗击退 {5}%".format(Current_Round if Under_Attack else Completed_Attacks + 1, round(1 + 24 * feskaPreviewProgress()), round(50 + 200 * feskaPreviewProgress()), 10 * localPlayer.feska_heal_received, 0.2 * localPlayer.feska_ult_rate, 10 * localPlayer.feska_kbr), HudPosition.LEFT, 2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    hudSubtext(getPlayers(Team.2).filter(lambda player: not Under_Attack and player.feska_choice_type != 0 and not player.feska_visible), "[互动]打开科技 / 属性强化选择", HudPosition.LEFT, 3, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING)
