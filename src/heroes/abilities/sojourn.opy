#!mainFile "../../main.opy"

rule "[Sojourn] Execution players less 10% HP expectancy":
    @Event playerDealtDamage
    @Hero sojourn
    @Condition (eventAbility == Button.SECONDARY_FIRE or eventAbility == Button.ULTIMATE) == true
    @Condition victim.getHealth() <= victim.getMaxHealth() * 0.2

    damage(victim, attacker, 44444)
    wait(0.2)
