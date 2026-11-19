#!mainFile "../main.opy"

rule "Disable Scoring, Intro hud, Arena Locations, Spawn Loc, Spawn detect":
    @Condition isGameInProgress() == true
    @Condition Current_Round >= 2

    wait(5)
    setMatchTime(900)


rule "Disable Scoring, Intro hud, Arena Locations, Spawn Loc, Spawn detect":
    @Condition isGameInProgress() == true
    @Condition Under_Attack == true
    @Condition Current_Round == Config_Total_Round

    wait(1)
    setMatchTime(Config_Round_Attack_Time + Config_Round_Lead_Time)


rule "Disable Scoring, Intro hud, Arena Locations, Spawn Loc, Spawn detect":
    # 关闭内置计分: 团队死斗的分数由本模式自己判定, 不让游戏模式改写
    disableScoring()
    disableGamemodeCompletion()
    #Arena locations
    if getCurrentMap() == Map.LIJIANG_NIGHT_MARKET:
        Bot_Respawn_Points = [vect(32, 0, -21.75), vect(42.35, 6, -46), vect(30, 6, -14.18), vect(40, 2, -41.8)]
        Brain_Points = [vect(88.5, 4.5, -25.5)]
    elif getCurrentMap() == Map.LIJIANG_CONTROL_CENTER:
        Bot_Respawn_Points = [vect(31.21, 267, 312), vect(20, 270, 347.29), vect(24, 267, 327.17)]
        Brain_Points = [vect(67.71, 267.45, 349.43)]
    elif getCurrentMap() == Map.LIJIANG_CONTROL_CENTER:
        Bot_Respawn_Points = [vect(31.21, 267, 312), vect(20, 270, 347.29), vect(24, 267, 327.17)]
        Brain_Points = [vect(67.71, 267.45, 349.43)]
    elif getCurrentMap() == Map.ILIOS_LIGHTHOUSE:
        Bot_Respawn_Points = [vect(355, -24.66, 1.66), vect(324, -24.7, -0.04), vect(332.12, -20.74, 11.47), vect(336.38, -16.26, 8.63)]
        Brain_Points = [vect(320, -23.97, 46.25)]
    elif getCurrentMap() == Map.ILIOS_RUINS:
        Bot_Respawn_Points = [vect(-28.86, 58.37, -156.1), vect(-18.58, 59.39, -143.9), vect(-22.15, 58.37, -170.63), vect(-26.53, 67.62, -179.83)]
        Brain_Points = [vect(-80.12, 63.04, -160.04)]
    elif getCurrentMap() == Map.ILIOS_WELL:
        Bot_Respawn_Points = [vect(-185.28, 5.03, -42.68), vect(-186.79, 3.78, -56.12), vect(-163.67, 4.86, -38.01)]
        Brain_Points = [vect(-148.32, -3.41, -93.48)]
    elif getCurrentMap() == Map.NEPAL_VILLAGE:
        Bot_Respawn_Points = [vect(-169.79, -95.24, -33.05), vect(-199.72, -97.33, -54.5), vect(-163.22, -89.21, -28.77)]
        Brain_Points = [vect(-157.45, -97.52, -80.77)]
    elif getCurrentMap() == Map.NEPAL_SHRINE:
        Bot_Respawn_Points = [vect(-47.22, 19, -48.04), vect(-23.7, 22, -57.43), vect(-56.61, 15, -61.61)]
        Brain_Points = [vect(-43.18, 16.38, -88.26)]
    elif getCurrentMap() == Map.NEPAL_SANCTUM:
        Bot_Respawn_Points = [vect(81.12, 131.88, -34.95), vect(66.36, 127.8, -42.32), vect(106.84, 141.85, -52.18)]
        Brain_Points = [vect(81.03, 130.03, -84.94)]
    else:
    createEffect(getPlayers(Team.2), Effect.SPHERE, Color.YELLOW, Bot_Respawn_Points[0], 0.3, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createEffect(getPlayers(Team.2), Effect.SPHERE, Color.YELLOW, Bot_Respawn_Points[1], 0.3, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createEffect(getPlayers(Team.2), Effect.SPHERE, Color.YELLOW, Bot_Respawn_Points[2], 0.3, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createEffect(getPlayers(Team.2), Effect.SPHERE, Color.YELLOW, Bot_Respawn_Points[3], 0.3, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createEffect(getPlayers(Team.2), Effect.LIGHT_SHAFT, Color.WHITE, Brain_Points[0], 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)


# 团队死斗会自动复活玩家; 关闭后由下方规则按波次复活
rule "Player Resurrect - Disable Built-in Respawn":
    @Event eachPlayer
    @Team 2
    @Condition eventPlayer.isDummy() == false

    eventPlayer.disableRespawn()


# 团队死斗的出生点随机, 重生室无法进入: 出生后统一传送。
# 僵尸只在比赛进行中传送到刷新点; 玩家无论是否开赛, 每次出生或被复活都落在脑子旁。
rule "[Mode]: Spawn Teleport":
    @Event eachPlayer
    @Condition eventPlayer.isAlive() == true
    @Condition (not eventPlayer.isDummy() or isGameInProgress()) == true
    @Condition len(Brain_Points) > 0

    if eventPlayer.isDummy():
        eventPlayer.teleport(random.choice(Bot_Respawn_Points))
        eventPlayer.Spawned_At = getTotalTimeElapsed()
        # 重生后清除上一条命的卡死计数, 避免沿用旧位置判定
        eventPlayer.stuck_count = 0
        eventPlayer.stuck_last_pos = eventPlayer.getPosition()
        # 重生后清除上一条命残留的移动锁定: 僵尸死亡时能力/锁定规则留下的强制油门、ROOTED、减速
        # 会跟着玩家槽位存活, 新命会原地不动并被卡死看门狗击杀
        eventPlayer.stopForcingThrottle()
        eventPlayer.clearStatusEffect(Status.ROOTED)
        # 与 [ai]: Create AI Bot 的基准速度一致; 能力残留的 setMoveSpeed 同样跨死亡保留
        eventPlayer.setMoveSpeed(90)
        # 实测请求值比实际复活等待多约 2 秒: 10 -> 约 8 秒, 6 -> 约 4 秒
        eventPlayer.setRespawnTime(6 if Current_Round == Config_Total_Round else 10)
    else:
        eventPlayer.teleport(Brain_Points[0])


# 开赛前选英雄不会触发重生, 换英雄后需要再传送一次
rule "[Mode]: Hero Change Teleport":
    @Event eachPlayer
    @Team 2
    @Condition eventPlayer.isDummy() == false
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.getHero() != eventPlayer.Teleported_Hero
    @Condition len(Brain_Points) > 0

    eventPlayer.Teleported_Hero = eventPlayer.getHero()
    eventPlayer.teleport(Brain_Points[0])


rule "Player Resurrect - Respawn at Brain Points":
    @Event playerDied
    @Team 2
    @Condition isGameInProgress() == true
    #@Condition Under_Attack != true
    @Condition eventPlayer.isAlive() != true
    #@Condition (Current_Round == 4 or Current_Round == 6 or Current_Round == 8 or Current_Round == 10) == true

    #waitUntil(Current_Round == 4 or Current_Round == 6 or Current_Round == 8 or Current_Round == 10, 999999986991104)
    eventPlayer.teleport(Brain_Points[0])
    waitUntil(not Under_Attack and ((Current_Round == 4 or Current_Round == 6 or Current_Round == 8 or Current_Round == 10) == true), 999999986991104)
    eventPlayer.resurrect()
