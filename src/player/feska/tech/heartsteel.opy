#!mainFile "../../../main.opy"

#!define UPGRADE_ROW_HEARTSTEEL ["心之钢", "每参与消灭 20 次永久增加生命上限\n数值为成长固定值 + 自身最大生命值的 2%", UPGRADE_KIND_TECH, 0, 1, 0, 0, 0, abilityIconString(Hero.JUNKER_QUEEN, Button.ULTIMATE)]

rule "Feska - Heartsteel":
    @Event eachPlayer
    @Team 2
    @Condition Is_Attack_Phase
    @Condition eventPlayer.isAlive()
    @Condition Tech_Id.HEARTSTEEL in eventPlayer.Owned_Tech_Ids

    wait(8, Wait.ABORT_WHEN_FALSE)
    # 统计值被回合或重生重置时会低于基准, 此时以当前值重建基准, 不补发也不重复发放。
    if eventPlayer.getNumberOfElims() < eventPlayer.Elimination_Baseline:
        eventPlayer.Elimination_Baseline = eventPlayer.getNumberOfElims()
    if eventPlayer.getNumberOfElims() - eventPlayer.Elimination_Baseline >= 20:
        eventPlayer.Elimination_Baseline += 20
        eventPlayer.Heartsteel_Flat_Health += round(feskaGrowthHeartsteel() + feskaMaxHealth(eventPlayer) * 0.02)
        Target_Player = eventPlayer
        feskaApplyHeartsteelPool()
        smallMessage(eventPlayer, "心之钢：生命上限 +{0}".format(eventPlayer.Heartsteel_Flat_Health))
    if ruleCondition:
        loop()
