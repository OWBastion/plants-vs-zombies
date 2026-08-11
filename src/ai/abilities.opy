rule "[ai]: Use Ability 1":
    @Event eachPlayer
    @Team 1
    @Condition eventPlayer.isAlive() == true
    @Condition isGameInProgress() == true
    @Condition eventPlayer.getHero() in [Hero.JUNO, Hero.ORISA, Hero.SOJOURN, Hero.HAZARD, Hero.DVA, Hero.MAUGA, Hero.JUNKER_QUEEN, Hero.WINSTON, Hero.REINHARDT, Hero.FREJA, Hero.CASSIDY, Hero.ECHO, Hero.REAPER] == true
    @Condition Under_Attack == true

    wait(0.1, Wait.ABORT_WHEN_FALSE)
    eventPlayer.forceButtonPress(Button.ABILITY_1)
    eventPlayer.forceButtonPress(Button.JUMP)
    wait(0.6)
    eventPlayer.startForcingButton(Button.JUMP)
    wait(1.6)
    eventPlayer.stopForcingButton(Button.JUMP)
    if ruleCondition:
        loop()


rule "[ai]: venture Use Ability 1":
    @Event eachPlayer
    @Team 1
    @Hero venture
    @Condition eventPlayer.isAlive() == true
    @Condition isGameInProgress() == true
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_1) == 0
    @Condition Under_Attack == true

    wait(0.1, Wait.ABORT_WHEN_FALSE)
    #AITarget()
    #AIMove()
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
    @Condition Under_Attack == true

    wait(0.1, Wait.ABORT_WHEN_FALSE)
    eventPlayer.forceButtonPress(Button.ULTIMATE)
    wait(15)
    if ruleCondition:
        loop()


rule "[ai]: 76 Use Ability 1":
    @Event eachPlayer
    @Team 1
    @Hero soldier
    @Condition eventPlayer.isAlive() == true
    @Condition isGameInProgress() == true
    @Condition eventPlayer.isUsingAbility1() != true
    @Condition eventPlayer.getUltCharge() == 100
    @Condition Under_Attack == true

    wait(0.1, Wait.ABORT_WHEN_FALSE)
    eventPlayer.forceButtonPress(Button.ABILITY_1)


rule "[ai]: ram Use Ability 1":
    @Event eachPlayer
    @Team 1
    @Hero ramattra
    @Condition eventPlayer.isAlive() == true
    @Condition isGameInProgress() == true
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_1) == 0
    @Condition eventPlayer.isUsingAbility1() != true
    @Condition Under_Attack == true

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
    @Condition Under_Attack == true

    wait(0.1, Wait.ABORT_WHEN_FALSE)
    eventPlayer.forceButtonPress(Button.ABILITY_1)
    eventPlayer.startForcingButton(Button.JUMP)
    wait(4)
    eventPlayer.stopForcingButton(Button.JUMP)
    if ruleCondition:
        loop()


rule "[ai]: Sombra Use Ability 2":
    @Event eachPlayer
    @Team 1
    @Hero sombra
    @Condition eventPlayer.isAlive() == true
    @Condition isGameInProgress() == true
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_2) == 0
    @Condition Under_Attack == true

    wait(0.1, Wait.ABORT_WHEN_FALSE)
    eventPlayer.forceButtonPress(Button.ABILITY_2)
    waitUntil(eventPlayer.getAbilityCooldown(Button.ABILITY_2) == 0, 30)
    wait(4)
    if ruleCondition:
        loop()
