#!mainFile "../main.opy"

rule "[ai]: Create AI Bot":
    @Condition isGameInProgress() == true
    @Condition Is_Attack_Phase == true
    @Condition Wave_Attack_Time_Left > 10
    @Condition getNumberOfPlayers(Team.1) < Zombie_Alive_Limit

    createDummy(Hero.BRIGITTE, Team.1, -1, Zombie_Spawn_Positions[0].getPosition(), Brain_Positions[0])
    while getNumberOfPlayers(Team.1) < Zombie_Alive_Limit:
        wait(0.16, Wait.ABORT_WHEN_FALSE)
        createDummy(Zombie_Hero_Pool.filter(lambda x: getNumberOfHeroes(x, Team.1) <= 3), Team.1, -1, random.choice(Zombie_Spawn_Positions), Brain_Positions[0])
    getPlayers(Team.1).setMoveSpeed(90)
