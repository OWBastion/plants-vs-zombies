def setThirdPerson():
    @Name "[utilities/Player]: Set Third Person"

    eventPlayer.startCamera(updateEveryFrame(raycastHitPosition(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + worldVector(vect(1 * (min(-2.5 / 2.5, -0.75)), 0, 0), eventPlayer, Transform.ROTATION) + updateEveryFrame(eventPlayer.getFacingDirection() * -2.5), getAllPlayers(), eventPlayer, false)), updateEveryFrame(raycastHitPosition(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 200, getAllPlayers(), eventPlayer, false)), 60)


rule "Set Third Person":
    @Event eachPlayer
    @Team 2
    @Disabled

    setThirdPerson()
