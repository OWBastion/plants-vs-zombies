# 三选一卡片沿用海克斯割草的眼前地图文本布局, 只在准备阶段交互。
rule "Feska - Upgrade catalog":
    Feska_Upgrades = [
        ["残暴之力", "造成的伤害 +35%", 35, 0, 0],
        ["歌利亚巨人", "最大生命值 +40%", 0, 40, 0],
        ["生机增幅", "造成的治疗 +40%", 0, 0, 40],
        ["自我修复", "进攻期间每秒恢复 2% 最大生命值", 0, 0, 0],
        ["吸血习性", "参与消灭僵尸时恢复 5% 最大生命值", 0, 0, 0],
        ["反甲", "最大生命值 +20%\n向僵尸返还所受伤害的 50%", 0, 20, 0],
        ["高压锅", "进攻期间每秒灼烧 9 米内僵尸\n伤害为自身最大生命值的 4%", 0, 0, 0],
        ["玻璃大炮", "造成的伤害 +55%\n最大生命值 -20%", 55, -20, 0],
        ["锻体 · 力量", "永久增加 8% 基础伤害", 8, 0, 0],
        ["锻体 · 体魄", "永久增加 12% 基础最大生命值", 0, 12, 0],
        ["锻体 · 生机", "永久增加 12% 基础治疗", 0, 0, 12],
        ["锻体 · 均衡", "永久增加 4% 基础伤害\n永久增加 6% 基础最大生命值", 4, 6, 0],
        ["锻体 · 共鸣", "永久增加 4% 基础伤害\n永久增加 6% 基础治疗", 4, 0, 6],
        ["锻体 · 养护", "永久增加 6% 基础最大生命值\n永久增加 6% 基础治疗", 0, 6, 6]
    ]


rule "Feska - Initialize player":
    @Event eachPlayer
    @Team 2
    @Condition not eventPlayer.isDummy()
    @Condition not eventPlayer.feska_initialized

    eventPlayer.feska_tech = []
    eventPlayer.feska_bonus = [0, 0, 0]
    eventPlayer.feska_options = []
    eventPlayer.feska_forge_pending = 0
    eventPlayer.feska_forge_count = 0
    eventPlayer.feska_choice_type = 0
    eventPlayer.feska_visible = true
    startDamageModification(getPlayers(Team.1), eventPlayer, 100 + eventPlayer.feska_bonus[0], DamageReeval.RECEIVERS_DAMAGERS_AND_DMGPERCENT)
    eventPlayer.feska_damage_mod = getLastDamageModification()
    eventPlayer.feska_initialized = true


rule "Feska - Release player modifier":
    @Event playerLeft
    @Team 2
    @Condition eventPlayer.feska_initialized

    stopDamageModification(eventPlayer.feska_damage_mod)
    eventPlayer.feska_damage_mod = null


rule "Feska - Offer upgrade":
    @Event eachPlayer
    @Team 2
    @Condition eventPlayer.feska_initialized
    @Condition isGameInProgress()
    @Condition not Under_Attack
    @Condition eventPlayer.feska_choice_type == 0
    @Condition len(eventPlayer.feska_tech) < min(floor(Completed_Attacks / 2), FESKA_MAX_TECH) or (len(eventPlayer.feska_tech) == FESKA_MAX_TECH and eventPlayer.feska_forge_pending > 0)

    eventPlayer.feska_cursor = 0
    eventPlayer.feska_rerolled = [false, false, false]
    eventPlayer.feska_visible = true
    if len(eventPlayer.feska_tech) < FESKA_MAX_TECH:
        eventPlayer.feska_options = random.shuffle([0, 1, 2, 3, 4, 5, 6, 7].filter(lambda upgrade: upgrade not in eventPlayer.feska_tech)).slice(0, 3)
        eventPlayer.feska_choice_type = 1
    else:
        eventPlayer.feska_options = random.shuffle([8, 9, 10, 11, 12, 13]).slice(0, 3)
        eventPlayer.feska_choice_type = 2


rule "Feska - Toggle selection":
    @Event eachPlayer
    @Team 2
    @Condition not Under_Attack
    @Condition eventPlayer.feska_choice_type != 0
    @Condition eventPlayer.isHoldingButton(Button.INTERACT)

    eventPlayer.feska_visible = not eventPlayer.feska_visible


