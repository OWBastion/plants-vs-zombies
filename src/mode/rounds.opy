#!mainFile "../main.opy"

rule "Players - Round Lead Time Start":
    @Condition (isAssemblingHeroes() or isGameInProgress()) == true
    @Condition Current_Wave < Total_Wave_Count
    @Condition Is_Attack_Phase == false

    waitUntil(not isAssemblingHeroes() and isGameInProgress(), 999999986991104)
    # 上一波残留的 dummy 与「禁止复活」状态都要清掉, 否则新一波的僵尸死一次就再也不回来。
    getPlayers(Team.1).enableRespawn()
    destroyAllDummies()
    Zombie_Spawn_Count = 0
    chaseOverTime(Wave_Prep_Time_Left, 0, Wave_Prep_Duration, ChaseTimeReeval.NONE)
    bigMessage(getAllPlayers(), "第 {0} 波即将开始  {1}  {2} 只".format(Current_Wave + 1, DIFFICULTY_NAME(), zombieWaveQuotaNow()))


rule "Players - Round Lead Time End":
    @Condition isGameInProgress() == true
    @Condition Current_Wave < Total_Wave_Count
    @Condition Is_Attack_Phase == false

    waitUntil(Wave_Prep_Time_Left == 0, Wave_Prep_Duration)
    # 准备时间到点后仍然等本波配额发完再开波(16 只按 0.16 秒间隔约 2.6 秒)。
    # 最多多等 6 秒: 生成被挡住时不能把准备阶段永久卡住。
    waitUntil(Zombie_Spawn_Count >= zombieWaveQuotaNow(), 6)
    Current_Wave++
    Wave_Attack_Time_Left = Wave_Attack_Duration
    Wave_Prep_Time_Left = 0
    Is_Attack_Phase = true


rule "Players - Round Attack Start":
    @Condition isGameInProgress() == true
    @Condition Current_Wave <= Total_Wave_Count
    @Condition Is_Attack_Phase == true

    getPlayers(Team.1).enableRespawn()
    getPlayers(Team.1).clearStatusEffect(Status.INVINCIBLE)
    bigMessage(getAllPlayers(), "第 {0} 波进攻".format(Current_Wave))
    chaseOverTime(Wave_Attack_Time_Left, 0, Wave_Attack_Duration, ChaseTimeReeval.NONE)


rule "Players - Round Attack End":
    @Condition isGameInProgress() == true
    @Condition Current_Wave < Total_Wave_Count
    @Condition Is_Attack_Phase == true

    waitUntil(Wave_Attack_Time_Left == 0, Wave_Attack_Duration)
    # 铃响后停止补位: 额度没放完也不再放, 把残余僵尸交给玩家清场收尾。
    getPlayers(Team.1).disableRespawn()
    # 安全阀: 清不掉(卡住/无敌残留)也必须能进下一波, 否则整局卡死在这一波。
    waitUntil(getNumberOfLivingPlayers(Team.1) == 0, 30)
    destroyAllDummies()
    # 先结算已持有四项科技的玩家, 再开放本波的新科技机会。
    getPlayers(Team.2).filter(lambda player: not player.isDummy() and len(player.Owned_Tech_Ids) == MAX_TECH_COUNT).Pending_Stat_Upgrade_Count += 1
    Finished_Wave_Count = Current_Wave
    Is_Attack_Phase = false
    Wave_Prep_Time_Left = Wave_Prep_Duration


# 最后一波没有「进攻结束」规则, 铃响后必须在这里停掉补位:
# 额度没放完的僵尸会一直按 3~5 秒复活, Barrier - Win 的「存活数量 == 0」就永远不成立。
rule "Players - Final Wave Stop Respawn":
    @Condition isGameInProgress() == true
    @Condition Is_Attack_Phase == true
    @Condition Current_Wave == Total_Wave_Count
    @Condition Wave_Attack_Time_Left == 0
    @Condition getNumberOfLivingPlayers(Team.1) > 0

    getPlayers(Team.1).disableRespawn()
