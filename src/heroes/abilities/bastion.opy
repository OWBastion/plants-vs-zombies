#!mainFile "../../main.opy"

rule "[Bastion]: stun":
    @Event playerDealtKnockback
    @Team 2
    @Hero bastion
    @Condition eventAbility == Button.PRIMARY_FIRE
    @Condition eventPlayer.hasStatus(Status.STUNNED) != true

    victim.setStatusEffect(attacker, Status.STUNNED, 0.5)
    wait(0.75)


rule "[Bastion]: stun":
    @Event playerDealtDamage
    @Team 2
    @Hero bastion
    @Condition eventAbility == Button.ULTIMATE
    @Condition eventPlayer.hasStatus(Status.KNOCKED_DOWN) != true

    victim.setStatusEffect(attacker, Status.KNOCKED_DOWN, 5)
    wait(0.16)
