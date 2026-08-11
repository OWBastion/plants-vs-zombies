# Zombie 战斗/技能控制 (M3 收敛):
# - 普通僵尸: 仅依赖 [ai]: Base Melee 基础近战循环, 在近战范围内按节奏触发。
# - 特殊僵尸: venture / brig / ram / pharah 规则声明各自差异, 其余英雄默认纯近战。
# - 已删除 C 类遗留: 通用 Ability 1 spam(含 Reinhardt/JQ/Echo/D.Va 等远程技能)、
#   Soldier Helix(远程且以终极技能充能做触发条件)、Sombra 传送器 spam。

rule "[ai]: Base Melee":
    @Event eachPlayer
    @Team 1
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.isDummy() == true
    @Condition isGameInProgress() == true
    @Condition Under_Attack == true
    @Condition eventPlayer.BotTarget != null
    @Condition eventPlayer.BotTarget.isAlive() == true
    @Condition distance(eventPlayer, eventPlayer.BotTarget) <= 2.5
    @Condition eventPlayer.isUsingAbility1() != true
    @Condition eventPlayer.isUsingAbility2() != true
    @Condition eventPlayer.isUsingUltimate() != true

    wait(0.15, Wait.ABORT_WHEN_FALSE)
    eventPlayer.forceButtonPress(Button.MELEE)
    wait(0.5)
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
