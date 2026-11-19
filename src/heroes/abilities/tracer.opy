#!mainFile "../../main.opy"

rule "[Tracer]: Blink explosion target":
    @Event playerTookDamage
    @Team 1
    @Condition eventAbility == Button.ULTIMATE
    @Condition attacker.getHero() == Hero.TRACER == true
    @Condition eventDamage >= 70
    @Condition len(getPlayersInRadius(eventPlayer, 25, eventPlayer.getTeam(), LosCheck.SURFACES)) != 0

    damage(eventPlayer, eventPlayer.tracer_buff[1], ceil(eventPlayer.getMaxHealth() * 0.1))
    wait(0.5)
    getPlayersInRadius(eventPlayer, 25, eventPlayer.getTeam(), LosCheck.SURFACES).tracer_buff[0] = true
    getPlayersInRadius(eventPlayer, 25, eventPlayer.getTeam(), LosCheck.SURFACES).tracer_buff[1] = attacker


rule "[Tracer]: Blink explosion":
    @Event eachPlayer
    @Team 1
    @Condition eventPlayer.tracer_buff[0] == true
    @Condition eventPlayer.isAlive() == true

    playEffect(getAllPlayers(), DynamicEffect.DVA_SELF_DESTRUCT_EXPLOSION, Color.TEAM_1, eventPlayer, 200)
    playEffect(getAllPlayers(), DynamicEffect.DVA_SELF_DESTRUCT_EXPLOSION_SOUND, Color.WHITE, eventPlayer, 200)
    damage(eventPlayer, eventPlayer.tracer_buff[1], ceil(eventPlayer.getMaxHealth() * 0.08))
    wait(0.16)
    eventPlayer.tracer_buff[0] = false
    eventPlayer.tracer_buff[1] = null
