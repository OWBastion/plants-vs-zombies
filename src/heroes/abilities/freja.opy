#!mainFile "../../main.opy"

rule "[Freja]: Ammo":
    @Event playerEarnedElimination
    @Team 2
    @Hero freja

    eventPlayer.setMaxAmmo(0, eventPlayer.getMaxAmmo() + 1)


rule "[Freja]: Take Aim Damage":
    @Event playerDealtKnockback
    @Team 2
    @Hero freja
    @Condition eventAbility == Button.SECONDARY_FIRE
    @Condition victim.hasStatus(Status.INVINCIBLE) != true

    wait(0.5, Wait.ABORT_WHEN_FALSE)
    playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, Color.BLUE, victim, 0.8)
    playEffect(getAllPlayers(), DynamicEffect.EXPLOSION_SOUND, Color.BLUE, victim, 10)
    damage(victim, attacker, victim.getMaxHealth() * 0.25)


rule "[Freja]: Ex":
    @Event playerDealtKnockback
    @Team 2
    @Hero freja
    @Condition eventAbility == null
    @Condition victim.hasStatus(Status.INVINCIBLE) != true

    if not victim.isAlive() or victim.getHealth() > victim.getMaxHealth() * 0.3:
        goto lbl_0
    damage(victim, attacker, 44444)
    smallMessage(eventPlayer, "  斩杀： {0} ".format(heroIcon(victim.getHero())))
    wait(1, Wait.ABORT_WHEN_FALSE)
    lbl_0:
