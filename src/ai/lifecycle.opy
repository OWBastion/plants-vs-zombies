#!mainFile "../main.opy"

globalvar Zombie_Count_Before_Spawn

# 逐个生成以分散创建开销。
#!define AI_PRELOAD_INTERVAL 0.16

# 补齐窗口: 准备阶段(集结结束后)到进攻阶段前段。
#!define zombieSpawnWindow() (Wave_Attack_Time_Left > 10 if Is_Attack_Phase else not isAssemblingHeroes())
# 死亡的机器人仍占位，留给自动复活。
#!define zombieNeedsSpawn() (getNumberOfPlayers(Team.1) < zombieWaveQuotaNow() and len(Zombie_Wave_Heroes) > 0)

# 工坊拒绝加载新的英雄模型(实测队伍 1 有 3 种英雄后新英雄全部失败), 但场上已有的英雄总能再生成。
# 本波新英雄被拒两次后, 直接复制场上已有的英雄补满配额, 不再每只都白等 1 秒。
#!define zombieReuseHero() (Zombie_Spawn_Failures >= 2 and getNumberOfPlayers(Team.1) > 0)

# 常驻循环, 不靠规则条件的触发沿: 实测第 4 波备战时条件成立却没有重新启动, 整波一只都没生成。
rule "[ai]: Create AI Bot":
    @Condition isGameInProgress()

    while true:
        waitUntil(zombieNeedsSpawn() and zombieSpawnWindow(), 999999986991104)
        Zombie_Count_Before_Spawn = getNumberOfPlayers(Team.1)
        if Debug_Enabled:
            logToInspector("[生成] 尝试 {0} 英雄 {1} 队伍1 {2} 存活 {3} 配额 {4} 队列 {5} 本波被拒 {6} 波 {7} 进攻中 {8}".format("复用" if zombieReuseHero() else "新", Zombie_Wave_Heroes[0], Zombie_Count_Before_Spawn, getNumberOfLivingPlayers(Team.1), zombieWaveQuotaNow(), len(Zombie_Wave_Heroes), Zombie_Spawn_Failures, Current_Wave, Is_Attack_Phase))
        if zombieReuseHero():
            createDummy(random.choice(getPlayers(Team.1)).getHero(), Team.1, -1, random.choice(Zombie_Spawn_Positions), Brain_Positions[0])
        else:
            createDummy(Zombie_Wave_Heroes[0], Team.1, -1, random.choice(Zombie_Spawn_Positions), Brain_Positions[0])
            # 新英雄试过一次就出队: 被拒绝的不再重试。不能用 slice(1): 它编译成数量 999999999999 的数组分割。
            Zombie_Wave_Heroes = Zombie_Wave_Heroes.slice(1, len(Zombie_Wave_Heroes))
        # 实测机器人在同一秒内加入, 1 秒内没加入就是被拒绝。
        waitUntil(getNumberOfPlayers(Team.1) > Zombie_Count_Before_Spawn, 1)
        if Debug_Enabled:
            logToInspector("[生成] 结果 {0} 队伍1 {1} 存活 {2}".format("成功" if getNumberOfPlayers(Team.1) > Zombie_Count_Before_Spawn else "失败", getNumberOfPlayers(Team.1), getNumberOfLivingPlayers(Team.1)))
        if getNumberOfPlayers(Team.1) > Zombie_Count_Before_Spawn:
            if not Is_Attack_Phase:
                getPlayers(Team.1).setStatusEffect(null, Status.INVINCIBLE, 999999986991104)
        else:
            Zombie_Spawn_Failures += 1
        wait(AI_PRELOAD_INTERVAL)
