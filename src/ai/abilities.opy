#!mainFile "../main.opy"

rule "[ai]: Base Melee":
    @Event eachPlayer
    @Team 1
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.isDummy() == true
    @Condition isGameInProgress() == true
    @Condition Is_Attack_Phase == true
    @Condition eventPlayer.Chase_Target_Player != null
    @Condition eventPlayer.Chase_Target_Player.isAlive() == true
    @Condition distance(eventPlayer, eventPlayer.Chase_Target_Player) <= 3.5
    @Condition eventPlayer.isUsingAbility1() != true
    @Condition eventPlayer.isUsingAbility2() != true
    @Condition eventPlayer.isUsingUltimate() != true

    wait(0.15, Wait.ABORT_WHEN_FALSE)
    eventPlayer.forceButtonPress(Button.MELEE)
    wait(0.5)
    if ruleCondition:
        loop()


rule "[ai]: Zarya Use Barrier":
    @Event eachPlayer
    @Team 1
    @Hero zarya
    @Condition eventPlayer.isDummy() == true
    @Condition eventPlayer.isAlive() == true
    @Condition Is_Attack_Phase == true
    @Condition eventPlayer.Chase_Target_Player != null
    @Condition eventPlayer.Chase_Target_Player.isAlive() == true
    @Condition distance(eventPlayer, eventPlayer.Chase_Target_Player) <= 10
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_1) == 0

    eventPlayer.forceButtonPress(Button.ABILITY_1)
    wait(1, Wait.ABORT_WHEN_FALSE)
    if ruleCondition:
        loop()


rule "[ai]: Orisa Use Fortify":
    @Event eachPlayer
    @Team 1
    @Hero orisa
    @Condition eventPlayer.isDummy() == true
    @Condition eventPlayer.isAlive() == true
    @Condition Is_Attack_Phase == true
    @Condition eventPlayer.Chase_Target_Player != null
    @Condition eventPlayer.Chase_Target_Player.isAlive() == true
    @Condition distance(eventPlayer, eventPlayer.Chase_Target_Player) <= 10
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_1) == 0

    eventPlayer.forceButtonPress(Button.ABILITY_1)
    wait(1, Wait.ABORT_WHEN_FALSE)
    if ruleCondition:
        loop()


rule "[ai]: Cassidy Use Roll":
    @Event eachPlayer
    @Team 1
    @Hero cassidy
    @Condition eventPlayer.isDummy() == true
    @Condition eventPlayer.isAlive() == true
    @Condition Is_Attack_Phase == true
    @Condition eventPlayer.Chase_Target_Player != null
    @Condition eventPlayer.Chase_Target_Player.isAlive() == true
    @Condition distance(eventPlayer, eventPlayer.Chase_Target_Player) > 4
    @Condition distance(eventPlayer, eventPlayer.Chase_Target_Player) <= 10
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_1) == 0

    eventPlayer.forceButtonPress(Button.ABILITY_1)
    wait(1, Wait.ABORT_WHEN_FALSE)
    if ruleCondition:
        loop()


rule "[ai]: Lucio Speed Song":
    @Event eachPlayer
    @Team 1
    @Hero lucio
    @Condition eventPlayer.isDummy() == true
    @Condition eventPlayer.isAlive() == true
    @Condition Is_Attack_Phase == true

    eventPlayer.forceButtonPress(Button.ABILITY_1)
    waitUntil(not eventPlayer.isAlive() or not Is_Attack_Phase, 999999986991104)


rule "[ai]: Lucio Amp":
    @Event eachPlayer
    @Team 1
    @Hero lucio
    @Condition eventPlayer.isDummy() == true
    @Condition eventPlayer.isAlive() == true
    @Condition Is_Attack_Phase == true
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_2) == 0
    @Condition len(getPlayersInRadius(eventPlayer, 12, Team.1, LosCheck.SURFACES).filter(lambda player: player.isAlive() and player != eventPlayer)) >= 2

    eventPlayer.forceButtonPress(Button.ABILITY_2)
    wait(1, Wait.ABORT_WHEN_FALSE)
    if ruleCondition:
        loop()


rule "[ai]: venture Use Ability 1":
    @Event eachPlayer
    @Team 1
    @Hero venture
    @Condition eventPlayer.isAlive() == true
    @Condition isGameInProgress() == true
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_1) == 0
    @Condition Is_Attack_Phase == true

    wait(0.1, Wait.ABORT_WHEN_FALSE)
    eventPlayer.forceButtonPress(Button.ABILITY_1)
    wait(3.6)
    eventPlayer.forceButtonPress(Button.JUMP)
    if ruleCondition:
        loop()


rule "[ai]: brig Use ult":
    @Event eachPlayer
    @Team 1
    @Hero brigitte
    @Condition eventPlayer.isAlive() == true
    @Condition isGameInProgress() == true
    @Condition eventPlayer.getUltCharge() == 100
    @Condition Is_Attack_Phase == true

    wait(0.1, Wait.ABORT_WHEN_FALSE)
    eventPlayer.forceButtonPress(Button.ULTIMATE)
    wait(15)
    if ruleCondition:
        loop()


rule "[ai]: ram Use Ability 1":
    @Event eachPlayer
    @Team 1
    @Hero ramattra
    @Condition eventPlayer.isAlive() == true
    @Condition isGameInProgress() == true
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_1) == 0
    @Condition eventPlayer.isUsingAbility1() != true
    @Condition Is_Attack_Phase == true

    wait(0.1, Wait.ABORT_WHEN_FALSE)
    eventPlayer.forceButtonPress(Button.ABILITY_1)
    eventPlayer.startForcingButton(Button.SECONDARY_FIRE)
    wait(4)
    eventPlayer.stopForcingButton(Button.SECONDARY_FIRE)
    if ruleCondition:
        loop()


rule "[ai]: Pharah Use Ability 1":
    @Event eachPlayer
    @Team 1
    @Hero pharah
    @Condition eventPlayer.isAlive() == true
    @Condition isGameInProgress() == true
    @Condition eventPlayer.isInAir() != true
    @Condition Is_Attack_Phase == true

    wait(0.1, Wait.ABORT_WHEN_FALSE)
    eventPlayer.forceButtonPress(Button.ABILITY_1)
    eventPlayer.startForcingButton(Button.JUMP)
    wait(4)
    eventPlayer.stopForcingButton(Button.JUMP)
    if ruleCondition:
        loop()
