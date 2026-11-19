#!mainFile "../main.opy"

rule "Players - Round Lead Time Start":
    @Condition (isAssemblingHeroes() or isGameInProgress()) == true
    @Condition Current_Round < Config_Total_Round
    @Condition Under_Attack == false

    waitUntil(not isAssemblingHeroes() and isGameInProgress(), 999999986991104)
    getPlayers(Team.1).setStatusEffect(null, Status.INVINCIBLE, 999999986991104)
    chaseOverTime(Round_Lead_Time, 0, Config_Round_Lead_Time, ChaseTimeReeval.NONE)
    bigMessage(getAllPlayers(), "第 {0} 波即将开始".format(Current_Round + 1))


rule "Players - Round Lead Time End":
    @Condition isGameInProgress() == true
    @Condition Current_Round < Config_Total_Round
    @Condition Under_Attack == false

    waitUntil(Round_Lead_Time == 0, Config_Round_Lead_Time)
    destroyAllDummies()
    Current_Round++
    Round_Attack_Time = Config_Round_Attack_Time
    Round_Lead_Time = 0
    Under_Attack = true


rule "Players - Round Attack Start":
    @Condition isGameInProgress() == true
    @Condition Current_Round <= Config_Total_Round
    @Condition Under_Attack == true

    getPlayers(Team.1).clearStatusEffect(Status.INVINCIBLE)
    bigMessage(getAllPlayers(), "第 {0} 波进攻".format(Current_Round))
    chaseOverTime(Round_Attack_Time, 0, Config_Round_Attack_Time, ChaseTimeReeval.NONE)
    # 留出最长复活等待时间，让已死亡的僵尸在波次结束前停止复活。
    waitUntil(Round_Attack_Time <= 10, Config_Round_Attack_Time)
    getPlayers(Team.1).disableRespawn()


rule "Players - Round Attack End":
    @Condition isGameInProgress() == true
    @Condition Current_Round < Config_Total_Round
    @Condition Under_Attack == true

    waitUntil(Round_Attack_Time == 0, Config_Round_Attack_Time)
    waitUntil(getNumberOfLivingPlayers(Team.1) == 0, 999999986991104)
    # 先结算已持有四项科技的玩家, 再开放本波的新科技机会。
    getPlayers(Team.2).filter(lambda player: not player.isDummy() and len(player.feska_tech) == FESKA_MAX_TECH).feska_forge_pending += 1
    Completed_Attacks = Current_Round
    Under_Attack = false
    Round_Lead_Time = Config_Round_Lead_Time
