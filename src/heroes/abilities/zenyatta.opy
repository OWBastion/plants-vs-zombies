#!mainFile "../../main.opy"

def knockBack():
    @Name "[Zenyatta] Sub Knockback"

    wait()
    eventPlayer.applyImpulse(eventPlayer.Knockback_Direction, 22.5, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    eventPlayer.applyImpulse(Vector.UP, 22.5 * 0.3, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)


rule "[Zenyatta] Snap Kick (enemy)":
    @Event playerTookDamage
    @Team 1
    @Condition eventAbility == Button.MELEE
    @Condition attacker.getHero() == Hero.ZENYATTA == true

    eventPlayer.Knockback_Direction = directionFromAngles(attacker.getHorizontalFacingAngle(), -10)
    eventPlayer.startForcingThrottle(0, 0, 0, 0, 0, 0.5)
    knockBack()
    wait()
    eventPlayer.stopForcingThrottle()
