rule "Players - Round Lead Time Start":
    @Condition (isAssemblingHeroes() or isGameInProgress()) == true
    #@Condition isGameInProgress() == true
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
    Under_Attack = true
    Current_Round++
    Round_Attack_Time = Config_Round_Attack_Time
    Round_Lead_Time = 0


rule "Players - Round Attack Start":
    @Condition isGameInProgress() == true
    @Condition Current_Round < Config_Total_Round
    @Condition Under_Attack == true

    getPlayers(Team.1).clearStatusEffect(Status.INVINCIBLE)
    bigMessage(getAllPlayers(), "第 {0} 波进攻".format(Current_Round))
    chaseOverTime(Round_Attack_Time, 0, Config_Round_Attack_Time, ChaseTimeReeval.NONE)


rule "Players - Round Attack End":
    @Condition isGameInProgress() == true
    @Condition Current_Round < Config_Total_Round
    @Condition Under_Attack == true

    waitUntil(Round_Attack_Time == 0, Config_Round_Attack_Time)
    waitUntil(getNumberOfLivingPlayers(Team.1) == (len(getLivingPlayers(Team.1).filter(lambda player: distance(player.getPosition(), getSpawnPoints(Team.1).getPosition()) <= 55))) or len(getLivingPlayers(Team.1).filter(lambda player: distance(player.getPosition(), Brain_Points[0].getPosition()) >= 45)), 999999986991104)
    Under_Attack = false
    Round_Lead_Time = Config_Round_Lead_Time
