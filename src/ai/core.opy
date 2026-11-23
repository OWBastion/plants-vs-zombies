#!mainFile "../main.opy"

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
    elif eventPlayer.getHero() == Hero.DOOMFIST:
        eventPlayer.startForcingName("铁拳僵尸")
    elif eventPlayer.getHero() == Hero.WINSTON:
        eventPlayer.startForcingName("跳高僵尸")
    elif eventPlayer.getHero() == Hero.SIGMA:
        eventPlayer.startForcingName("欧美僵尸")
    elif eventPlayer.getHero() == Hero.TRACER:
        eventPlayer.startForcingName("闪现僵尸")
    elif eventPlayer.getHero() == Hero.ILLARI:
        eventPlayer.startForcingName("光塔僵尸")
    elif eventPlayer.getHero() == Hero.ANA:
        eventPlayer.startForcingName("老太僵尸")
    elif eventPlayer.getHero() == Hero.BAPTISTE:
        eventPlayer.startForcingName("弹跳僵尸")
    elif eventPlayer.getHero() == Hero.KIRIKO:
        eventPlayer.startForcingName("瞬移僵尸")


def refreshTarget():
    @Name "//AI Refresh Target"

    eventPlayer.Visible_Target_Candidates = getLivingPlayers(getOppositeTeam(eventPlayer.getTeam())).filter(lambda player: player.hasSpawned())
    eventPlayer.Visible_Target_Candidates = eventPlayer.Visible_Target_Candidates.filter(lambda player: player.getPosition().y - eventPlayer.getPosition().y <= 5.5 and distance(player.getPosition(), Brain_Positions[0].getPosition()) < distance(eventPlayer.getPosition(), Brain_Positions[0].getPosition()))
    eventPlayer.Visible_Target_Candidates = eventPlayer.Visible_Target_Candidates.filter(lambda player: isInLoS(eventPlayer.getEyePosition(), player))
    if len(eventPlayer.Visible_Target_Candidates) > 0:
        eventPlayer.Chase_Target_Player = sorted(eventPlayer.Visible_Target_Candidates, lambda player: distance(eventPlayer, player))[0]
    else:
        eventPlayer.Chase_Target_Player = null


def AITarget():
    @Name "//AI Target"

    if eventPlayer.Chase_Target_Player == null or eventPlayer.Chase_Target_Player.isAlive() != true or eventPlayer.Chase_Target_Player.hasSpawned() != true or eventPlayer.Chase_Target_Player.getPosition().y - eventPlayer.getPosition().y > 5.5 or eventPlayer.Target_Refresh_Time == 6:
        eventPlayer.Target_Refresh_Time = 0
        refreshTarget()
        chaseAtRate(eventPlayer.Target_Refresh_Time, 6, 1)


# 英雄移动速度设置下限是 50%, 更慢只能靠油门系数: 实际速度 = 设置速度 × 油门。
#!define AI_THROTTLE 0.85

# 近战触发距离。贴身即停手: 近战规则用它卡距离, 持续型技能用它在贴身时让位给普攻。
#!define ZOMBIE_MELEE_RANGE 3.5
#!define zombieInMeleeRange() (eventPlayer.Chase_Target_Player != null and eventPlayer.Chase_Target_Player.isAlive() and distance(eventPlayer, eventPlayer.Chase_Target_Player) <= ZOMBIE_MELEE_RANGE)


def AIMove():
    @Name "//AI Move"

    if eventPlayer.Chase_Target_Player == null or eventPlayer.Chase_Target_Player.isAlive() != true:
        eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), Brain_Positions[0].getPosition()), 270)
        eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, Brain_Positions[0].getPosition()), AI_THROTTLE, Relativity.TO_WORLD)
    else:
        eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), eventPlayer.Chase_Target_Player.getEyePosition() - vect(0, 0.3, 0)), 270)
        eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, eventPlayer.Chase_Target_Player), AI_THROTTLE, Relativity.TO_WORLD)


def stuckCheck():
    @Name "//AI Stuck Recovery"

    if (eventPlayer.Chase_Target_Player != null and eventPlayer.Chase_Target_Player.isAlive() and distance(eventPlayer, eventPlayer.Chase_Target_Player) <= ZOMBIE_MELEE_RANGE) or distance(eventPlayer, Brain_Positions[0]) <= 2.5:
        eventPlayer.No_Progress_Count = 0
        eventPlayer.Last_Progress_Position = eventPlayer.getPosition()
        return
    if eventPlayer.hasStatus(Status.STUNNED) or eventPlayer.hasStatus(Status.ROOTED) or eventPlayer.hasStatus(Status.FROZEN) or eventPlayer.hasStatus(Status.KNOCKED_DOWN):
        return
    if eventPlayer.isUsingAbility1() or eventPlayer.isUsingAbility2() or eventPlayer.isUsingUltimate():
        return
    # 持续无位置进展时刷新目标并跳跃，不因卡住击杀僵尸
    if distance(eventPlayer.getPosition(), eventPlayer.Last_Progress_Position) >= 1.5:
        eventPlayer.No_Progress_Count = 0
        eventPlayer.Last_Progress_Position = eventPlayer.getPosition()
    else:
        eventPlayer.No_Progress_Count += 1
        if eventPlayer.No_Progress_Count >= 3:
            eventPlayer.No_Progress_Count = 0
            eventPlayer.Last_Progress_Position = eventPlayer.getPosition()
            eventPlayer.Chase_Target_Player = null
            eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), Brain_Positions[0].getPosition()), 270)
            eventPlayer.forceButtonPress(Button.JUMP)


rule "//AI Move":
    @Event eachPlayer
    @Team 1
    @Condition eventPlayer.isAlive()
    @Condition eventPlayer.isDummy()
    @Condition Is_Attack_Phase

    wait(eventPlayer.getSlot() * 0.016, Wait.ABORT_WHEN_FALSE)
    AITarget()
    AIMove()
    stuckCheck()
    # 死亡/波次结束时立刻退出循环: 否则旧实例会带着上一命的相位继续运行, 重生后与实例重叠并加快卡死计数
    wait(0.8, Wait.ABORT_WHEN_FALSE)
    wait(0.3, Wait.ABORT_WHEN_FALSE)
    if ruleCondition:
        loop()
