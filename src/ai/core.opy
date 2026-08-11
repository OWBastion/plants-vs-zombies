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


def refreshTarget():
    @Name "//AI Refresh Target"

    eventPlayer.scan_candidates = getLivingPlayers(getOppositeTeam(eventPlayer.getTeam())).filter(lambda player: player.hasSpawned())
    eventPlayer.scan_candidates = eventPlayer.scan_candidates.filter(lambda player: player.getPosition().y - eventPlayer.getPosition().y <= 5.5 and distance(player.getPosition(), Brain_Points[0].getPosition()) < distance(eventPlayer.getPosition(), Brain_Points[0].getPosition()))
    eventPlayer.scan_candidates = eventPlayer.scan_candidates.filter(lambda player: isInLoS(eventPlayer.getEyePosition(), player))
    if len(eventPlayer.scan_candidates) > 0:
        eventPlayer.BotTarget = sorted(eventPlayer.scan_candidates, lambda player: distance(eventPlayer, player))[0]
    else:
        eventPlayer.BotTarget = null


def AITarget():
    @Name "//AI Target"

    if eventPlayer.BotTarget == null or eventPlayer.BotTarget.isAlive() != true or eventPlayer.BotTarget.hasSpawned() != true or eventPlayer.BotTarget.getPosition().y - eventPlayer.getPosition().y > 5.5 or eventPlayer.TTK == 6:
        eventPlayer.TTK = 0
        refreshTarget()
        chaseAtRate(eventPlayer.TTK, 6, 1)


def AIMove():
    @Name "//AI Move"

    if eventPlayer.BotTarget == null or eventPlayer.BotTarget.isAlive() != true:
        eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), Brain_Points[0].getPosition()), 270)
        eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, Brain_Points[0].getPosition()), 1, Relativity.TO_WORLD)
    else:
        eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), eventPlayer.BotTarget.getEyePosition() - vect(0, 0.3, 0)), 270)
        eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, eventPlayer.BotTarget), 1, Relativity.TO_WORLD)


def stuckCheck():
    @Name "//AI Stuck Recovery"

    # 正在近战攻击目标或已到达脑点: 不算卡死
    if (eventPlayer.BotTarget != null and eventPlayer.BotTarget.isAlive() and distance(eventPlayer, eventPlayer.BotTarget) <= 2.5) or distance(eventPlayer, Brain_Points[0]) <= 2.5:
        eventPlayer.stuck_count = 0
        eventPlayer.stuck_last_pos = eventPlayer.getPosition()
        return
    # 控制状态中: 不累计卡死判定
    if eventPlayer.hasStatus(Status.STUNNED) or eventPlayer.hasStatus(Status.ROOTED) or eventPlayer.hasStatus(Status.FROZEN) or eventPlayer.hasStatus(Status.KNOCKED_DOWN):
        return
    # 特殊能力激活期间: 不累计卡死判定 (能力自带移动/停顿, 不与基础寻路混判)
    if eventPlayer.isUsingAbility1() or eventPlayer.isUsingAbility2() or eventPlayer.isUsingUltimate():
        return
    # 持续无位置进展才判定卡死; 恢复梯度: 刷新目标/跳起 -> 持续失败后击杀重生
    if distance(eventPlayer.getPosition(), eventPlayer.stuck_last_pos) >= 1.5:
        eventPlayer.stuck_count = 0
        eventPlayer.stuck_last_pos = eventPlayer.getPosition()
    else:
        eventPlayer.stuck_count += 1
        if eventPlayer.stuck_count >= 5:
            eventPlayer.stuck_count = 0
            kill(eventPlayer)
        elif eventPlayer.stuck_count == 3:
            eventPlayer.BotTarget = null
            eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), Brain_Points[0].getPosition()), 270)
            eventPlayer.forceButtonPress(Button.JUMP)


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
    stuckCheck()
    wait(0.8)
    wait(0.3, Wait.ABORT_WHEN_FALSE)
    if ruleCondition:
        loop()
