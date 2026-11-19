#!mainFile "../main.opy"

rule "Barrier - Eat Brain":
    @Event eachPlayer
    @Team 1
    @Condition Debug != true
    @Condition isGameInProgress() == true
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.isOnGround() == true
    @Condition (distance(eventPlayer, Brain_Points[0]) <= 1 or len(getLivingPlayers(Team.2)) == 0) == true

    if eventPlayer.isAlive() == false:
        return
    wait(0.3)
    declareTeamVictory(Team.1)


rule "Barrier - Win":
    @Condition Debug != true
    @Condition isGameInProgress() == true
    @Condition Under_Attack == true
    @Condition Current_Round == Config_Total_Round
    @Condition Round_Attack_Time == 0
    @Condition getNumberOfLivingPlayers(Team.1) == 0
    @Condition getNumberOfLivingPlayers(Team.2) > 0

    wait(1.5, Wait.ABORT_WHEN_FALSE)
    declareTeamVictory(Team.2)
