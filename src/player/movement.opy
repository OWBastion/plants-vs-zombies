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

    eventPlayer.stopForcingThrottle()
    waitUntil(not eventPlayer.isUsingUltimate(), 10)
    eventPlayer.startForcingThrottle(0, 0.01, 0, 0.01, 0, 0.01)
