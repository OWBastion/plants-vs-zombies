#!mainFile "../main.opy"

globalvar Zombie_Count_Before_Spawn

# 逐个生成以分散创建开销。
#!define AI_PRELOAD_INTERVAL 0.16

# 补齐窗口: 准备阶段(集结结束后)到进攻阶段前段。
#!define zombieSpawnWindow() ((Is_Attack_Phase == false and isAssemblingHeroes() == false) or (Is_Attack_Phase == true and Wave_Attack_Time_Left > 10))
# 到配额就不再加人。准备阶段按"已发起的生成次数"算, 进攻阶段按存活数算(死亡补位)。
# 不用队伍玩家数当循环条件: 它是槽位数, 和"扩展能生成多少只机器人"不是一回事。
#!define zombieNeedsSpawn() (Zombie_Spawn_Count < zombieWaveQuotaNow() if Is_Attack_Phase == false else getNumberOfLivingPlayers(Team.1) < zombieWaveQuotaNow())

rule "[ai]: Create AI Bot":
    @Condition isGameInProgress() == true
    @Condition zombieSpawnWindow()
    @Condition zombieNeedsSpawn()

    # 按配额一只只循环生成, 计数自己维护。生成更多机器人扩展把每队的机器人上限抬高,
    # 所以这里直接发满配额, 不做任何 6 只之类的自我限制。
    Zombie_Count_Before_Spawn = -1
    while zombieNeedsSpawn() and zombieSpawnWindow():
        wait(AI_PRELOAD_INTERVAL)
        if Zombie_Spawn_Count == 0:
            Zombie_Count_Before_Spawn = 0
            createDummy(Hero.BRIGITTE, Team.1, -1, Zombie_Spawn_Positions[0], Brain_Positions[0])
        elif getNumberOfPlayers(Team.1) == Zombie_Count_Before_Spawn and getNumberOfPlayers(Team.1) > 0:
            # 工坊可能拒绝加载新的英雄模型。数量没增加时, 复用已经在场的英雄。
            createDummy(random.choice(getPlayers(Team.1)).getHero(), Team.1, -1, random.choice(Zombie_Spawn_Positions), Brain_Positions[0])
        else:
            Zombie_Count_Before_Spawn = getNumberOfPlayers(Team.1)
            # 传英雄数组让引擎随机挑一个: 每队同英雄最多 2 个(heroLimit), 用 <= 1 保证池子不会被筛空。
            createDummy(
                Zombie_Hero_Pool.filter(lambda hero: getNumberOfHeroes(hero, Team.1) <= 1),
                Team.1, -1, random.choice(Zombie_Spawn_Positions), Brain_Positions[0]
            )
        Zombie_Spawn_Count += 1
        # 倒计时归零后仍可能在补齐配额, 由进攻开始规则解除无敌。
        if Is_Attack_Phase == false:
            getPlayers(Team.1).setStatusEffect(null, Status.INVINCIBLE, 999999986991104)
