#!mainFile "../../main.opy"

rule "[Winston]: stun":
    @Event playerDealtDamage
    @Team 2
    @Hero winston
    @Condition eventAbility == Button.SECONDARY_FIRE
    @Condition eventPlayer.hasStatus(Status.STUNNED) != true

    victim.setStatusEffect(attacker, Status.STUNNED, 0.75)
    wait(0.75)
