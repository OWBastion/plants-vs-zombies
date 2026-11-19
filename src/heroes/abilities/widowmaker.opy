#!mainFile "../../main.opy"

rule "[widowmaker/init.opy]: Initialize Widowmaker ammo":
    @Event eachPlayer
    @Team 2
    @Hero widowmaker
    @Condition eventPlayer.getAmmo() > 5

    eventPlayer.setAmmo(0, 5)


rule "[widowmaker.opy]: Infra-Sight headshot":
    @Event playerDealtDamage
    @Team 2
    @Hero widowmaker
    @Condition eventWasCriticalHit == true
    @Condition eventPlayer.isFiringSecondaryFire() == true
    @Condition eventPlayer.isFiringPrimaryFire() == true
    @Condition eventAbility == Button.PRIMARY_FIRE
    @Condition eventDamage >= 200

    damage(victim, attacker, victim.getMaxHealth() * 0.5)
