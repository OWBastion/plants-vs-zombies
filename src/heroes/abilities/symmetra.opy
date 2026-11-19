#!mainFile "../../main.opy"

rule "[Symmetra]: Barrier Shields":
    @Event eachPlayer
    @Team 2
    @Hero symmetra
    @Condition eventPlayer.isUsingUltimate() == true

    ((getLivingPlayers(eventPlayer.getTeam()).filter(lambda player: isInLoS(eventPlayer, player) == true)).sym_barrier_shields)[0] = true
    waitUntil(not eventPlayer.isUsingUltimate(), 12.5)
    getPlayers(eventPlayer.getTeam()).sym_barrier_shields[0] = false


rule "[Symmetra]: Barrier Shields":
    @Event eachPlayer
    @Team 2
    @Condition eventPlayer.sym_barrier_shields[0] == true

    if eventPlayer.sym_barrier_shields[1] == null:
        goto lbl_0
    removeHealthPool(eventPlayer.sym_barrier_shields[1])
    lbl_0:
    eventPlayer.addHealthPool(Health.SHIELDS, 1000, true, false)
    eventPlayer.sym_barrier_shields[1] = getLastCreatedHealthPool()
    waitUntil(not eventPlayer.sym_barrier_shields[0], 12.5)
    removeHealthPool(eventPlayer.sym_barrier_shields[1])
    eventPlayer.sym_barrier_shields[1] = null
