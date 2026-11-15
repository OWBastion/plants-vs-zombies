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
