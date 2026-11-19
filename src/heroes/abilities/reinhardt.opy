#!mainFile "../../main.opy"

rule "[Reinhardt]: Rocket Hammer stun":
    @Event playerDealtDamage
    @Team 2
    @Hero reinhardt
    @Condition eventAbility == Button.PRIMARY_FIRE

    victim.setStatusEffect(attacker, Status.STUNNED, 0.5)
    wait(0.496)


rule "[Reinhardt]: Earthshatter":
    @Event playerDealtFinalBlow
    @Team 2
    @Hero reinhardt
    @Condition eventAbility == Button.ULTIMATE

    eventPlayer.setUltCharge(100)
    wait(0.5)
