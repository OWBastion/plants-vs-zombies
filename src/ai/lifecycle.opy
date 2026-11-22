#!mainFile "../main.opy"

globalvar Zombie_Count_Before_Spawn

# 逐个生成以分散创建开销。
#!define AI_PRELOAD_INTERVAL 0.16

# 补齐窗口: 准备阶段(集结结束后)到进攻阶段前段。
#!define zombieSpawnWindow() (Wave_Attack_Time_Left > 10 if Is_Attack_Phase else not isAssemblingHeroes())
# 死亡的机器人仍占位，留给自动复活。
#!define zombieNeedsSpawn() (getNumberOfPlayers(Team.1) < zombieWaveQuotaNow() and len(Zombie_Wave_Heroes) > 0)

rule "[ai]: Create AI Bot":
    @Condition isGameInProgress()
    @Condition zombieSpawnWindow()
    @Condition zombieNeedsSpawn()

    wait(AI_PRELOAD_INTERVAL)
    if Debug_Enabled:
        logToInspector("[生成] 循环启动 难度 {0} AI上限 {1} 波 {2} 进攻中 {3} 队伍1 {4} 配额 {5} 队列 {6}".format(Difficulty_Level, Zombie_Alive_Limit, Current_Wave, Is_Attack_Phase, getNumberOfPlayers(Team.1), zombieWaveQuotaNow(), len(Zombie_Wave_Heroes)))
    while zombieNeedsSpawn() and zombieSpawnWindow():
        Zombie_Count_Before_Spawn = getNumberOfPlayers(Team.1)
        if Debug_Enabled:
            logToInspector("[生成] 尝试 英雄 {0} 队伍1 {1} 存活 {2} 配额 {3} 队列 {4}".format(Zombie_Wave_Heroes[0], Zombie_Count_Before_Spawn, getNumberOfLivingPlayers(Team.1), zombieWaveQuotaNow(), len(Zombie_Wave_Heroes)))
        createDummy(Zombie_Wave_Heroes[0], Team.1, -1, random.choice(Zombie_Spawn_Positions), Brain_Positions[0])
        # 实测机器人在同一秒内加入, 1 秒内没加入就是被拒绝。
        waitUntil(getNumberOfPlayers(Team.1) > Zombie_Count_Before_Spawn, 1)
        if Debug_Enabled:
            logToInspector("[生成] 结果 {0} 队伍1 {1} 存活 {2} 失败累计 {3}".format("成功" if getNumberOfPlayers(Team.1) > Zombie_Count_Before_Spawn else "失败", getNumberOfPlayers(Team.1), getNumberOfLivingPlayers(Team.1), Zombie_Spawn_Failures))
        if getNumberOfPlayers(Team.1) > Zombie_Count_Before_Spawn:
            if not Is_Attack_Phase:
                getPlayers(Team.1).setStatusEffect(null, Status.INVINCIBLE, 999999986991104)
            wait(AI_PRELOAD_INTERVAL)
        else:
            # 工坊拒绝加载新的英雄模型(实测队伍 1 有 3 种英雄后新英雄全部失败), 但场上已有的英雄总能再生成。
            # 被拒绝的英雄丢弃, 改为复制场上一个已有英雄, 配额照样补满。
            Zombie_Spawn_Failures += 1
            if Zombie_Count_Before_Spawn > 0:
                createDummy(random.choice(getPlayers(Team.1)).getHero(), Team.1, -1, random.choice(Zombie_Spawn_Positions), Brain_Positions[0])
                waitUntil(getNumberOfPlayers(Team.1) > Zombie_Count_Before_Spawn, 1)
                if not Is_Attack_Phase:
                    getPlayers(Team.1).setStatusEffect(null, Status.INVINCIBLE, 999999986991104)
                if Debug_Enabled:
                    logToInspector("[生成] 复用已有英雄 {0} 队伍1 {1} 存活 {2}".format("成功" if getNumberOfPlayers(Team.1) > Zombie_Count_Before_Spawn else "失败", getNumberOfPlayers(Team.1), getNumberOfLivingPlayers(Team.1)))
            wait(AI_PRELOAD_INTERVAL)
        # 不能用 slice(1): 它编译成数量 999999999999 的数组分割, 引擎可能当成无效值返回空数组。
        Zombie_Wave_Heroes = Zombie_Wave_Heroes.slice(1, len(Zombie_Wave_Heroes))
    if Debug_Enabled:
        logToInspector("[生成] 循环结束 队伍1 {0} 配额 {1} 队列 {2} 进攻中 {3} 集结中 {4} 进攻剩余 {5}".format(getNumberOfPlayers(Team.1), zombieWaveQuotaNow(), len(Zombie_Wave_Heroes), Is_Attack_Phase, isAssemblingHeroes(), Wave_Attack_Time_Left))
