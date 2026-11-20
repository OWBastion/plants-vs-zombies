#!mainFile "../../main.opy"

# 大招击杀 +25% 充能已合并为费斯卡科技"终极循环往复"(src/player/feska/tech/ultloop.opy)。


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
