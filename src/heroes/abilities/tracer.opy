#!mainFile "../../main.opy"

rule "[Tracer]: Blink explosion target":
    @Event playerTookDamage
    @Team 1
    @Condition eventAbility == Button.ULTIMATE
    @Condition attacker.getHero() == Hero.TRACER == true
    @Condition eventDamage >= 70
    @Condition len(getPlayersInRadius(eventPlayer, 25, eventPlayer.getTeam(), LosCheck.SURFACES)) != 0

    damage(eventPlayer, eventPlayer.Blink_Owner, ceil(eventPlayer.getMaxHealth() * 0.1))
    wait(0.5)
    getPlayersInRadius(eventPlayer, 25, eventPlayer.getTeam(), LosCheck.SURFACES).Blink_Detonation_Pending = true
    getPlayersInRadius(eventPlayer, 25, eventPlayer.getTeam(), LosCheck.SURFACES).Blink_Owner = attacker


rule "[Tracer]: Blink explosion":
    @Event eachPlayer
    @Team 1
    @Condition eventPlayer.Blink_Detonation_Pending == true
    @Condition eventPlayer.isAlive() == true

    playEffect(getAllPlayers(), DynamicEffect.DVA_SELF_DESTRUCT_EXPLOSION, Color.TEAM_1, eventPlayer, 200)
    playEffect(getAllPlayers(), DynamicEffect.DVA_SELF_DESTRUCT_EXPLOSION_SOUND, Color.WHITE, eventPlayer, 200)
    damage(eventPlayer, eventPlayer.Blink_Owner, ceil(eventPlayer.getMaxHealth() * 0.08))
    wait(0.16)
    eventPlayer.Blink_Detonation_Pending = false
    eventPlayer.Blink_Owner = null
