#!mainFile "../main.opy"

rule "[ai]: Base Melee":
    @Event eachPlayer
    @Team 1
    @Condition eventPlayer.isAlive()
    @Condition eventPlayer.isDummy()
    @Condition isGameInProgress()
    @Condition Is_Attack_Phase
    @Condition eventPlayer.Chase_Target_Player != null
    @Condition eventPlayer.Chase_Target_Player.isAlive()
    @Condition not eventPlayer.isUsingAbility1()
    @Condition not eventPlayer.isUsingAbility2()
    @Condition not eventPlayer.isUsingUltimate()
    @Condition eventPlayer.getHero() != Hero.REINHARDT or not eventPlayer.isHoldingButton(Button.SECONDARY_FIRE)
    @Condition distance(eventPlayer, eventPlayer.Chase_Target_Player) <= 3.5

    wait(0.15, Wait.ABORT_WHEN_FALSE)
    eventPlayer.forceButtonPress(Button.MELEE)
    wait(0.5)
    if ruleCondition:
        loop()


rule "[ai]: Use Hero Abilities":
    @Event eachPlayer
    @Team 1
    @Condition eventPlayer.isDummy()
    @Condition eventPlayer.isAlive()
    @Condition Is_Attack_Phase
    @Condition eventPlayer.getHero() in [Hero.DVA, Hero.MAUGA, Hero.WINSTON, Hero.REINHARDT, Hero.HAZARD, Hero.ECHO, Hero.BASTION, Hero.SOLDIER, Hero.FREJA, Hero.REAPER, Hero.GENJI, Hero.TRACER, Hero.SOJOURN, Hero.ILLARI, Hero.BAPTISTE, Hero.JUNO, Hero.SIGMA]

    if not eventPlayer.isUsingAbility1() and not eventPlayer.isUsingAbility2() and not eventPlayer.isUsingUltimate():
        if eventPlayer.getHero() != Hero.SIGMA and eventPlayer.getAbilityCooldown(Button.ABILITY_1) == 0:
            if eventPlayer.getHero() == Hero.SOLDIER:
                eventPlayer.startForcingButton(Button.ABILITY_1)
                waitUntil(not eventPlayer.isAlive() or not Is_Attack_Phase, 4)
                eventPlayer.stopForcingButton(Button.ABILITY_1)
            else:
                eventPlayer.forceButtonPress(Button.ABILITY_1)
        elif eventPlayer.getHero() in [Hero.ILLARI, Hero.BAPTISTE, Hero.JUNO, Hero.MAUGA] and eventPlayer.getAbilityCooldown(Button.ABILITY_2) == 0:
            eventPlayer.forceButtonPress(Button.ABILITY_2)
        elif eventPlayer.getHero() in [Hero.SIGMA, Hero.REINHARDT] and eventPlayer.getAbilityCooldown(Button.SECONDARY_FIRE) == 0:
            eventPlayer.startForcingButton(Button.SECONDARY_FIRE)
            waitUntil(not eventPlayer.isAlive() or not Is_Attack_Phase, 4)
            eventPlayer.stopForcingButton(Button.SECONDARY_FIRE)
    wait(1, Wait.ABORT_WHEN_FALSE)
    if ruleCondition:
        loop()


rule "[ai]: Zarya Use Barrier":
    @Event eachPlayer
    @Team 1
    @Hero zarya
    @Condition eventPlayer.isDummy()
    @Condition eventPlayer.isAlive()
    @Condition Is_Attack_Phase
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_1) == 0

    eventPlayer.forceButtonPress(Button.ABILITY_1)
    wait(1, Wait.ABORT_WHEN_FALSE)
    if ruleCondition:
        loop()


rule "[ai]: Orisa Use Fortify":
    @Event eachPlayer
    @Team 1
    @Hero orisa
    @Condition eventPlayer.isDummy()
    @Condition eventPlayer.isAlive()
    @Condition Is_Attack_Phase
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_1) == 0

    eventPlayer.forceButtonPress(Button.ABILITY_1)
    wait(1, Wait.ABORT_WHEN_FALSE)
    if ruleCondition:
        loop()


rule "[ai]: Cassidy Use Roll":
    @Event eachPlayer
    @Team 1
    @Hero cassidy
    @Condition eventPlayer.isDummy()
    @Condition eventPlayer.isAlive()
    @Condition Is_Attack_Phase
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_1) == 0

    eventPlayer.forceButtonPress(Button.ABILITY_1)
    wait(1, Wait.ABORT_WHEN_FALSE)
    if ruleCondition:
        loop()


