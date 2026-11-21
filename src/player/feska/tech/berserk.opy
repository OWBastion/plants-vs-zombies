#!mainFile "../../../main.opy"

#!define UPGRADE_ROW_BERSERK ["狂战士之魂", "生命值降至 25% 时进入狂暴：获得 2000% 额外生命值且可自由移动\n期间获得禁疗，每秒损失 10% 最大生命值", UPGRADE_KIND_TECH, 0, 1, 0, 0, 0, abilityIconString(Hero.RAMATTRA, Button.ULTIMATE), []]

rule "Feska - Berserk guard":
    @Event eachPlayer
    @Team 2
    @Condition Is_Attack_Phase
    @Condition Tech_Id.BERSERK in eventPlayer.Owned_Tech_Ids
    @Condition not eventPlayer.Is_Berserk
    @Condition not eventPlayer.Is_Berserk_Guard_Armed
    @Condition eventPlayer.isAlive()

    # 未激活时不死: 致命伤只把生命压到 1, 玩家不进入死亡结算, 单次爆发伤害也不会越过触发阈值。
    # 999999986991104 与 movement.opy 里的等长状态同口径, 远超一局时长。
    eventPlayer.Is_Berserk_Guard_Armed = true
    eventPlayer.setStatusEffect(null, Status.UNKILLABLE, 999999986991104)
    # 阈值与胜利意志同为 feskaMaxHealth 的 25%; 胜利意志规则排在本规则之前, 同一 tick 内先回满血时
    # 本等待不成立, 只有未持有胜利意志(或本波已用掉)时狂战士才接管。
    waitUntil(eventPlayer.getHealth() <= feskaMaxHealth(eventPlayer) * 0.25 or eventPlayer.Is_Berserk == true or not eventPlayer.isAlive() or not Is_Attack_Phase or Tech_Id.BERSERK not in eventPlayer.Owned_Tech_Ids, 999999986991104)
    eventPlayer.Is_Berserk_Guard_Armed = false
    eventPlayer.clearStatusEffect(Status.UNKILLABLE)
    if eventPlayer.isAlive() and eventPlayer.Is_Berserk == false and Is_Attack_Phase and Tech_Id.BERSERK in eventPlayer.Owned_Tech_Ids and eventPlayer.getHealth() <= feskaMaxHealth(eventPlayer) * 0.25:
        eventPlayer.Is_Berserk = true
        eventPlayer.setMaxHealth(feskaBerserkPercent(eventPlayer))
        eventPlayer.setHealth(feskaBerserkMaxHealth(eventPlayer))
        # 禁疗: 挡掉英雄治疗与模式治疗动作; setHealth 与生命池创建不受影响。
        eventPlayer.setHealingReceived(0)
        # 解除进攻定点油门; 状态结束/死亡/换英雄/波次切换时由对应规则恢复。
        eventPlayer.stopForcingThrottle()
        smallMessage(eventPlayer, "狂战士之魂：无法被治疗，每秒损失生命")


rule "Feska - Berserk drain":
    @Event eachPlayer
    @Team 2
    @Condition Is_Attack_Phase
    @Condition eventPlayer.Is_Berserk
    @Condition eventPlayer.isAlive()

    wait(1, Wait.ABORT_WHEN_FALSE)
    damage(eventPlayer, eventPlayer, ceil(feskaBerserkMaxHealth(eventPlayer) * 0.1))
    if ruleCondition:
        loop()
