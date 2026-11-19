#!mainFile "../../main.opy"

rule "[Illari]: Solar Rifle Alt Fire":
    @Event eachPlayer
    @Team 2
    @Hero illari
    @Condition eventPlayer.isFiringSecondaryFire() == true

    wait(0.12)
    damage(raycastHitPlayer(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 20, getPlayers(Team.1), eventPlayer, true), eventPlayer, 25)
    wait(0.12)
    if ruleCondition:
        loop()
