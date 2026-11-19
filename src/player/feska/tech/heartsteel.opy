# 心之钢 (T_HEARTSTEEL = 21)
# 每参与消灭 20 次永久增加生命上限: 成长固定值 + 触发时最大生命值的 2%。
# 增量只结算一次并保存在 feska_heartsteel_flat, 不追踪包含自身生命池的表达式。
# 生命池应用子程序在 progression.opy(选牌与重生流程也要调用)。
#!define FESKA_ROW_HEARTSTEEL ["心之钢", "每参与消灭 20 次永久增加生命上限\n数值为成长固定值 + 自身最大生命值的 2%", 1, 0, 1, 0, 0, 0]

rule "Feska - Heartsteel":
    @Event playerEarnedElimination
    @Team 2
    @Condition victim.getTeam() == Team.1
    @Condition T_HEARTSTEEL in eventPlayer.feska_tech

    eventPlayer.feska_elim_count += 1
    if eventPlayer.feska_elim_count >= 20:
        eventPlayer.feska_elim_count -= 20
        # 固定增量只结算一次并保存, 不追踪包含自身生命池的表达式。
        eventPlayer.feska_heartsteel_flat += round(feskaGrowthHeartsteel() + feskaMaxHP(eventPlayer) * 0.02)
        Feska_P = eventPlayer
        feskaApplyHeartsteelPool()
        smallMessage(eventPlayer, "心之钢：生命上限 +{0}".format(eventPlayer.feska_heartsteel_flat))