rule "Feska - Next card":
    @Event eachPlayer
    @Team 2
    @Condition not Under_Attack
    @Condition eventPlayer.feska_choice_type != 0
    @Condition eventPlayer.feska_visible
    @Condition eventPlayer.isHoldingButton(Button.MELEE)

    eventPlayer.feska_cursor = (eventPlayer.feska_cursor + 1) % 3


rule "Feska - Reroll card":
    @Event eachPlayer
    @Team 2
    @Condition not Under_Attack
    @Condition eventPlayer.feska_choice_type != 0
    @Condition eventPlayer.feska_visible
    @Condition eventPlayer.isHoldingButton(Button.RELOAD)

    if eventPlayer.feska_rerolled[eventPlayer.feska_cursor]:
        smallMessage(eventPlayer, "这张卡已刷新过")
    else:
        eventPlayer.feska_options[eventPlayer.feska_cursor] = random.choice([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13].filter(lambda upgrade: (upgrade < FESKA_TECH_COUNT if eventPlayer.feska_choice_type == 1 else upgrade >= FESKA_TECH_COUNT) and upgrade not in eventPlayer.feska_tech and upgrade not in eventPlayer.feska_options))
        eventPlayer.feska_rerolled[eventPlayer.feska_cursor] = true


rule "Feska - Confirm card":
    @Event eachPlayer
    @Team 2
    @Condition not Under_Attack
    @Condition eventPlayer.isAlive()
    @Condition eventPlayer.feska_choice_type != 0
    @Condition eventPlayer.feska_visible
    @Condition eventPlayer.isHoldingButton(Button.CROUCH)

    wait(0.35, Wait.ABORT_WHEN_FALSE)
    eventPlayer.feska_choice = eventPlayer.feska_options[eventPlayer.feska_cursor]
    if eventPlayer.feska_choice_type == 1:
        eventPlayer.feska_tech.append(eventPlayer.feska_choice)
    else:
        eventPlayer.feska_forge_pending -= 1
        eventPlayer.feska_forge_count += 1
    eventPlayer.feska_bonus[0] += Feska_Upgrades[eventPlayer.feska_choice][FESKA_DAMAGE]
    eventPlayer.feska_bonus[1] += Feska_Upgrades[eventPlayer.feska_choice][FESKA_HEALTH]
    eventPlayer.feska_bonus[2] += Feska_Upgrades[eventPlayer.feska_choice][FESKA_HEALING]
    eventPlayer.setMaxHealth(100 + eventPlayer.feska_bonus[1])
    eventPlayer.setHealingDealt(100 + eventPlayer.feska_bonus[2])
    smallMessage(eventPlayer, "已选择：{0}".format(Feska_Upgrades[eventPlayer.feska_choice][0]))
    eventPlayer.feska_options = []
    eventPlayer.feska_choice_type = 0
    # 松开后才能确认下一次, 防止连续按住蹲误选积攒的奖励。
    eventPlayer.feska_visible = false
    waitUntil(not eventPlayer.isHoldingButton(Button.CROUCH), 999999)
    eventPlayer.feska_visible = true


rule "Feska - Restore stats on hero change or respawn":
    @Event eachPlayer
    @Team 2
    @Condition eventPlayer.feska_initialized
    @Condition eventPlayer.isAlive()
    @Condition eventPlayer.hasSpawned()
    @Condition eventPlayer.feska_stat_hero != eventPlayer.getHero()

    eventPlayer.setMaxHealth(100 + eventPlayer.feska_bonus[1])
    eventPlayer.setHealingDealt(100 + eventPlayer.feska_bonus[2])
    eventPlayer.feska_stat_hero = eventPlayer.getHero()


rule "Feska - Invalidate hero on death":
    @Event playerDied
    @Team 2

    eventPlayer.feska_stat_hero = null


rule "Feska - Self repair":
    @Event eachPlayer
    @Team 2
    @Condition Under_Attack
    @Condition eventPlayer.isAlive()
    @Condition 3 in eventPlayer.feska_tech

    wait(1, Wait.ABORT_WHEN_FALSE)
    heal(eventPlayer, null, eventPlayer.getMaxHealth() * 0.02)
    if ruleCondition:
        loop()


