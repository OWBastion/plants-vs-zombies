rule "[Player]: Stop move when under attack":
    @Event eachPlayer
    @Team 1
    @Condition Debug != true
    @Condition Under_Attack != true

    eventPlayer.startForcingThrottle(0, 0.01, 0, 0.01, 0, 0.01)
    eventPlayer.setStatusEffect(null, Status.ROOTED, 999999986991104)
    waitUntil(Under_Attack, 999999986991104)
    eventPlayer.clearStatusEffect(Status.ROOTED)
    eventPlayer.stopForcingThrottle()


rule "[Player]: Stop move when under attack":
    @Event eachPlayer
    @Team 2
    @Condition Debug != true
    @Condition Under_Attack == true
    @Condition eventPlayer.getHero() != Hero.TORBJORN

    smallMessage(eventPlayer, "  无法移动，正在防御中")
    eventPlayer.startForcingThrottle(0, 0.01, 0, 0.01, 0, 0.01)
    #eventPlayer.setStatusEffect(null, Status.ROOTED, 999999986991104)
    waitUntil(not Under_Attack, 999999986991104)
    smallMessage(eventPlayer, "  准备阶段，可以移动")
    eventPlayer.clearStatusEffect(Status.ROOTED)
    eventPlayer.stopForcingThrottle()


rule "[Player]: ult reset":
    @Event eachPlayer
    @Team 2
    @Condition eventPlayer.isUsingUltimate() == true
    @Condition eventPlayer.getHero() in [Hero.DOOMFIST, Hero.BASTION, Hero.REAPER] == true
    # 狂战士之魂激活期间保持自由移动, 不因大招的移动恢复路径重新上定点油门。
    @Condition eventPlayer.feska_berserk != true

    eventPlayer.stopForcingThrottle()
    waitUntil(not eventPlayer.isUsingUltimate(), 10)
    # 大招期间可能触发狂战士, 结束时再核对一次, 不把已自由移动的玩家重新定点。
    if eventPlayer.feska_berserk != true:
        eventPlayer.startForcingThrottle(0, 0.01, 0, 0.01, 0, 0.01)
