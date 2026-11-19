#!mainFile "../../main.opy"

rule "[Doomfist] Seismic Slam upper":
    @Event playerTookDamage
    @Team 1
    @Condition attacker.getHero() == Hero.DOOMFIST
    @Condition eventAbility == Button.ABILITY_1
    @Condition (victim.getHero() == Hero.ORISA and (victim.isUsingAbility1() or victim.isUsingUltimate())) == false
    @Condition (victim.getHero() == Hero.MAUGA and victim.isUsingAbility1()) == false

    victim.applyImpulse(Vector.UP, 10, Relativity.TO_PLAYER)
    victim.applyImpulse(worldVector(Vector.FORWARD, attacker, Transform.ROTATION), 5, Relativity.TO_WORLD)
    victim.startForcingThrottle(0, 0, 0, 0, 0, 0)
    waitUntil(victim.isOnGround(), 1.2)
    victim.stopForcingThrottle()
    victim.setStatusEffect(attacker, Status.STUNNED, 2)
    wait(1)
