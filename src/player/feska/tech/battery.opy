#!mainFile "../../../main.opy"

#!define FESKA_ROW_BATTERY ["我按Q辣", "进攻期间每秒额外获得\n0.8% 终极技能充能", 1, 0, 1, 0, 0, 0]

rule "Feska - Ultimate charge":
    @Event eachPlayer
    @Team 2
    @Condition Under_Attack
    @Condition eventPlayer.isAlive()
    @Condition (T_BATTERY in eventPlayer.feska_tech) or eventPlayer.feska_ult_rate > 0

    wait(1, Wait.ABORT_WHEN_FALSE)
    eventPlayer.setUltCharge(min(eventPlayer.getUltCharge() + (0.8 if T_BATTERY in eventPlayer.feska_tech else 0) + 0.2 * eventPlayer.feska_ult_rate, 100))
    if ruleCondition:
        loop()
