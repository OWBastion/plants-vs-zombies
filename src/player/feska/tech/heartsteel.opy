#!mainFile "../../../main.opy"

#!define FESKA_ROW_HEARTSTEEL ["心之钢", "每参与消灭 20 次永久增加生命上限\n数值为成长固定值 + 自身最大生命值的 2%", 1, 0, 1, 0, 0, 0]

rule "Feska - Heartsteel":
    @Event eachPlayer
    @Team 2
    @Condition Under_Attack
    @Condition eventPlayer.isAlive()
    @Condition T_HEARTSTEEL in eventPlayer.feska_tech

    wait(8, Wait.ABORT_WHEN_FALSE)
    # 统计值被回合或重生重置时会低于基准, 此时以当前值重建基准, 不补发也不重复发放。
    if eventPlayer.getNumberOfElims() < eventPlayer.feska_elim_mark:
        eventPlayer.feska_elim_mark = eventPlayer.getNumberOfElims()
    if eventPlayer.getNumberOfElims() - eventPlayer.feska_elim_mark >= 20:
        eventPlayer.feska_elim_mark += 20
        eventPlayer.feska_heartsteel_flat += round(feskaGrowthHeartsteel() + feskaMaxHP(eventPlayer) * 0.02)
        Feska_P = eventPlayer
        feskaApplyHeartsteelPool()
        smallMessage(eventPlayer, "心之钢：生命上限 +{0}".format(eventPlayer.feska_heartsteel_flat))
    if ruleCondition:
        loop()
