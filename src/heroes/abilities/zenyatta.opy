#!mainFile "../../main.opy"

def knockBack():
    @Name "[Zenyatta] Sub Knockback"

    wait()
    eventPlayer.applyImpulse(eventPlayer.knockback_direction, 22.5, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    eventPlayer.applyImpulse(Vector.UP, 22.5 * 0.3, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)


rule "[Zenyatta] Snap Kick (enemy)":
    @Event playerTookDamage
    @Team 1
    @Condition eventAbility == Button.MELEE
    @Condition attacker.getHero() == Hero.ZENYATTA == true

    eventPlayer.knockback_direction = directionFromAngles(attacker.getHorizontalFacingAngle(), -10)
    eventPlayer.startForcingThrottle(0, 0, 0, 0, 0, 0.5)
    knockBack()
    wait()
    eventPlayer.stopForcingThrottle()


rule "[Zenyatta]: Transcendence":
    @Event eachPlayer
    @Team 2
    @Hero zenyatta
    @Condition eventPlayer.isUsingUltimate() == true

    wait(0.16)
    ((getLivingPlayers(getOppositeTeam(eventPlayer.getTeam())).filter(lambda player: distance(eventPlayer, player) <= 10.5 and not player.zen_transcendence[0])).zen_transcendence)[0] = true
    ((getLivingPlayers(getOppositeTeam(eventPlayer.getTeam())).filter(lambda player: distance(eventPlayer, player) <= 10.5)).zen_transcendence)[1] = eventPlayer
    wait(6)


rule "[Zenyatta]: Transcendence dmg":
    @Event eachPlayer
    @Team 1
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.zen_transcendence[0] == true
    @Condition distance(eventPlayer, eventPlayer.zen_transcendence[1]) <= 10.5

    eventPlayer.setStatusEffect(eventPlayer.zen_transcendence[1], Status.BURNING, 6)
    eventPlayer.startDamageOverTime(eventPlayer.zen_transcendence[1], 6, ceil(eventPlayer.getMaxHealth() * 0.1))
    wait(6)
    eventPlayer.zen_transcendence[0] = false
