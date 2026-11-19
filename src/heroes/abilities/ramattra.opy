#!mainFile "../../main.opy"

rule "[Ramattra]: Pain endures":
    @Event playerDealtFinalBlow
    @Team 2
    @Hero ramattra
    @Condition eventPlayer.isUsingUltimate() == true
    @Condition eventAbility == Button.ULTIMATE

    eventPlayer.setUltCharge(eventPlayer.getUltCharge() + 25)
    wait(0.3)


rule "[Ramattra]: Nemesis Form":
    @Event playerTookDamage
    @Team 1
    @Condition attacker.getHero() == Hero.RAMATTRA == true
    @Condition eventAbility == Button.ABILITY_1

    playEffect(getAllPlayers(), DynamicEffect.SIGMA_HYPERSPHERE_IMPLOSION, Color.WHITE, eventPlayer, 200)
    victim.applyImpulse(worldVector(Vector.FORWARD, attacker, Transform.ROTATION), 25, Relativity.TO_WORLD)
    wait(0.248)


rule "[Ramattra]: Annihilation":
    @Event playerTookDamage
    @Team 1
    @Condition attacker.getHero() == Hero.RAMATTRA == true
    @Condition eventAbility == Button.ULTIMATE

    playEffect(getAllPlayers(), DynamicEffect.SIGMA_HYPERSPHERE_IMPLOSION, Color.WHITE, eventPlayer, 200)
    victim.applyImpulse(Vector.UP, 1, Relativity.TO_PLAYER)
    victim.applyImpulse(worldVector(Vector.BACKWARD, attacker, Transform.ROTATION), 3, Relativity.TO_WORLD)
    wait(1.5)
