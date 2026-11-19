#!mainFile "../../../main.opy"

#!define UPGRADE_ROW_COOKER ["高压锅", "每秒对 9 米内僵尸造成\n自身最大生命值 4% 的伤害", 1, 0, 1, 0, 0, 0]

rule "Feska - Pressure cooker":
    @Event eachPlayer
    @Team 2
    @Condition Under_Attack
    @Condition eventPlayer.isAlive()
    @Condition TechId.COOKER in eventPlayer.tech

    wait(1, Wait.ABORT_WHEN_FALSE)
    damage(getPlayersInRadius(eventPlayer, 9, Team.1, LosCheck.SURFACES), eventPlayer, feskaMaxHP(eventPlayer) * 0.04)
    if ruleCondition:
        loop()
