#!mainFile "../../main.opy"

rule "[Hazard]: Mov speed penalty":
    @Event playerDealtDamage
    @Team 2
    @Hero hazard
    @Condition eventAbility == Button.SECONDARY_FIRE
    @Condition victim.Is_Hazard_Slowed != true

    victim.Is_Hazard_Slowed = true
    wait(1)
    victim.Is_Hazard_Slowed = false


rule "[Hazard]: Mov speed penalty":
    @Event eachPlayer
    @Team 1
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.Is_Hazard_Slowed == true

    eventPlayer.startForcingThrottle(0, 0.5, 0, 0.5, 0, 0.5)
    waitUntil(not eventPlayer.Is_Hazard_Slowed, 1)
    eventPlayer.stopForcingThrottle()
    eventPlayer.Is_Hazard_Slowed = false
