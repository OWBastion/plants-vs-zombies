#!mainFile "../../../main.opy"

#!define UPGRADE_ROW_FLESH_REGENERATION ["血肉再生", "每 10 秒获得临时生命值\n数值为成长固定值 + 自身最大生命值的 5%", UPGRADE_KIND_TECH, 0, 1, 0, 0, 0]

rule "Feska - Blood regeneration":
    @Event eachPlayer
    @Team 2
    @Condition Is_Attack_Phase
    @Condition eventPlayer.isAlive()
    @Condition Tech_Id.FLESH_REGENERATION in eventPlayer.Owned_Tech_Ids

    wait(10, Wait.ABORT_WHEN_FALSE)
    if eventPlayer.Regeneration_Health_Pool != null:
        removeHealthPool(eventPlayer.Regeneration_Health_Pool)
    eventPlayer.addHealthPool(Health.NORMAL, ceil(feskaPoolGrowthValue() + feskaMaxHealth(eventPlayer) * 0.05), true, false)
    eventPlayer.Regeneration_Health_Pool = getLastCreatedHealthPool()
    if ruleCondition:
        loop()
