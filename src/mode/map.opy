rule "Disable Scoring, Intro hud, Arena Locations, Spawn Loc, Spawn detect":
    @Condition isGameInProgress() == true
    @Condition Current_Round >= 2

    wait(5)
    setMatchTime(900)


rule "Disable Scoring, Intro hud, Arena Locations, Spawn Loc, Spawn detect":
    @Condition isGameInProgress() == true
    @Condition Under_Attack == true
    @Condition Current_Round == Config_Total_Round

    wait(1)
    setMatchTime(Config_Round_Attack_Time + Config_Round_Lead_Time)


rule "Disable Scoring, Intro hud, Arena Locations, Spawn Loc, Spawn detect":
    getPlayers(Team.1).disableRespawn()
    disableGamemodeCompletion()
    #Arena locations
    if __getCurrentMap__() == Map.AYUTTHAYA:
        Bot_Respawn_Points = [vect(16, 1, 25), vect(-6.5, 5, 25), vect(34.52, 6, 38.1), vect(16, 6, 23)]
        Brain_Points = [vect(16, 1.19, 52), vect(24, 1, 56), vect(-6, 3, 54)]
    elif __getCurrentMap__() == Map.LIJIANG_NIGHT_MARKET:
        Bot_Respawn_Points = [vect(32, 0, -21.75), vect(42.35, 6, -46), vect(30, 6, -14.18), vect(40, 2, -41.8)]
        Brain_Points = [vect(88.5, 4.5, -25.5)]
    elif __getCurrentMap__() == Map.LIJIANG_CONTROL_CENTER:
        Bot_Respawn_Points = [vect(31.21, 267, 312), vect(20, 270, 347.29), vect(24, 267, 327.17)]
        Brain_Points = [vect(67.71, 267.45, 349.43)]
    elif __getCurrentMap__() == Map.LIJIANG_CONTROL_CENTER:
        Bot_Respawn_Points = [vect(31.21, 267, 312), vect(20, 270, 347.29), vect(24, 267, 327.17)]
        Brain_Points = [vect(67.71, 267.45, 349.43)]
    elif __getCurrentMap__() == Map.ILIOS_LIGHTHOUSE:
        Bot_Respawn_Points = [vect(355, -24.66, 1.66), vect(324, -24.7, -0.04), vect(332.12, -20.74, 11.47), vect(336.38, -16.26, 8.63)]
        Brain_Points = [vect(320, -23.97, 46.25)]
    elif __getCurrentMap__() == Map.ILIOS_RUINS:
        Bot_Respawn_Points = [vect(-28.86, 58.37, -156.1), vect(-18.58, 59.39, -143.9), vect(-22.15, 58.37, -170.63), vect(-26.53, 67.62, -179.83)]
        Brain_Points = [vect(-80.12, 63.04, -160.04)]
    elif __getCurrentMap__() == Map.ILIOS_WELL:
        Bot_Respawn_Points = [vect(-185.28, 5.03, -42.68), vect(-186.79, 3.78, -56.12), vect(-163.67, 4.86, -38.01)]
        Brain_Points = [vect(-148.32, -3.41, -93.48)]
    elif __getCurrentMap__() == Map.NEPAL_VILLAGE:
        Bot_Respawn_Points = [vect(-169.79, -95.24, -33.05), vect(-199.72, -97.33, -54.5), vect(-163.22, -89.21, -28.77)]
        Brain_Points = [vect(-157.45, -97.52, -80.77)]
    elif __getCurrentMap__() == Map.NEPAL_SHRINE:
        Bot_Respawn_Points = [vect(-47.22, 19, -48.04), vect(-23.7, 22, -57.43), vect(-56.61, 15, -61.61)]
        Brain_Points = [vect(-43.18, 16.38, -88.26)]
    elif __getCurrentMap__() == Map.NEPAL_SANCTUM:
        Bot_Respawn_Points = [vect(81.12, 131.88, -34.95), vect(66.36, 127.8, -42.32), vect(106.84, 141.85, -52.18)]
        Brain_Points = [vect(81.03, 130.03, -84.94)]
    else:
    createEffect(getPlayers(Team.2), Effect.SPHERE, Color.YELLOW, Bot_Respawn_Points[0], 0.3, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createEffect(getPlayers(Team.2), Effect.SPHERE, Color.YELLOW, Bot_Respawn_Points[1], 0.3, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createEffect(getPlayers(Team.2), Effect.SPHERE, Color.YELLOW, Bot_Respawn_Points[2], 0.3, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createEffect(getPlayers(Team.2), Effect.SPHERE, Color.YELLOW, Bot_Respawn_Points[3], 0.3, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createEffect(getPlayers(Team.2), Effect.LIGHT_SHAFT, Color.WHITE, Brain_Points[0], 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)


rule "Player Resurrect - Respawn at Brain Points":
    @Event playerDied
    @Team 2
    @Condition isGameInProgress() == true
    #@Condition Under_Attack != true
    @Condition eventPlayer.isAlive() != true
    #@Condition (Current_Round == 4 or Current_Round == 6 or Current_Round == 8 or Current_Round == 10) == true

    #waitUntil(Current_Round == 4 or Current_Round == 6 or Current_Round == 8 or Current_Round == 10, 999999986991104)
    eventPlayer.teleport(Brain_Points[0])
    waitUntil(not Under_Attack and ((Current_Round == 4 or Current_Round == 6 or Current_Round == 8 or Current_Round == 10) == true), 999999986991104)
    eventPlayer.resurrect()
