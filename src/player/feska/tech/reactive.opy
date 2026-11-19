#!mainFile "../../../main.opy"

# 反应装甲 (T_REACTIVE = 37)
# 获得 100 + 可计入最大生命 10% 的可恢复护甲; 本来源护甲拦下伤害时眩晕攻击者 1.2 秒。
# 工坊不能读取生命池余量, 未击穿判定靠镜像值 feska_reactive_value(只少判不会多判)。
# 护甲池应用子程序在 progression.opy(选牌与重生流程也要调用)。
#!define FESKA_ROW_REACTIVE ["反应装甲", "获得 100+自身最大生命值 10% 的可恢复护甲\n僵尸未击穿护甲时, 眩晕攻击者 1.2 秒", 1, 0, 1, 0, 0, 0]

rule "Feska - Reactive armor":
    @Event playerTookDamage
    @Team 2
    @Condition T_REACTIVE in eventPlayer.feska_tech
    @Condition attacker != null
    @Condition attacker != eventPlayer

    # 工坊不能读取生命池余量: 用镜像值近似本来源护甲。任何受伤都记录时间(游戏池离战才恢复),
    # 本次伤害被护甲拦下时眩晕攻击者 1.2 秒。镜像按本来源口径扣减, 打在英雄护盾/护甲上的伤害
    # 也会扣减镜像, 只会少判不会多判; 1.2 秒眩晕不设内置冷却, 频率由护甲量自然限制。
    eventPlayer.feska_reactive_last_hit = getTotalTimeElapsed()
    if eventDamage <= eventPlayer.feska_reactive_value:
        attacker.setStatusEffect(eventPlayer, Status.STUNNED, 1.2)
    eventPlayer.feska_reactive_value = max(eventPlayer.feska_reactive_value - eventDamage, 0)


rule "Feska - Reactive armor recover":
    @Event eachPlayer
    @Team 2
    @Condition T_REACTIVE in eventPlayer.feska_tech
    @Condition eventPlayer.isAlive()

    wait(1, Wait.ABORT_WHEN_FALSE)
    # 离战 3 秒后镜像回满, 近似护甲池的恢复节奏(实际池恢复曲线不能读取, 需游戏内核对)。
    if eventPlayer.feska_reactive_last_hit != null and getTotalTimeElapsed() - eventPlayer.feska_reactive_last_hit >= 3:
        eventPlayer.feska_reactive_value = feskaReactiveArmor(eventPlayer)
        eventPlayer.feska_reactive_last_hit = null
    if ruleCondition:
        loop()
