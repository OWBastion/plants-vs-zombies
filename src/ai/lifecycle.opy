rule "[ai]: Create AI Bot":
    @Condition isGameInProgress() == true
    @Condition Under_Attack == true
    @Condition Round_Attack_Time != 0
    @Condition getNumberOfPlayers(Team.1) < NumberOfZombies

    createDummy(Hero.BRIGITTE, Team.1, -1, Bot_Respawn_Points[0].getPosition(), Brain_Points[0])
    while getNumberOfPlayers(Team.1) < NumberOfZombies:
        wait(0.16, Wait.ABORT_WHEN_FALSE)
        #createDummy(random.choice(Zombie_Heros.filter(lambda x: getNumberOfHeroes(x, Team.1) == 0)), Team.1, -1, Bot_Respawn_Points[0].getPosition())
        createDummy(Zombie_Heros.filter(lambda x: getNumberOfHeroes(x, Team.1) <= 3), Team.1, -1, random.choice(Bot_Respawn_Points), Brain_Points[0])
    getPlayers(Team.1).setMoveSpeed(90)


rule "[ai]: Remove AI Bot":
    @Event playerDied
    @Team 1
    @Condition isGameInProgress() == true
    @Condition Under_Attack == true
    @Condition Round_Attack_Time != 0
    @Condition eventPlayer.isDummy() == true

    wait(1 if Current_Round == Config_Total_Round else 2, Wait.ABORT_WHEN_FALSE)
    eventPlayer.teleport(random.choice(Bot_Respawn_Points))
    #eventPlayer.teleport(getSpawnPoints(Team.1))
    #destroyDummy(eventPlayer.getTeam(), eventPlayer.getSlot())
    #eventPlayer.setRespawnTime(9999)
    wait(3 if Current_Round == Config_Total_Round else 6, Wait.ABORT_WHEN_FALSE)
    #if Round_Attack_Time == 0:
    #        goto lbl_0
    eventPlayer.respawn()
    lbl_0:


rule "[Mode]: TP to point":
    @Event eachPlayer
    @Team 1
    @Condition Under_Attack == true
    @Condition distance(eventPlayer.getPosition(), getSpawnPoints(eventPlayer.getTeam()).getPosition()) <= 55
    @Condition Round_Attack_Time != 0
    @Condition eventPlayer.isDummy() == true

    eventPlayer.teleport(random.choice(Bot_Respawn_Points))
    #wait(5)
    #if ruleCondition:
    #        loop()
