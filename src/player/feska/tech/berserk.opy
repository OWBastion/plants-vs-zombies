#!mainFile "../../../main.opy"

#!define FESKA_ROW_BERSERK ["狂战士之魂", "生命值降到 25% 时获得 2000% 额外生命值\n无法被治疗, 每秒损失 10% 最大生命值\n可以自由移动", 1, 0, 1, 0, 0, 0]

rule "Feska - Berserk guard":
    @Event eachPlayer
    @Team 2
    @Condition Under_Attack
    @Condition T_BERSERK in eventPlayer.feska_tech
    @Condition eventPlayer.feska_berserk != true
    @Condition eventPlayer.feska_berserk_guard != true
    @Condition eventPlayer.isAlive()

    # 未激活时不死: 致命伤只把生命压到 1, 玩家不进入死亡结算, 单次爆发伤害也不会越过触发阈值。
    # 999999986991104 与 movement.opy 里的等长状态同口径, 远超一局时长。
    eventPlayer.feska_berserk_guard = true
    eventPlayer.setStatusEffect(null, Status.UNKILLABLE, 999999986991104)
    # 阈值与胜利意志同为 feskaMaxHP 的 25%; 胜利意志规则排在本规则之前, 同一 tick 内先回满血时
    # 本等待不成立, 只有未持有胜利意志(或本波已用掉)时狂战士才接管。
    waitUntil(eventPlayer.getHealth() <= feskaMaxHP(eventPlayer) * 0.25 or eventPlayer.feska_berserk == true or not eventPlayer.isAlive() or not Under_Attack or T_BERSERK not in eventPlayer.feska_tech, 999999986991104)
    eventPlayer.feska_berserk_guard = false
    eventPlayer.clearStatusEffect(Status.UNKILLABLE)
    if eventPlayer.isAlive() and eventPlayer.feska_berserk == false and Under_Attack and T_BERSERK in eventPlayer.feska_tech and eventPlayer.getHealth() <= feskaMaxHP(eventPlayer) * 0.25:
        eventPlayer.feska_berserk = true
        eventPlayer.setMaxHealth(feskaBerserkPercent(eventPlayer))
        eventPlayer.setHealth(feskaBerserkMaxHP(eventPlayer))
        # 禁疗: 挡掉英雄治疗与模式治疗动作; setHealth 与生命池创建不受影响。
        eventPlayer.setHealingReceived(0)
        # 解除进攻定点油门; 状态结束/死亡/换英雄/波次切换时由对应规则恢复。
        eventPlayer.stopForcingThrottle()
        smallMessage(eventPlayer, "狂战士之魂：无法被治疗，每秒损失生命")


rule "Feska - Berserk drain":
    @Event eachPlayer
    @Team 2
    @Condition Under_Attack
    @Condition eventPlayer.feska_berserk == true
    @Condition eventPlayer.isAlive()

    wait(1, Wait.ABORT_WHEN_FALSE)
    damage(eventPlayer, eventPlayer, ceil(feskaBerserkMaxHP(eventPlayer) * 0.1))
    if ruleCondition:
        loop()
