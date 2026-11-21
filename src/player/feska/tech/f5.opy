#!mainFile "../../../main.opy"

#!define UPGRADE_ROW_ABILITY_REFRESH ["F5", "每 5 秒随机重置一个正在冷却中的普通技能", UPGRADE_KIND_TECH, 0, 1, 0, 0, 0, abilityIconString(Hero.TRACER, Button.ULTIMATE), []]

rule "Feska - F5":
    @Event eachPlayer
    @Team 2
    @Condition Is_Attack_Phase
    @Condition eventPlayer.isAlive()
    @Condition Tech_Id.ABILITY_REFRESH in eventPlayer.Owned_Tech_Ids

    wait(5, Wait.ABORT_WHEN_FALSE)
    Ready_Ability_Buttons = [Button.ABILITY_1, Button.ABILITY_2, Button.SECONDARY_FIRE].filter(lambda button: eventPlayer.getAbilityCooldown(button) > 0)
    if len(Ready_Ability_Buttons) > 0:
        eventPlayer.setAbilityCooldown(random.choice(Ready_Ability_Buttons), 0)
        playEffect(eventPlayer, DynamicEffect.TRACER_RECALL_REAPPEAR, Color.AQUA, eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 1.5, 1)
    if ruleCondition:
        loop()
