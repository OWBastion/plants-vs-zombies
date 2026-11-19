#!mainFile "../../main.opy"

rule "[Reaper]: Death Blossom remove Mov. speed penalty":
    @Event eachPlayer
    @Hero reaper
    @Condition eventPlayer.isUsingUltimate() == true

    eventPlayer.setDamageDealt(200)
    eventPlayer.setMoveSpeed(200)
    waitUntil(not eventPlayer.isUsingUltimate(), 3.5)
    eventPlayer.setMoveSpeed(100)
    eventPlayer.setDamageDealt(100)
