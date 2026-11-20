#!mainFile "../main.opy"

# 准备阶段逐个预生成僵尸: 不在同一帧成批创建, 避免明显卡顿。
# 但间隔必须短到开波时本波配额已经全部到位: 最多 16 只在 0.16 秒间隔下 2.6 秒生成完,
# 远小于最短准备时间(15 秒), 所以每波一开始就是该波应有的数量, 不会再从 2 只慢慢加。
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
            createDummy(Hero.BRIGITTE, Team.1, -1, Zombie_Spawn_Positions[0].getPosition(), Brain_Positions[0])
        else:
            createDummy(
                random.choice(Zombie_Hero_Pool.filter(lambda hero: getNumberOfHeroes(hero, Team.1) == 0)),
                Team.1, -1, random.choice(Zombie_Spawn_Positions), Brain_Positions[0]
            )
        # 准备阶段玩家可以提前开火, 僵尸必须不可伤害, 否则波次没开始就少人。
        if Is_Attack_Phase == false:
            getPlayers(Team.1).setStatusEffect(null, Status.INVINCIBLE, Wave_Prep_Time_Left)
