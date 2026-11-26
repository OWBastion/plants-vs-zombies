#!mainFile "../main.opy"

# 玩家落点。脑子坐标贴着地面或嵌在地形里, 直接传送会穿模掉出地图, 因此抬高 1.5 米再落到地面。
# 只用于玩家传送: Brain_Positions 本身仍是僵尸寻路目标与吃脑判定点。
#!define PLAYER_SPAWN_POSITION() (Brain_Positions[0] + vect(0, 1.5, 0))

rule "[Mode]: Pause built-in match timer":
    @Condition isGameInProgress()

    # 波次计时独立运行，避免团队死斗的计时先归零而影响僵尸自动复活。
    pauseMatchTime()


rule "Disable Scoring, Intro hud, Arena Locations, Spawn Loc, Spawn detect":
    disableScoring()
    disableGamemodeCompletion()
    if getCurrentMap() == Map.LIJIANG_NIGHT_MARKET:
        Zombie_Spawn_Positions = [vect(32, 0, -21.75), vect(42.35, 6, -46), vect(30, 6, -14.18), vect(40, 2, -41.8)]
        Brain_Positions = [vect(88.5, 4.5, -25.5)]
    elif getCurrentMap() == Map.LIJIANG_CONTROL_CENTER:
        Zombie_Spawn_Positions = [vect(31.21, 267, 312), vect(20, 270, 347.29), vect(24, 267, 327.17)]
        Brain_Positions = [vect(67.71, 267.45, 349.43)]
    elif getCurrentMap() == Map.LIJIANG_GARDEN:
        Zombie_Spawn_Positions = [vect(36.46, 94.50, 150.06)]
        Brain_Positions = [vect(91.65, 96.51, 143.77)]
    elif getCurrentMap() == Map.ILIOS_LIGHTHOUSE:
        Zombie_Spawn_Positions = [vect(355, -24.66, 1.66), vect(324, -24.7, -0.04), vect(332.12, -20.74, 11.47), vect(336.38, -16.26, 8.63)]
        Brain_Positions = [vect(320, -23.97, 46.25)]
    elif getCurrentMap() == Map.ILIOS_RUINS:
        Zombie_Spawn_Positions = [vect(-18.58, 59.39, -143.9), vect(-36.83, 60.49, -147.35), vect(-26.53, 67.62, -179.83)]
        Brain_Positions = [vect(-80.12, 63.04, -160.04)]
    elif getCurrentMap() == Map.ILIOS_WELL:
        Zombie_Spawn_Positions = [vect(-185.28, 5.03, -42.68), vect(-186.79, 3.78, -56.12), vect(-178.11, -1.52, -50.27)]
        Brain_Positions = [vect(-148.32, -3.41, -93.48)]
    elif getCurrentMap() == Map.NEPAL_VILLAGE:
        Zombie_Spawn_Positions = [vect(-169.79, -95.24, -33.05), vect(-199.72, -97.33, -54.5), vect(-163.22, -89.21, -28.77)]
        Brain_Positions = [vect(-157.45, -97.52, -80.77)]
    elif getCurrentMap() == Map.NEPAL_SHRINE:
        Zombie_Spawn_Positions = [vect(-47.22, 19, -48.04), vect(-23.7, 22, -57.43), vect(-56.61, 15, -61.61)]
        Brain_Positions = [vect(-43.18, 16.38, -88.26)]
    elif getCurrentMap() == Map.NEPAL_SANCTUM:
        Zombie_Spawn_Positions = [vect(81.12, 131.88, -34.95), vect(75.27, 130.42, -42.12), vect(106.84, 141.85, -52.18)]
        Brain_Positions = [vect(81.03, 132.93, -84.94)]
    elif getCurrentMap() == Map.HOLLYWOOD_HALLOWEEN or getCurrentMap() == Map.HOLLYWOOD:
        Zombie_Spawn_Positions = [vect(-2.61, 1.32, -53.50), vect(22.06, 1.48, -26.84), vect(6.88, 12.41, -53.84)]
        Brain_Positions = [vect(-5.90, 1.25, -9.61)]
    elif getCurrentMap() == Map.BLACK_FOREST_WINTER:
        Zombie_Spawn_Positions = [vect(-18.94, 17.47, -16.34), vect(16.27, 12.55, -16.15), vect(-6.83, 17.66, -10.02)]
        Brain_Positions = [vect(-17.01, 12.52, 23.54)]
    elif getCurrentMap() == Map.OASIS_CITY_CENTER:
        Zombie_Spawn_Positions = [vect(154.30, 3.41, 213.54), vect(167.71, 0.69, 205.37)]
        Brain_Positions = [vect(184.930, 0.35, 183.59)]
    elif getCurrentMap() == Map.EICHENWALDE:
        Zombie_Spawn_Positions = [vect(75.47, 10.13, -110.66), vect(63.35, 14.12, -60.61)]
        Brain_Positions = [vect(89.11, 12.68, -64.00)]
    elif getCurrentMap() == Map.TEMPLE_OF_ANUBIS:
        Zombie_Spawn_Positions = [vect(-10.03, 3.50, 75.10), vect(-9.74, 13.93, 82.48)]
        Brain_Positions = [vect(-7.29, 4.20, 112.46)]
    elif getCurrentMap() == Map.ROUTE66:
        Zombie_Spawn_Positions = [vect(-40.92, 2.81, -37.62), vect(-36.01, 8.280, -44.02)]
        Brain_Positions = [vect(7.15, 1.60, -10.99)]
    elif getCurrentMap() == Map.HORIZON_LUNAR_COLONY:
        Zombie_Spawn_Positions = [vect(-29.20, 4.16, -97.13), vect(-9.47, 5.46, -100.14), vect(-4.01, 9.21, -115.65)]
        Brain_Positions = [vect(-28.75, 3.40, -129.45)]
    elif getCurrentMap() == Map.KINGS_ROW or getCurrentMap() == Map.KINGS_ROW_WINTER:
        Zombie_Spawn_Positions = [vect(-83.46, 0.07, -40.96), vect(-82.36, 3.14, -35.83), vect(-56.06, -0.5, 1.93)]
        Brain_Positions = [vect(-94.87, 0.56, 8.13)]
    elif getCurrentMap() == Map.DORADO:
        Zombie_Spawn_Positions = [vect(107.23, 17.54, 17.08), vect(99.31, 19.95, 27.42), vect(115.25, 10.34, 8.1l9)]
        Brain_Positions = [vect(137.23, 11.06, 27.95)]
    elif getCurrentMap() == Map.PARIS:
        Zombie_Spawn_Positions = [vect(-81.24, 10.93, -54.58), vect(-109.65, 10.14, -67.57), vect(-81.94, 11.50, -63.47)]
        Brain_Positions = [vect(-99.32, 11.50, -91.26)]
    elif getCurrentMap() == Map.VOLSKAYA:
        Zombie_Spawn_Positions = [vect(-66.12, -3.46, 66.52), vect(-105.17, -4.48, 72.17)]
        Brain_Positions = [vect(-108.04, -2.66, 40.88)]
    # 刷新点黄球与脑子白光柱只是调试标记, 关闭 Debug 时不生成。
    # 各图刷新点数量不同(庭院 1 个、艾兴瓦尔德 2 个), 越界索引会取到无效坐标, 按实际长度逐个判。
    if Debug_Enabled:
        createEffect(getPlayers(Team.2), Effect.SPHERE, Color.YELLOW, Zombie_Spawn_Positions[0], 0.3, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        if len(Zombie_Spawn_Positions) > 1:
            createEffect(getPlayers(Team.2), Effect.SPHERE, Color.YELLOW, Zombie_Spawn_Positions[1], 0.3, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        if len(Zombie_Spawn_Positions) > 2:
            createEffect(getPlayers(Team.2), Effect.SPHERE, Color.YELLOW, Zombie_Spawn_Positions[2], 0.3, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        if len(Zombie_Spawn_Positions) > 3:
            createEffect(getPlayers(Team.2), Effect.SPHERE, Color.YELLOW, Zombie_Spawn_Positions[3], 0.3, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createEffect(getPlayers(Team.2), Effect.LIGHT_SHAFT, Color.WHITE, Brain_Positions[0], 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)


rule "Player Resurrect - Disable Built-in Respawn":
    @Event eachPlayer
    @Team 2
    @Condition not eventPlayer.isDummy()

    eventPlayer.disableRespawn()


# 团队死斗的出生点随机, 重生室无法进入: 出生后统一传送。
# 僵尸只在比赛进行中传送到刷新点; 玩家无论是否开赛, 每次出生或被复活都落在脑子旁。
rule "[Mode]: Spawn Teleport":
    @Event eachPlayer
    @Condition eventPlayer.isAlive()
    @Condition not eventPlayer.isDummy() or isGameInProgress()
    @Condition len(Brain_Positions) > 0

    if eventPlayer.isDummy():
        eventPlayer.teleport(random.choice(Zombie_Spawn_Positions))
        eventPlayer.Spawn_Time = getTotalTimeElapsed()
        eventPlayer.No_Progress_Count = 0
        eventPlayer.Last_Progress_Position = eventPlayer.getPosition()
        # 重生后清除上一条命残留的移动锁定: 僵尸死亡时能力/锁定规则留下的强制油门、ROOTED、减速
        # 会跟着玩家槽位存活, 新命会原地不动并被卡死看门狗击杀
        eventPlayer.stopForcingThrottle()
        eventPlayer.clearStatusEffect(Status.ROOTED)
        if eventPlayer.getTeam() == Team.1 and (not Is_Attack_Phase or Wave_Attack_Time_Left > 0):
            eventPlayer.enableRespawn()
        # 实测请求值比实际复活等待多约 2 秒: 5 -> 约 3 秒, 3 -> 约 1 秒
        eventPlayer.setRespawnTime(2 if Current_Wave == Total_Wave_Count else 4)
    else:
        eventPlayer.teleport(PLAYER_SPAWN_POSITION())


# 开赛前选英雄不会触发重生, 换英雄后需要再传送一次
rule "[Mode]: Hero Change Teleport":
    @Event eachPlayer
    @Team 2
    @Condition not eventPlayer.isDummy()
    @Condition eventPlayer.isAlive()
    @Condition eventPlayer.getHero() != eventPlayer.Last_Teleported_Hero
    @Condition len(Brain_Positions) > 0

    eventPlayer.Last_Teleported_Hero = eventPlayer.getHero()
    eventPlayer.teleport(PLAYER_SPAWN_POSITION())


rule "Player Resurrect - Move Dead Players to Brain Points":
    @Event playerDied
    @Team 2
    @Condition isGameInProgress()
    @Condition not eventPlayer.isAlive()

    eventPlayer.teleport(PLAYER_SPAWN_POSITION())
