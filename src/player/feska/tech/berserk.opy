#!mainFile "../../../main.opy"

# 狂战士之魂 (T_BERSERK = 38)
# 受到致命伤害后总生命上限变为可计入最大生命值的 21 倍并回满; 期间禁疗、每秒自损、可自由移动。
# 结束子程序 feskaStopBerserk 在 progression.opy(波次切换与重生流程也要调用)。
#!define FESKA_ROW_BERSERK ["狂战士之魂", "受到致命伤害后获得 2000% 额外生命值\n无法被治疗, 每秒损失 10% 最大生命值\n可以自由移动", 1, 0, 1, 0, 0, 0]

rule "Feska - Berserk trigger":
    @Event playerTookDamage
    @Team 2
    @Condition Under_Attack
    @Condition T_BERSERK in eventPlayer.feska_tech
    @Condition eventPlayer.feska_berserk != true
    @Condition eventPlayer.isAlive()
    @Condition attacker != null
    @Condition attacker.getTeam() == Team.1
    # playerTookDamage 在死亡结算前触发, 此时 getHealth() 是受伤后的数值; ≤0 即本次伤害致命。
    # 该先后语义未在工坊文档中写明, 需游戏内验证; 若实际是受伤前数值, 本科技不会触发而非误触发。
    @Condition eventPlayer.getHealth() <= 0

    # 真实拦截致命伤: 事件内抬生命上限并回满即不会阵亡, 不是先阵亡再复活。
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
