#!mainFile "../../../main.opy"

# 血肉再生 (T_FLESH = 23)
# 每 10 秒获得临时生命值: 成长固定值 + 自身最大生命值的 5%; 同来源不叠加(feska_blood_pool 覆盖)。
# 波次结束时由清理规则移除生命池。
#!define FESKA_ROW_FLESH ["血肉再生", "每 10 秒获得临时生命值\n数值为成长固定值 + 自身最大生命值的 5%", 1, 0, 1, 0, 0, 0]

rule "Feska - Blood regeneration":
    @Event eachPlayer
    @Team 2
    @Condition Under_Attack
    @Condition eventPlayer.isAlive()
    @Condition T_FLESH in eventPlayer.feska_tech

    wait(10, Wait.ABORT_WHEN_FALSE)
    if eventPlayer.feska_blood_pool != null:
        removeHealthPool(eventPlayer.feska_blood_pool)
    eventPlayer.addHealthPool(Health.NORMAL, ceil(feskaGrowthPool() + feskaMaxHP(eventPlayer) * 0.05), true, false)
    eventPlayer.feska_blood_pool = getLastCreatedHealthPool()
    if ruleCondition:
        loop()
