#!mainFile "../../main.opy"

rule "[Lucio]: Crossfade dmg":
    @Event eachPlayer
    @Team 2
    @Hero lucio
    @Condition eventPlayer.isAlive() == true
    @Condition (len(getLivingPlayers(getOppositeTeam(eventPlayer.getTeam())).filter(lambda player: distance(eventPlayer, player) <= 12.5 and not player.lucio_crossfade_dmg[0]))) > 0

    ((getLivingPlayers(getOppositeTeam(eventPlayer.getTeam())).filter(lambda player: distance(eventPlayer, player) <= 12.5 and not player.lucio_crossfade_dmg[0])).lucio_crossfade_dmg)[0] = true
    ((getLivingPlayers(getOppositeTeam(eventPlayer.getTeam())).filter(lambda player: distance(eventPlayer, player) <= 12.5)).lucio_crossfade_dmg)[1] = eventPlayer
    wait(1)
    if ruleCondition:
        loop()


rule "[Lucio]: Crossfade dmg":
    @Event eachPlayer
    @Team 1
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.lucio_crossfade_dmg[0] == true
    @Condition distance(eventPlayer, eventPlayer.lucio_crossfade_dmg[1]) <= 12.5

    eventPlayer.setStatusEffect(eventPlayer.lucio_crossfade_dmg[1], Status.BURNING, 1)
    eventPlayer.startDamageOverTime(eventPlayer.lucio_crossfade_dmg[1], 1, ceil(eventPlayer.getMaxHealth() * 0.1))
    wait(1)
    eventPlayer.lucio_crossfade_dmg[0] = false
