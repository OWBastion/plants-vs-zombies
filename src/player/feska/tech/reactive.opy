#!mainFile "../../../main.opy"

# 反应装甲 (T_REACTIVE = 37)
# 获得 100 + 可计入最大生命 10% 的可恢复护甲; 护甲未被打穿时眩晕攻击者 1.2 秒。
# 击穿判定直接读工坊护甲值(Health Of Type), 不维护镜像; 护甲池在每个准备阶段整池重建。
# 护甲池应用子程序在 progression.opy(选牌、准备阶段与重生流程也要调用)。
#!define FESKA_ROW_REACTIVE ["反应装甲", "获得 100+自身最大生命值 10% 的可恢复护甲\n僵尸未击穿护甲时, 眩晕攻击者 1.2 秒", 1, 0, 1, 0, 0, 0]

rule "Feska - Reactive armor":
    @Event playerTookDamage
    @Team 2
    @Condition T_REACTIVE in eventPlayer.feska_tech
    @Condition attacker != null
    @Condition attacker != eventPlayer
    # 护甲为 0 即被击穿, 不再眩晕。不设内置冷却, 触发频率由护甲量自然限制。
    @Condition eventPlayer.getHealthOfType(Health.ARMOR) > 0

    attacker.setStatusEffect(eventPlayer, Status.STUNNED, 1.2)
