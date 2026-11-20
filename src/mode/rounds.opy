#!mainFile "../main.opy"

rule "Players - Round Lead Time Start":
    @Condition (isAssemblingHeroes() or isGameInProgress()) == true
    @Condition Current_Wave < Total_Wave_Count
    @Condition Is_Attack_Phase == false

    waitUntil(not isAssemblingHeroes() and isGameInProgress(), 999999986991104)
    getPlayers(Team.1).setStatusEffect(null, Status.INVINCIBLE, 999999986991104)
    chaseOverTime(Wave_Prep_Time_Left, 0, Wave_Prep_Duration, ChaseTimeReeval.NONE)
    bigMessage(getAllPlayers(), "第 {0} 波即将开始".format(Current_Wave + 1))


rule "Players - Round Lead Time End":
    @Condition isGameInProgress() == true
    @Condition Current_Wave < Total_Wave_Count
    @Condition Is_Attack_Phase == false

    waitUntil(Wave_Prep_Time_Left == 0, Wave_Prep_Duration)
    destroyAllDummies()
    Current_Wave++
    Wave_Attack_Time_Left = Wave_Attack_Duration
    Wave_Prep_Time_Left = 0
    Is_Attack_Phase = true


rule "Players - Round Attack Start":
    @Condition isGameInProgress() == true
    @Condition Current_Wave <= Total_Wave_Count
    @Condition Is_Attack_Phase == true

    getPlayers(Team.1).clearStatusEffect(Status.INVINCIBLE)
    bigMessage(getAllPlayers(), "第 {0} 波进攻".format(Current_Wave))
    chaseOverTime(Wave_Attack_Time_Left, 0, Wave_Attack_Duration, ChaseTimeReeval.NONE)
    # 留出最长复活等待时间，让已死亡的僵尸在波次结束前停止复活。
    waitUntil(Wave_Attack_Time_Left <= 10, Wave_Attack_Duration)
    getPlayers(Team.1).disableRespawn()


rule "Players - Round Attack End":
    @Condition isGameInProgress() == true
    @Condition Current_Wave < Total_Wave_Count
    @Condition Is_Attack_Phase == true

    waitUntil(Wave_Attack_Time_Left == 0, Wave_Attack_Duration)
    waitUntil(getNumberOfLivingPlayers(Team.1) == 0, 999999986991104)
    # 先结算已持有四项科技的玩家, 再开放本波的新科技机会。
    getPlayers(Team.2).filter(lambda player: not player.isDummy() and len(player.Owned_Tech_Ids) == MAX_TECH_COUNT).Pending_Stat_Upgrade_Count += 1
    Finished_Wave_Count = Current_Wave
    Is_Attack_Phase = false
    Wave_Prep_Time_Left = Wave_Prep_Duration
