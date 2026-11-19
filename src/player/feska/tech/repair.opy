#!mainFile "../../../main.opy"

#!define UPGRADE_ROW_REPAIR ["自我修复", "进攻期间每秒恢复 2% 最大生命值", 1, 0, 1, 0, 0, 0]

rule "Feska - Regeneration":
    @Event eachPlayer
    @Team 2
    @Condition Under_Attack
    @Condition eventPlayer.isAlive()
    # 狂战士禁疗: 自我修复与再生强化都不回血。
    @Condition eventPlayer.berserk != true
    @Condition (TechId.REPAIR in eventPlayer.tech) or eventPlayer.regen > 0

    wait(1, Wait.ABORT_WHEN_FALSE)
    heal(eventPlayer, null, feskaMaxHP(eventPlayer) * ((0.02 if TechId.REPAIR in eventPlayer.tech else 0) + 0.003 * eventPlayer.regen))
    if ruleCondition:
        loop()
