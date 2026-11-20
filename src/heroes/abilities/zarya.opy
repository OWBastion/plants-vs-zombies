#!mainFile "../../main.opy"

rule "[Zarya]: Projected Barrier Target":
    @Event eachPlayer
    @Hero zarya
    @Condition eventPlayer.isUsingAbility2() == true

    sorted(getLivingPlayers(eventPlayer.getTeam()), lambda player: angleBetweenVectors(eventPlayer.getFacingDirection(), directionTowards(eventPlayer.getPosition(), player.getPosition()))).filter(lambda player: player.hasStatus(Status.INVINCIBLE))[0].Zarya_Barrier_Pending = true


rule "[Zarya]: Projected Barrier Shields":
    @Event eachPlayer
    @Condition eventPlayer.getHero() != Hero.ZARYA
    @Condition (eventPlayer.isAlive() and eventPlayer.Zarya_Barrier_Pending) == true

    eventPlayer.Zarya_Barrier_Pending = false
    if eventPlayer.Zarya_Barrier_Health_Pool == null:
        goto lbl_0
    removeHealthPool(eventPlayer.Zarya_Barrier_Health_Pool)
    lbl_0:
    eventPlayer.addHealthPool(Health.NORMAL, 50, false, false)
    eventPlayer.Zarya_Barrier_Health_Pool = getLastCreatedHealthPool()
    wait(6, Wait.RESTART_WHEN_TRUE)
    removeHealthPool(eventPlayer.Zarya_Barrier_Health_Pool)
    eventPlayer.Zarya_Barrier_Health_Pool = null
