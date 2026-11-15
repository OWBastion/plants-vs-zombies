rule "[debug.opy]: player debug (Top Right)":
    @Event eachPlayer
    @Condition Debug == true

    hudSubheader(eventPlayer, "重生室位置 = {0}".format(getSpawnPoints(Team.1).getPosition()), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    hudSubheader(eventPlayer, "重生室 = {0}/{1}".format(getLivingPlayers(Team.1).filter(lambda player: distance(player.getPosition(), getSpawnPoints(Team.1).getPosition()) <= 25), len(getLivingPlayers(Team.1))), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    hudSubheader(eventPlayer, "距离 = {0}".format(distance(eventPlayer.getPosition(), getSpawnPoints(Team.1).getPosition())), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    #hudSubheader(eventPlayer, "正在使用终极技能 = {0}".format(eventPlayer.isUsingUltimate()), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    #hudSubheader(eventPlayer, "正在使用主要武器 = {0}".format(eventPlayer.isFiringPrimaryFire()), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    #hudSubheader(eventPlayer, "正在使用辅助武器 = {0}".format(eventPlayer.isFiringSecondaryFire()), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    #hudSubheader(eventPlayer, "主要武器 资源 = {0}".format(eventPlayer.getAbilityResource(Button.PRIMARY_FIRE)), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    #hudSubheader(eventPlayer, "辅助武器 冷却时间 = {0}".format(eventPlayer.getAbilityCooldown(Button.SECONDARY_FIRE)), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    #hudSubheader(eventPlayer, "辅助武器 充能 = {0}".format(eventPlayer.getAbilityCharge(Button.SECONDARY_FIRE)), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    #hudSubheader(eventPlayer, "辅助武器 资源 = {0}".format(eventPlayer.getAbilityResource(Button.SECONDARY_FIRE)), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    #hudSubheader(eventPlayer, "R 冷却时间 = {0}".format(eventPlayer.getAbilityCooldown(Button.RELOAD)), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    #hudSubheader(eventPlayer, "isUsingAbility1() = {}".format(eventPlayer.isUsingAbility1()), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    #hudSubheader(eventPlayer, "正在使用技能 1 = {0}".format(eventPlayer.isUsingAbility1()), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    #hudSubheader(eventPlayer, "技能 1 冷却时间 = {0}".format(eventPlayer.getAbilityCooldown(Button.ABILITY_1)), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    #hudSubheader(eventPlayer, "技能 1 充能数量 = {0}".format(eventPlayer.getAbilityCharge(Button.ABILITY_1)), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    #hudSubheader(eventPlayer, "isUsingAbility2() = {}".format(eventPlayer.isUsingAbility2()), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    #hudSubheader(eventPlayer, "正在使用技能 2 = {0}".format(eventPlayer.isUsingAbility2()), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    #hudSubheader(eventPlayer, "技能 2 冷却时间 = {0}".format(eventPlayer.getAbilityCooldown(Button.ABILITY_2)), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    #hudSubheader(eventPlayer, "技能 2 充能数量 = {0}".format(eventPlayer.getAbilityCharge(Button.ABILITY_2)), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    hudSubheader(eventPlayer, "当前位置 = {0}".format(eventPlayer.getPosition()), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    #hudSubheader(eventPlayer, "当前速度 = {0}".format(eventPlayer.getSpeed()), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    #hudSubheader(eventPlayer, "当前速率 = {0}".format(eventPlayer.getVelocity()), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)


rule "[Debug]: Log zombie deaths":
    @Event playerDied
    @Team 1
    @Condition Debug == true

    enableInspector()
    logToInspector("僵尸阵亡 存活 {0}s 位置 {1} 击杀者 {2} 卡死计数 {3} 回合 {4} 进攻中 {5}".format(getTotalTimeElapsed() - eventPlayer.Spawned_At, eventPlayer.getPosition(), attacker, eventPlayer.stuck_count, Current_Round, Under_Attack))
