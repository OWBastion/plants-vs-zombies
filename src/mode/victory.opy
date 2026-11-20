#!mainFile "../main.opy"

rule "Barrier - Eat Brain":
    @Event eachPlayer
    @Team 1
    @Condition Debug_Enabled != true
    @Condition isGameInProgress() == true
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.isOnGround() == true
    @Condition (distance(eventPlayer, Brain_Positions[0]) <= 1 or len(getLivingPlayers(Team.2)) == 0) == true

    wait(0.3, Wait.ABORT_WHEN_FALSE)
    declareTeamVictory(Team.1)


rule "Barrier - Win":
    @Condition Debug_Enabled != true
    @Condition isGameInProgress() == true
    @Condition Is_Attack_Phase == true
    @Condition Current_Wave == Total_Wave_Count
    @Condition Wave_Attack_Time_Left == 0
    @Condition getNumberOfLivingPlayers(Team.1) == 0
    @Condition getNumberOfLivingPlayers(Team.2) > 0

    wait(1.5, Wait.ABORT_WHEN_FALSE)
    declareTeamVictory(Team.2)
