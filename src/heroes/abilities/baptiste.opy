#!mainFile "../../main.opy"

rule "[Baptiste]: headshot damage":
    @Event playerDealtDamage
    @Team 2
    @Hero baptiste
    @Condition eventWasCriticalHit == true
    @Condition eventAbility == Button.PRIMARY_FIRE

    damage(victim, attacker, ceil(eventDamage / 4))
