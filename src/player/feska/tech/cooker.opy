#!mainFile "../../../main.opy"

#!define UPGRADE_ROW_PRESSURE_COOKER ["高压锅", "每秒对 9 米内僵尸造成\n自身最大生命值 4% 的伤害", UPGRADE_KIND_TECH, 0, 1, 0, 0, 0]

rule "Feska - Pressure cooker":
    @Event eachPlayer
    @Team 2
    @Condition Is_Attack_Phase
    @Condition eventPlayer.isAlive()
    @Condition Tech_Id.PRESSURE_COOKER in eventPlayer.Owned_Tech_Ids

    wait(1, Wait.ABORT_WHEN_FALSE)
    damage(getPlayersInRadius(eventPlayer, 9, Team.1, LosCheck.SURFACES), eventPlayer, feskaMaxHealth(eventPlayer) * 0.04)
    if ruleCondition:
        loop()
