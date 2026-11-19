#!mainFile "../../main.opy"

rule "[Echo]: kill to reset abilities":
    @Event playerEarnedElimination
    @Team 2
    @Hero echo
    @Condition eventAbility in [Button.SECONDARY_FIRE, Button.ABILITY_2] == true

    eventPlayer.setAbilityCooldown(eventAbility, 0)
