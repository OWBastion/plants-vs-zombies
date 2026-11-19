#!mainFile "../../main.opy"

rule "[Orisa]: Fortify":
    @Event eachPlayer
    @Team 2
    @Hero orisa
    @Condition eventPlayer.isUsingAbility1() == true

    (getLivingPlayers(eventPlayer.getTeam()).filter(lambda player: isInLoS(eventPlayer, player) == true)).setDamageReceived(50)
    waitUntil(not eventPlayer.isUsingAbility1(), 4.1)
    getPlayers(eventPlayer.getTeam()).setDamageReceived(100)


rule "[Orisa]: ult":
    @Event eachPlayer
    @Team 2
    @Hero orisa
    @Condition eventPlayer.isUsingUltimate() == true

    getLivingPlayers(eventPlayer.getTeam()).setStatusEffect(eventPlayer, Status.INVINCIBLE, 4)
    waitUntil(not eventPlayer.isUsingUltimate(), 4.1)
    getPlayers(eventPlayer.getTeam()).clearStatusEffect(Status.INVINCIBLE)
