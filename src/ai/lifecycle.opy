#!mainFile "../main.opy"

# 准备阶段逐个预生成僵尸: 把创建开销摊到整段准备时间, 开波瞬间不再成批创建, 避免明显卡顿。
# 间隔要保证 AI 上限(最多 16)在最短准备时间(15 秒)内生成完。
#!define AI_PRELOAD_INTERVAL 0.8

# 生成目标按难度爬到设置的上限(zombieAliveTarget), 不是每波都直接补到 AI 上限。
rule "[ai]: Create AI Bot":
    @Condition isGameInProgress() == true
    # 准备阶段预生成; 进攻阶段只在前段补齐减员, 波次末尾不再补人。
    @Condition (Is_Attack_Phase == false and isAssemblingHeroes() == false) or (Is_Attack_Phase == true and Wave_Attack_Time_Left > 10)
    @Condition getNumberOfPlayers(Team.1) < zombieAliveTarget()

    while getNumberOfPlayers(Team.1) < zombieAliveTarget():
        # 进攻阶段的补齐间隔与原实现一致。
        wait(AI_PRELOAD_INTERVAL if Is_Attack_Phase == false else 0.16, Wait.ABORT_WHEN_FALSE)
        if getNumberOfPlayers(Team.1) == 0:
            createDummy(Hero.BRIGITTE, Team.1, -1, Zombie_Spawn_Positions[0].getPosition(), Brain_Positions[0])
        else:
            createDummy(Zombie_Hero_Pool.filter(lambda x: getNumberOfHeroes(x, Team.1) <= 3), Team.1, -1, random.choice(Zombie_Spawn_Positions), Brain_Positions[0])
        # 准备阶段玩家可以提前开火, 僵尸必须不可伤害, 否则波次没开始就少人。
        if Is_Attack_Phase == false:
            getPlayers(Team.1).setStatusEffect(null, Status.INVINCIBLE, Wave_Prep_Time_Left)


# 出生与重生都补满生命值。
# settings 的 health% 与 setMaxHealth 只抬上限不回血: 重生时上限按 settings 重新写入,
# 当前生命却从上一条命继承, 僵尸会带残血复活被玩家直接秒掉。
# 上限写入不在出生当帧完成, 因此等 6 帧再读 getMaxHealth, 拿到的才是最终上限。
rule "[ai]: Refill health on spawn":
    @Event eachPlayer
    @Team 1
    @Condition eventPlayer.isDummy() == true
    @Condition eventPlayer.isAlive() == true

    wait(0.1, Wait.ABORT_WHEN_FALSE)
    eventPlayer.setHealth(eventPlayer.getMaxHealth())
