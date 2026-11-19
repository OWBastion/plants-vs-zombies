# 自我修复 (T_REPAIR = 3)
# 进攻期间每秒恢复 2% 最大生命值; 同时服务属性强化·再生(feska_regen), 两者共用同一条规则。
#!define FESKA_ROW_REPAIR ["自我修复", "进攻期间每秒恢复 2% 最大生命值", 1, 0, 1, 0, 0, 0]

rule "Feska - Regeneration":
    @Event eachPlayer
    @Team 2
    @Condition Under_Attack
    @Condition eventPlayer.isAlive()
    # 狂战士禁疗: 自我修复与再生强化都不回血。
    @Condition eventPlayer.feska_berserk != true
    @Condition (T_REPAIR in eventPlayer.feska_tech) or eventPlayer.feska_regen > 0

    wait(1, Wait.ABORT_WHEN_FALSE)
    heal(eventPlayer, null, feskaMaxHP(eventPlayer) * ((0.02 if T_REPAIR in eventPlayer.feska_tech else 0) + 0.003 * eventPlayer.feska_regen))
    if ruleCondition:
        loop()
