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
    while zombieNeedsSpawn() and zombieSpawnWindow():
        Zombie_Count_Before_Spawn = getNumberOfPlayers(Team.1)
        createDummy(Zombie_Wave_Heroes[0], Team.1, -1, random.choice(Zombie_Spawn_Positions), Brain_Positions[0])
        # 机器人异步加入, 固定等 0.16 秒会把迟到的当成失败。等到人数增加, 最多 2 秒。
        waitUntil(getNumberOfPlayers(Team.1) > Zombie_Count_Before_Spawn, 2)
        if getNumberOfPlayers(Team.1) > Zombie_Count_Before_Spawn:
            if not Is_Attack_Phase:
                getPlayers(Team.1).setStatusEffect(null, Status.INVINCIBLE, 999999986991104)
            wait(AI_PRELOAD_INTERVAL)
        else:
            # 创建失败时把该英雄放回队尾，下一次尝试另一个英雄。
            Zombie_Wave_Heroes.append(Zombie_Wave_Heroes[0])
            wait(1)
        Zombie_Wave_Heroes = Zombie_Wave_Heroes.slice(1)
