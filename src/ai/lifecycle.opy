#!mainFile "../main.opy"

globalvar Zombie_Count_Before_Spawn
globalvar Zombie_Wave_Quota

# 逐个生成以分散创建开销。
#!define AI_PRELOAD_INTERVAL 0.16

# 补齐窗口: 准备阶段(集结结束后)到进攻阶段前段。
#!define zombieSpawnWindow() (Wave_Attack_Time_Left > 10 if Is_Attack_Phase else not isAssemblingHeroes())
# 死亡的机器人仍占位，留给自动复活。
#!define zombieNeedsSpawn() (getNumberOfPlayers(Team.1) < zombieWaveQuotaNow())

# 每波备战开始(场上没有僵尸时)先逐个展开创建: 第 i 只用本波队列的第 i 个英雄, 槽位也手动指定为 i。
# 最多 16 只, 与设置「AI 上限」的最大值一致, 配额之外的跳过。
# 英雄被拒绝时那个槽位留空, 由后面的补位循环复制场上数量最少的英雄补满。
rule "[ai]: Create AI Bot":
    @Condition isGameInProgress()

    while true:
        waitUntil(not Is_Attack_Phase and not isAssemblingHeroes() and getNumberOfPlayers(Team.1) == 0, 999999986991104)
        wait(AI_PRELOAD_INTERVAL)
        Zombie_Wave_Quota = zombieWaveQuotaNow()
        if Debug_Enabled:
            logToInspector("[生成] 本波 第 {0} 波 配额 {1} 请求英雄 {2}".format(Current_Wave + 1, Zombie_Wave_Quota, Zombie_Wave_Heroes.slice(0, Zombie_Wave_Quota)))
        if Zombie_Wave_Quota > 0:
            createDummy(Zombie_Wave_Heroes[0], Team.1, 0, random.choice(Zombie_Spawn_Positions), Brain_Positions[0])
            wait(AI_PRELOAD_INTERVAL)
            if not Is_Attack_Phase:
                getPlayers(Team.1).setStatusEffect(null, Status.INVINCIBLE, 999999986991104)
        if Zombie_Wave_Quota > 1:
            createDummy(Zombie_Wave_Heroes[1], Team.1, 1, random.choice(Zombie_Spawn_Positions), Brain_Positions[0])
            wait(AI_PRELOAD_INTERVAL)
            if not Is_Attack_Phase:
                getPlayers(Team.1).setStatusEffect(null, Status.INVINCIBLE, 999999986991104)
        if Zombie_Wave_Quota > 2:
            createDummy(Zombie_Wave_Heroes[2], Team.1, 2, random.choice(Zombie_Spawn_Positions), Brain_Positions[0])
            wait(AI_PRELOAD_INTERVAL)
            if not Is_Attack_Phase:
                getPlayers(Team.1).setStatusEffect(null, Status.INVINCIBLE, 999999986991104)
        if Zombie_Wave_Quota > 3:
            createDummy(Zombie_Wave_Heroes[3], Team.1, 3, random.choice(Zombie_Spawn_Positions), Brain_Positions[0])
            wait(AI_PRELOAD_INTERVAL)
            if not Is_Attack_Phase:
                getPlayers(Team.1).setStatusEffect(null, Status.INVINCIBLE, 999999986991104)
        if Zombie_Wave_Quota > 4:
            createDummy(Zombie_Wave_Heroes[4], Team.1, 4, random.choice(Zombie_Spawn_Positions), Brain_Positions[0])
            wait(AI_PRELOAD_INTERVAL)
            if not Is_Attack_Phase:
                getPlayers(Team.1).setStatusEffect(null, Status.INVINCIBLE, 999999986991104)
        if Zombie_Wave_Quota > 5:
            createDummy(Zombie_Wave_Heroes[5], Team.1, 5, random.choice(Zombie_Spawn_Positions), Brain_Positions[0])
            wait(AI_PRELOAD_INTERVAL)
            if not Is_Attack_Phase:
                getPlayers(Team.1).setStatusEffect(null, Status.INVINCIBLE, 999999986991104)
        if Zombie_Wave_Quota > 6:
            createDummy(Zombie_Wave_Heroes[6], Team.1, 6, random.choice(Zombie_Spawn_Positions), Brain_Positions[0])
            wait(AI_PRELOAD_INTERVAL)
            if not Is_Attack_Phase:
                getPlayers(Team.1).setStatusEffect(null, Status.INVINCIBLE, 999999986991104)
        if Zombie_Wave_Quota > 7:
            createDummy(Zombie_Wave_Heroes[7], Team.1, 7, random.choice(Zombie_Spawn_Positions), Brain_Positions[0])
            wait(AI_PRELOAD_INTERVAL)
            if not Is_Attack_Phase:
                getPlayers(Team.1).setStatusEffect(null, Status.INVINCIBLE, 999999986991104)
        if Zombie_Wave_Quota > 8:
            createDummy(Zombie_Wave_Heroes[8], Team.1, 8, random.choice(Zombie_Spawn_Positions), Brain_Positions[0])
            wait(AI_PRELOAD_INTERVAL)
            if not Is_Attack_Phase:
                getPlayers(Team.1).setStatusEffect(null, Status.INVINCIBLE, 999999986991104)
        if Zombie_Wave_Quota > 9:
            createDummy(Zombie_Wave_Heroes[9], Team.1, 9, random.choice(Zombie_Spawn_Positions), Brain_Positions[0])
            wait(AI_PRELOAD_INTERVAL)
            if not Is_Attack_Phase:
                getPlayers(Team.1).setStatusEffect(null, Status.INVINCIBLE, 999999986991104)
        if Zombie_Wave_Quota > 10:
            createDummy(Zombie_Wave_Heroes[10], Team.1, 10, random.choice(Zombie_Spawn_Positions), Brain_Positions[0])
            wait(AI_PRELOAD_INTERVAL)
            if not Is_Attack_Phase:
                getPlayers(Team.1).setStatusEffect(null, Status.INVINCIBLE, 999999986991104)
        if Zombie_Wave_Quota > 11:
            createDummy(Zombie_Wave_Heroes[11], Team.1, 11, random.choice(Zombie_Spawn_Positions), Brain_Positions[0])
            wait(AI_PRELOAD_INTERVAL)
            if not Is_Attack_Phase:
                getPlayers(Team.1).setStatusEffect(null, Status.INVINCIBLE, 999999986991104)
        if Zombie_Wave_Quota > 12:
            createDummy(Zombie_Wave_Heroes[12], Team.1, 12, random.choice(Zombie_Spawn_Positions), Brain_Positions[0])
            wait(AI_PRELOAD_INTERVAL)
            if not Is_Attack_Phase:
                getPlayers(Team.1).setStatusEffect(null, Status.INVINCIBLE, 999999986991104)
        if Zombie_Wave_Quota > 13:
            createDummy(Zombie_Wave_Heroes[13], Team.1, 13, random.choice(Zombie_Spawn_Positions), Brain_Positions[0])
            wait(AI_PRELOAD_INTERVAL)
            if not Is_Attack_Phase:
                getPlayers(Team.1).setStatusEffect(null, Status.INVINCIBLE, 999999986991104)
        if Zombie_Wave_Quota > 14:
            createDummy(Zombie_Wave_Heroes[14], Team.1, 14, random.choice(Zombie_Spawn_Positions), Brain_Positions[0])
            wait(AI_PRELOAD_INTERVAL)
            if not Is_Attack_Phase:
                getPlayers(Team.1).setStatusEffect(null, Status.INVINCIBLE, 999999986991104)
        if Zombie_Wave_Quota > 15:
            createDummy(Zombie_Wave_Heroes[15], Team.1, 15, random.choice(Zombie_Spawn_Positions), Brain_Positions[0])
            wait(AI_PRELOAD_INTERVAL)
            if not Is_Attack_Phase:
                getPlayers(Team.1).setStatusEffect(null, Status.INVINCIBLE, 999999986991104)
        if Debug_Enabled:
            logToInspector("[生成] 展开创建完成 队伍1 {0} 存活 {1} 配额 {2} 在场英雄 {3}".format(getNumberOfPlayers(Team.1), getNumberOfLivingPlayers(Team.1), Zombie_Wave_Quota, getPlayers(Team.1).map(lambda player: player.getHero())))
        # 补位: 被拒绝的槽位复制场上数量最少的英雄。备战阶段和进攻前段都补。
        while zombieNeedsSpawn() and zombieSpawnWindow():
            Zombie_Count_Before_Spawn = getNumberOfPlayers(Team.1)
            if Zombie_Count_Before_Spawn == 0:
                # 一只都没成功时没有可复制的, 等 1 秒从头再来。
                break
            createDummy(sorted(getPlayers(Team.1), lambda player: getNumberOfHeroes(player.getHero(), Team.1))[0].getHero(), Team.1, -1, random.choice(Zombie_Spawn_Positions), Brain_Positions[0])
            waitUntil(getNumberOfPlayers(Team.1) > Zombie_Count_Before_Spawn, 1)
            if Debug_Enabled:
                logToInspector("[生成] 补位 {0} 队伍1 {1} 存活 {2}".format("成功" if getNumberOfPlayers(Team.1) > Zombie_Count_Before_Spawn else "失败", getNumberOfPlayers(Team.1), getNumberOfLivingPlayers(Team.1)))
            if not Is_Attack_Phase:
                getPlayers(Team.1).setStatusEffect(null, Status.INVINCIBLE, 999999986991104)
            wait(AI_PRELOAD_INTERVAL)
        # 本波处理完后等下一波销毁僵尸; 若一只都没生成, 间隔 1 秒再试。
        wait(1)