rule "[ai]: Lucio Speed Song":
    @Event eachPlayer
    @Team 1
    @Hero lucio
    @Condition eventPlayer.isDummy()
    @Condition eventPlayer.isAlive()
    @Condition Is_Attack_Phase

    eventPlayer.forceButtonPress(Button.ABILITY_1)
    waitUntil(not eventPlayer.isAlive() or not Is_Attack_Phase, 999999986991104)


rule "[ai]: Lucio Amp":
    @Event eachPlayer
    @Team 1
    @Hero lucio
    @Condition eventPlayer.isDummy()
    @Condition eventPlayer.isAlive()
    @Condition Is_Attack_Phase
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_2) == 0

    eventPlayer.forceButtonPress(Button.ABILITY_2)
    wait(1, Wait.ABORT_WHEN_FALSE)
    if ruleCondition:
        loop()


# 音障: 充能满即释放; 按下后充能归零, 条件自然失效。
rule "[ai]: Lucio Use Sound Barrier":
    @Event eachPlayer
    @Team 1
    @Hero lucio
    @Condition eventPlayer.isDummy()
    @Condition eventPlayer.isAlive()
    @Condition Is_Attack_Phase
    @Condition eventPlayer.getUltCharge() == 100

    eventPlayer.forceButtonPress(Button.ULTIMATE)
    wait(1)


rule "[ai]: Roadhog Use Breather":
    @Event eachPlayer
    @Team 1
    @Hero roadhog
    @Condition eventPlayer.isDummy()
    @Condition eventPlayer.isAlive()
    @Condition Is_Attack_Phase
    @Condition eventPlayer.getHealth() <= eventPlayer.getMaxHealth() * 0.5
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_2) == 0

    eventPlayer.forceButtonPress(Button.ABILITY_2)
    wait(3)
    if ruleCondition:
        loop()


rule "[ai]: Junker Queen Use Shout":
    @Event eachPlayer
    @Team 1
    @Hero junker_queen
    @Condition eventPlayer.isDummy()
    @Condition eventPlayer.isAlive()
    @Condition Is_Attack_Phase
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_1) == 0

    eventPlayer.forceButtonPress(Button.ABILITY_1)
    wait(1, Wait.ABORT_WHEN_FALSE)
    if ruleCondition:
        loop()


rule "[ai]: Torbjorn Use Overload":
    @Event eachPlayer
    @Team 1
    @Hero torbjorn
    @Condition eventPlayer.isDummy()
    @Condition eventPlayer.isAlive()
    @Condition Is_Attack_Phase
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_2) == 0

    eventPlayer.forceButtonPress(Button.ABILITY_2)
    wait(1, Wait.ABORT_WHEN_FALSE)
    if ruleCondition:
        loop()


rule "[ai]: venture Use Ability 1":
    @Event eachPlayer
    @Team 1
    @Hero venture
    @Condition eventPlayer.isAlive()
    @Condition isGameInProgress()
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_1) == 0
    @Condition Is_Attack_Phase

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
    @Condition eventPlayer.isAlive()
    @Condition isGameInProgress()
    @Condition eventPlayer.getUltCharge() == 100
    @Condition Is_Attack_Phase

    wait(0.1, Wait.ABORT_WHEN_FALSE)
    eventPlayer.forceButtonPress(Button.ULTIMATE)
    wait(15)
    if ruleCondition:
        loop()


rule "[ai]: ram Use Ability 1":
    @Event eachPlayer
    @Team 1
    @Hero ramattra
    @Condition eventPlayer.isAlive()
    @Condition isGameInProgress()
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_1) == 0
    @Condition not eventPlayer.isUsingAbility1()
    @Condition Is_Attack_Phase

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
    @Condition eventPlayer.isAlive()
    @Condition isGameInProgress()
    @Condition not eventPlayer.isInAir()
    @Condition Is_Attack_Phase

    wait(0.1, Wait.ABORT_WHEN_FALSE)
    eventPlayer.forceButtonPress(Button.ABILITY_1)
    eventPlayer.startForcingButton(Button.JUMP)
    wait(4)
    eventPlayer.stopForcingButton(Button.JUMP)
    if ruleCondition:
        loop()
