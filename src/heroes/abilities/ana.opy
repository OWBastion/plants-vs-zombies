#!mainFile "../../main.opy"

rule "[Ana] Biotic Grenade Hit":
    @Event playerTookDamage
    @Team 1
    @Condition eventAbility == Button.ABILITY_2
    @Condition attacker.getHero() == Hero.ANA == true

    eventPlayer.setStatusEffect(attacker, Status.BURNING, 3)
    eventPlayer.startDamageOverTime(attacker, 3, ceil(0.15 * victim.getMaxHealth()))
    wait(3)


rule "[ana/init.opy]: Initialize Ana ammo":
    @Event eachPlayer
    @Team 2
    @Hero ana
    @Condition eventPlayer.getAmmo() > 1

    eventPlayer.setMaxAmmo(0, 1)
    eventPlayer.setAmmo(0, 1)


rule "[ana]: 1 shot kill":
    @Event playerDealtDamage
    @Hero ana
    @Condition eventPlayer.isFiringSecondaryFire() == true
    @Condition eventPlayer.isFiringPrimaryFire() == true
    @Condition eventAbility == Button.PRIMARY_FIRE

    damage(victim, attacker, 44444)
    wait(0.8)
