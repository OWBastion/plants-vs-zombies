#!mainFile "../../../main.opy"

# 狂战士之魂 (T_BERSERK = 38)
# 持有期间未激活时处于不死状态; 生命被压到 1 时激活, 总生命上限变为可计入最大生命值的 21 倍并回满,
# 同时取消不死。激活期间禁疗、每秒自损、可自由移动。
# 结束子程序 feskaStopBerserk 在 progression.opy(波次切换与重生流程也要调用)。
#!define FESKA_ROW_BERSERK ["狂战士之魂", "受到致命伤害后获得 2000% 额外生命值\n无法被治疗, 每秒损失 10% 最大生命值\n可以自由移动", 1, 0, 1, 0, 0, 0]

rule "Feska - Berserk guard":
    @Event eachPlayer
    @Team 2
    @Condition Under_Attack
    @Condition T_BERSERK in eventPlayer.feska_tech
    @Condition eventPlayer.feska_berserk != true
    @Condition eventPlayer.feska_berserk_guard != true
    @Condition eventPlayer.isAlive()

    # 未激活时不死: 致命伤只把生命压到 1, 玩家不进入死亡结算, 触发条件因此可观测。
    # 999999986991104 与 movement.opy 里的等长状态同口径, 远超一局时长。
    eventPlayer.feska_berserk_guard = true
    eventPlayer.setStatusEffect(null, Status.UNKILLABLE, 999999986991104)
    # 退出等待: 生命到 1(该触发)、死亡、失去科技、波次结束。条件都不成立时无限等待即期望状态。
    waitUntil(eventPlayer.getHealth() <= 1 or eventPlayer.feska_berserk == true or not eventPlayer.isAlive() or not Under_Attack or T_BERSERK not in eventPlayer.feska_tech, 999999986991104)
    eventPlayer.feska_berserk_guard = false
    # clearStatusEffect 不区分施加者, 这里会连带清掉英雄技能给的同类状态; 本状态只由本规则施加。
    eventPlayer.clearStatusEffect(Status.UNKILLABLE)
    if eventPlayer.isAlive() and eventPlayer.feska_berserk == false and Under_Attack and eventPlayer.getHealth() <= 1 and T_BERSERK in eventPlayer.feska_tech:
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
    # 每秒损失当前最大生命值(21 倍口径)的 10%, 约 10 秒后耗尽; 死亡即状态结束。
    damage(eventPlayer, eventPlayer, ceil(feskaBerserkMaxHP(eventPlayer) * 0.1))
    if ruleCondition:
        loop()
