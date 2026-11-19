#!mainFile "../../../main.opy"

#!define UPGRADE_ROW_FLESH ["血肉再生", "每 10 秒获得临时生命值\n数值为成长固定值 + 自身最大生命值的 5%", 1, 0, 1, 0, 0, 0]

rule "Feska - Blood regeneration":
    @Event eachPlayer
    @Team 2
    @Condition Under_Attack
    @Condition eventPlayer.isAlive()
    @Condition TechId.FLESH in eventPlayer.tech

    wait(10, Wait.ABORT_WHEN_FALSE)
    if eventPlayer.blood_pool != null:
        removeHealthPool(eventPlayer.blood_pool)
    eventPlayer.addHealthPool(Health.NORMAL, ceil(feskaGrowthPool() + feskaMaxHP(eventPlayer) * 0.05), true, false)
    eventPlayer.blood_pool = getLastCreatedHealthPool()
    if ruleCondition:
        loop()