rule "Feska - Lifesteal on elimination":
    @Event playerEarnedElimination
    @Team 2
    @Condition Under_Attack
    @Condition eventPlayer.isAlive()
    @Condition victim.getTeam() == Team.1
    @Condition 4 in eventPlayer.feska_tech

    heal(eventPlayer, null, eventPlayer.getMaxHealth() * 0.05)


rule "Feska - Thorns":
    @Event playerTookDamage
    @Team 2
    @Condition Under_Attack
    @Condition attacker.getTeam() == Team.1
    @Condition 5 in eventPlayer.feska_tech

    damage(attacker, eventPlayer, eventDamage * 0.5)


rule "Feska - Pressure cooker":
    @Event eachPlayer
    @Team 2
    @Condition Under_Attack
    @Condition eventPlayer.isAlive()
    @Condition 6 in eventPlayer.feska_tech

    wait(1, Wait.ABORT_WHEN_FALSE)
    damage(getPlayersInRadius(eventPlayer, 9, Team.1, LosCheck.SURFACES), eventPlayer, eventPlayer.getMaxHealth() * 0.04)
    if ruleCondition:
        loop()


rule "Feska - Selection HUD":
    createInWorldText(localPlayer if not Under_Attack and localPlayer.feska_choice_type != 0 and localPlayer.feska_visible else [], "{0}\n[近战]切换  长按[蹲]确认\n[换弹]刷新当前卡（每张一次）  [互动]隐藏".format("选择费斯卡科技（{0}/4）".format(len(localPlayer.feska_tech) + 1) if localPlayer.feska_choice_type == 1 else "锻体（待选 {0} 次）".format(localPlayer.feska_forge_pending)), feskaCardPosition(0, 0.95), 1.6, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.YELLOW, SpecVisibility.NEVER)
    createInWorldText(localPlayer if not Under_Attack and localPlayer.feska_choice_type != 0 and localPlayer.feska_visible else [], "┌── {0} ──┐\n\n{1}\n\n剩余刷新：{2}/1".format(Feska_Upgrades[localPlayer.feska_options[0]][0], Feska_Upgrades[localPlayer.feska_options[0]][1], 0 if localPlayer.feska_rerolled[0] else 1), feskaCardPosition(1.6, 0.1), 1.2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.YELLOW if localPlayer.feska_cursor == 0 else Color.WHITE, SpecVisibility.NEVER)
    createInWorldText(localPlayer if not Under_Attack and localPlayer.feska_choice_type != 0 and localPlayer.feska_visible else [], "┌── {0} ──┐\n\n{1}\n\n剩余刷新：{2}/1".format(Feska_Upgrades[localPlayer.feska_options[1]][0], Feska_Upgrades[localPlayer.feska_options[1]][1], 0 if localPlayer.feska_rerolled[1] else 1), feskaCardPosition(0, 0.1), 1.2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.YELLOW if localPlayer.feska_cursor == 1 else Color.WHITE, SpecVisibility.NEVER)
    createInWorldText(localPlayer if not Under_Attack and localPlayer.feska_choice_type != 0 and localPlayer.feska_visible else [], "┌── {0} ──┐\n\n{1}\n\n剩余刷新：{2}/1".format(Feska_Upgrades[localPlayer.feska_options[2]][0], Feska_Upgrades[localPlayer.feska_options[2]][1], 0 if localPlayer.feska_rerolled[2] else 1), feskaCardPosition(-1.6, 0.1), 1.2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.YELLOW if localPlayer.feska_cursor == 2 else Color.WHITE, SpecVisibility.NEVER)
    hudSubtext(getPlayers(Team.2), "费斯卡科技 {0}/4  |  锻体 {1} 次\n伤害 +{2}%  生命 {3}%  治疗 +{4}%".format(len(localPlayer.feska_tech), localPlayer.feska_forge_count, localPlayer.feska_bonus[0], 100 + localPlayer.feska_bonus[1], localPlayer.feska_bonus[2]), HudPosition.LEFT, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    hudSubtext(getPlayers(Team.2), "已选：{0}".format(localPlayer.feska_tech.map(lambda upgrade: Feska_Upgrades[upgrade][0])), HudPosition.LEFT, 1, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING)
    hudSubtext(getPlayers(Team.2).filter(lambda player: not Under_Attack and player.feska_choice_type != 0 and not player.feska_visible), "[互动]打开科技 / 锻体选择", HudPosition.LEFT, 2, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING)
