#!mainFile "../../../main.opy"

#!define UPGRADE_ROW_F5 ["F5", "每 5 秒随机重置一个\n正在冷却的普通技能", 1, 0, 1, 0, 0, 0]

rule "Feska - F5":
    @Event eachPlayer
    @Team 2
    @Condition Under_Attack
    @Condition eventPlayer.isAlive()
    @Condition TechId.F5 in eventPlayer.tech

    wait(5, Wait.ABORT_WHEN_FALSE)
    B = [Button.ABILITY_1, Button.ABILITY_2, Button.SECONDARY_FIRE].filter(lambda button: eventPlayer.getAbilityCooldown(button) > 0)
    if len(B) > 0:
        eventPlayer.setAbilityCooldown(random.choice(B), 0)
    if ruleCondition:
        loop()
