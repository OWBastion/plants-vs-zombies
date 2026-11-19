#!mainFile "../../main.opy"

rule "[Mauga]: Cardiac Overdrive Dmg. reduction":
    @Event eachPlayer
    @Team 2
    @Hero mauga
    @Condition eventPlayer.isUsingAbility2() == true

    eventPlayer.setStatusEffect(null, Status.INVINCIBLE, 5)
