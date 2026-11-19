#!mainFile "../../main.opy"

rule "[Kiriko]: headshot damage":
    @Event playerDealtDamage
    @Team 2
    @Hero kiriko
    @Condition eventWasCriticalHit == true
    @Condition eventAbility == Button.PRIMARY_FIRE

    damage(victim, attacker, ceil(eventDamage / 4))
