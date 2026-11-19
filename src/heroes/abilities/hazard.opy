#!mainFile "../../main.opy"

rule "[Hazard]: Mov speed penalty":
    @Event playerDealtDamage
    @Team 2
    @Hero hazard
    @Condition eventAbility == Button.SECONDARY_FIRE
    @Condition victim.mov_speed_penalty != true

    victim.mov_speed_penalty = true
    wait(1)
    victim.mov_speed_penalty = false


rule "[Hazard]: Mov speed penalty":
    @Event eachPlayer
    @Team 1
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.mov_speed_penalty == true

    eventPlayer.startForcingThrottle(0, 0.5, 0, 0.5, 0, 0.5)
    waitUntil(not eventPlayer.mov_speed_penalty, 1)
    eventPlayer.stopForcingThrottle()
    eventPlayer.mov_speed_penalty = false
