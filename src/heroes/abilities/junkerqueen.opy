#!mainFile "../../main.opy"

rule "[Junker Queen]: Commanding Shout":
    @Event eachPlayer
    @Team 2
    @Hero junkerQueen
    @Condition eventPlayer.isUsingAbility1() == true

    eventPlayer.setStatusEffect(null, Status.INVINCIBLE, 2)


rule "[Junker Queen]: Rampage":
    @Event eachPlayer
    @Team 2
    @Hero junkerQueen
    @Condition eventPlayer.isUsingUltimate() == true

    wait(0.496, Wait.ABORT_WHEN_FALSE)
    eventPlayer.setDamageDealt(1000)
    waitUntil(not eventPlayer.isUsingUltimate(), 0.864)
    eventPlayer.setDamageDealt(100)
    wait(10)
