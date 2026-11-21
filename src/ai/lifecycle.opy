#!mainFile "../main.opy"

# 逐个生成以分散创建开销, 开波前由波次规则确认存活数量。
#!define AI_PRELOAD_INTERVAL 0.16

# 生成目标按难度爬到设置的上限(zombieAliveTarget), 不是每波都直接补到 AI 上限。
rule "[ai]: Create AI Bot":
    @Condition isGameInProgress() == true
    # 准备阶段预生成; 进攻阶段只在前段补齐减员, 波次末尾不再补人。
    @Condition (Is_Attack_Phase == false and isAssemblingHeroes() == false) or (Is_Attack_Phase == true and Wave_Attack_Time_Left > 10)
    @Condition getNumberOfPlayers(Team.1) < zombieAliveTarget()

    while getNumberOfPlayers(Team.1) < zombieAliveTarget():
        # 准备阶段与进攻阶段补齐用同一间隔。
        wait(AI_PRELOAD_INTERVAL, Wait.ABORT_WHEN_FALSE)
        if getNumberOfPlayers(Team.1) == 0:
            createDummy(Hero.BRIGITTE, Team.1, -1, Zombie_Spawn_Positions[0], Brain_Positions[0])
        else:
            createDummy(
                random.choice(Zombie_Hero_Pool.filter(lambda hero: getNumberOfHeroes(hero, Team.1) == 0)),
                Team.1, -1, random.choice(Zombie_Spawn_Positions), Brain_Positions[0]
            )
        # 倒计时归零后仍可能在补齐配额, 由进攻开始规则解除无敌。
        if Is_Attack_Phase == false:
            getPlayers(Team.1).setStatusEffect(null, Status.INVINCIBLE, 999999986991104)
