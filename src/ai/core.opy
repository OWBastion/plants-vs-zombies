rule "[ai]: Set Bot Name":
    @Event eachPlayer
    @Team 1

    if eventPlayer.getHero() == Hero.BRIGITTE:
        eventPlayer.startForcingName("摇旗僵尸")
    elif eventPlayer.getHero() == Hero.DVA:
        eventPlayer.startForcingName("机甲僵尸")
    elif eventPlayer.getHero() == Hero.JUNO:
        eventPlayer.startForcingName("蹦极僵尸")
    elif eventPlayer.getHero() == Hero.HAZARD:
        eventPlayer.startForcingName("尖刺僵尸")
    elif eventPlayer.getHero() == Hero.JUNKER_QUEEN:
        eventPlayer.startForcingName("女王僵尸")
    elif eventPlayer.getHero() == Hero.ORISA:
        eventPlayer.startForcingName("钢板僵尸")
    elif eventPlayer.getHero() == Hero.RAMATTRA:
        eventPlayer.startForcingName("铁桶僵尸")
    elif eventPlayer.getHero() == Hero.REINHARDT:
        eventPlayer.startForcingName("冲锋僵尸")
    elif eventPlayer.getHero() == Hero.ROADHOG:
        eventPlayer.startForcingName("猪肉僵尸")
    elif eventPlayer.getHero() == Hero.ZARYA:
        eventPlayer.startForcingName("泡泡僵尸")
    elif eventPlayer.getHero() == Hero.MAUGA:
        eventPlayer.startForcingName("冲锋僵尸")
    elif eventPlayer.getHero() == Hero.ASHE:
        eventPlayer.startForcingName("炸药僵尸")
    elif eventPlayer.getHero() == Hero.BASTION:
        eventPlayer.startForcingName("机械僵尸")
    elif eventPlayer.getHero() == Hero.CASSIDY:
        eventPlayer.startForcingName("翻滚僵尸")
    elif eventPlayer.getHero() == Hero.ECHO:
        eventPlayer.startForcingName("飞行僵尸")
    elif eventPlayer.getHero() == Hero.GENJI:
        eventPlayer.startForcingName("跳跳僵尸")
    elif eventPlayer.getHero() == Hero.FREJA:
        eventPlayer.startForcingName("飞天僵尸")
    elif eventPlayer.getHero() == Hero.HANZO:
        eventPlayer.startForcingName("跳跳僵尸")
    elif eventPlayer.getHero() == Hero.PHARAH:
        eventPlayer.startForcingName("气球僵尸")
    elif eventPlayer.getHero() == Hero.SOLDIER:
        eventPlayer.startForcingName("跑步僵尸")
    elif eventPlayer.getHero() == Hero.SOJOURN:
        eventPlayer.startForcingName("滑铲僵尸")
    elif eventPlayer.getHero() == Hero.SOMBRA:
        eventPlayer.startForcingName("隐身僵尸")
    elif eventPlayer.getHero() == Hero.SYMMETRA:
        eventPlayer.startForcingName("摄像头僵尸")
    elif eventPlayer.getHero() == Hero.TORBJORN:
        eventPlayer.startForcingName("矮人僵尸")
    elif eventPlayer.getHero() == Hero.VENTURE:
        eventPlayer.startForcingName("矿工僵尸")
    elif eventPlayer.getHero() == Hero.LUCIO:
        eventPlayer.startForcingName("音乐僵尸")
    elif eventPlayer.getHero() == Hero.MOIRA:
        eventPlayer.startForcingName("生化僵尸")
    elif eventPlayer.getHero() == Hero.ZENYATTA:
        eventPlayer.startForcingName("出家僵尸")
    elif eventPlayer.getHero() == Hero.WIDOWMAKER:
        eventPlayer.startForcingName("抓钩僵尸")
    elif eventPlayer.getHero() == Hero.REAPER:
        eventPlayer.startForcingName("活神")
    else:


def AITarget():
    @Name "//AI Target"

    if eventPlayer.BotTarget == null or eventPlayer.BotTarget.isDead():
        eventPlayer.TTK = 0
        eventPlayer.BotTarget = random.choice(getLivingPlayers(getOppositeTeam(eventPlayer.getTeam())).filter(lambda player: isInLoS(eventPlayer.getEyePosition(), player) and player.hasSpawned() and player.getPosition().y - eventPlayer.getPosition().y <= 5.5))
        chaseAtRate(eventPlayer.TTK, 6, 1)
    elif eventPlayer.TTK == 6:
        eventPlayer.TTK = 0
        eventPlayer.BotTarget = random.choice(getLivingPlayers(getOppositeTeam(eventPlayer.getTeam())).filter(lambda player: isInLoS(eventPlayer.getEyePosition(), player) and player.hasSpawned() and player.getPosition().y - eventPlayer.getPosition().y <= 5.5))
        chaseAtRate(eventPlayer.TTK, 6, 1)


def AIMove():
    @Name "//AI Move"

    if eventPlayer.BotTarget == null or distance(eventPlayer, Brain_Points[0].getPosition()) <= distance(eventPlayer, eventPlayer.BotTarget):
        eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), Brain_Points[0].getPosition()), 270)
        eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, Brain_Points[0].getPosition()), 1, Relativity.TO_WORLD)
        if eventPlayer.getHorizontalSpeed() <= 1 and distance(eventPlayer, Brain_Points[0].getPosition()) >= 15 and distance(eventPlayer, getClosestPlayer(eventPlayer, Team.1)) >= 15:
            #if eventPlayer.getSlot() != 2:
            kill(eventPlayer)
            #else:
            #eventPlayer.teleport(getClosestPlayer(eventPlayer, Team.2))
            #__end__()
    else:
        eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), eventPlayer.BotTarget.getEyePosition() - vect(0, 0.3, 0)), 270)
        eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, eventPlayer.BotTarget), 1, Relativity.TO_WORLD)


rule "//AI Move":
    @Event eachPlayer
    @Team 1
    @Condition eventPlayer.isAlive() == true
    #@Condition isGameInProgress() == true
    #@Condition eventPlayer.getSlot() > 2
    @Condition eventPlayer.isDummy() == true
    @Condition Under_Attack == true

    wait(eventPlayer.getSlot() * 0.016, Wait.ABORT_WHEN_FALSE)
    AITarget()
    AIMove()
    eventPlayer.forceButtonPress(Button.JUMP)
    eventPlayer.forceButtonPress(Button.MELEE)
    wait(0.8)
    wait(0.3, Wait.ABORT_WHEN_FALSE)
    if ruleCondition:
        loop()
