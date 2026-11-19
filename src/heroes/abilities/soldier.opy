#!mainFile "../../main.opy"

rule "[Soldier: 76]: Helix Rockets lose control":
    @Event playerDealtDamage
    @Team 2
    @Hero soldier
    #@Condition attacker.getHero() == Hero.SOLDIER
    @Condition eventAbility == Button.SECONDARY_FIRE
    @Condition attacker != victim

    victim.setStatusEffect(attacker, Status.BURNING, 2)
    victim.startDamageOverTime(attacker, 2, ceil(victim.getMaxHealth() * 0.1 / 2))
