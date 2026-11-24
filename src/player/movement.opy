#!mainFile "../main.opy"

# 进攻阶段仍可自由移动的英雄: 托比昂、死怨与斩仇。
# 定点规则与重生后的移动恢复共用这一份名单, 避免两处各写一套导致复活后被重新定点。
#!define FREE_MOVE_HEROES [Hero.TORBJORN, Hero.SHION, Hero.REAPER]

rule "[Player]: Stop move when under attack":
    @Event eachPlayer
    @Team 1
    @Condition not Debug_Enabled
    @Condition not Is_Attack_Phase

    eventPlayer.startForcingThrottle(0, 0.01, 0, 0.01, 0, 0.01)
    eventPlayer.setStatusEffect(null, Status.ROOTED, 999999986991104)
    waitUntil(Is_Attack_Phase, 999999986991104)
    eventPlayer.clearStatusEffect(Status.ROOTED)
    eventPlayer.stopForcingThrottle()


rule "[Player]: Stop move when under attack":
    @Event eachPlayer
    @Team 2
    @Condition not Debug_Enabled
    @Condition Is_Attack_Phase
    @Condition eventPlayer.getHero() not in FREE_MOVE_HEROES

    smallMessage(eventPlayer, "  无法移动，正在防御中")
    eventPlayer.startForcingThrottle(0, 0.01, 0, 0.01, 0, 0.01)
    waitUntil(not Is_Attack_Phase, 999999986991104)
    smallMessage(eventPlayer, "  准备阶段，可以移动")
    eventPlayer.clearStatusEffect(Status.ROOTED)
    eventPlayer.stopForcingThrottle()


rule "[Player]: ult reset":
    @Event eachPlayer
    @Team 2
    @Condition not Debug_Enabled
    @Condition Is_Attack_Phase
    @Condition eventPlayer.isUsingUltimate()
    @Condition eventPlayer.getHero() in [Hero.DOOMFIST, Hero.BASTION, Hero.REAPER]
    # 狂战士之魂激活期间保持自由移动, 不因大招的移动恢复路径重新上定点油门。
    @Condition not eventPlayer.Is_Berserk

    eventPlayer.stopForcingThrottle()
    waitUntil(not eventPlayer.isUsingUltimate(), 10)
    # 大招期间可能触发狂战士, 结束时再核对一次, 不把已自由移动的玩家重新定点。
    if Debug_Enabled != true and Is_Attack_Phase and eventPlayer.getHero() in [Hero.DOOMFIST, Hero.BASTION, Hero.REAPER] and eventPlayer.Is_Berserk != true:
        eventPlayer.startForcingThrottle(0, 0.01, 0, 0.01, 0, 0.01)
