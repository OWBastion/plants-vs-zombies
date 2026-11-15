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


# 团队死斗自动复活僵尸, 复活点随机: 复活即传送到僵尸刷新点
rule "[ai]: Respawn Teleport":
    @Event eachPlayer
    @Team 1
    @Condition isGameInProgress() == true
    @Condition eventPlayer.isDummy() == true
    @Condition eventPlayer.isAlive() == true

    eventPlayer.teleport(random.choice(Bot_Respawn_Points))
    # 实测请求值比实际复活等待多约 2 秒: 10 -> 约 8 秒, 6 -> 约 4 秒
    eventPlayer.setRespawnTime(6 if Current_Round == Config_Total_Round else 10)
