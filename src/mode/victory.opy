#!mainFile "../main.opy"

rule "Barrier - Eat Brain":
    @Event eachPlayer
    @Team 1
    @Condition not Debug_Enabled
    @Condition isGameInProgress()
    @Condition eventPlayer.isAlive()
    @Condition eventPlayer.isOnGround()
    @Condition distance(eventPlayer, Brain_Positions[0]) <= 1 or getNumberOfLivingPlayers(Team.2) == 0

    wait(0.3, Wait.ABORT_WHEN_FALSE)
    declareTeamVictory(Team.1)


rule "Barrier - Win":
    @Condition not Debug_Enabled
    @Condition isGameInProgress()
    @Condition Is_Attack_Phase
    @Condition Current_Wave == Total_Wave_Count
    @Condition Wave_Attack_Time_Left == 0
    @Condition getNumberOfLivingPlayers(Team.1) == 0
    @Condition getNumberOfLivingPlayers(Team.2) > 0

    wait(1.5, Wait.ABORT_WHEN_FALSE)
    declareTeamVictory(Team.2)
