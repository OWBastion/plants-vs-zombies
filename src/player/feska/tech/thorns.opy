#!mainFile "../../../main.opy"

# 反甲 (T_THORNS = 5)
# 目录行含 +20% 最大生命值, 获得时由下面的规则累加; 返还伤害由受伤事件规则结算。
#!define FESKA_ROW_THORNS ["反甲", "最大生命值 +20%\n向攻击自己的僵尸返还所受伤害的 50%", 1, 0, 1, 0, 20, 0]

rule "Feska - Thorns health":
    @Event eachPlayer
    @Team 2
    # 条件由假变真即"获得科技"; 科技不移除, 条件不再变化, 所以只结算一次。
    @Condition T_THORNS in eventPlayer.feska_tech

    eventPlayer.feska_bonus[1] += Feska_Upgrades[T_THORNS][FESKA_COL_HEALTH]
    Feska_P = eventPlayer
    feskaApplyUpgradeStats()

rule "Feska - Thorns":
    @Event playerTookDamage
    @Team 2
    @Condition Under_Attack
    @Condition attacker.getTeam() == Team.1
    @Condition T_THORNS in eventPlayer.feska_tech
    @Condition eventPlayer.feska_chain != true

    damage(attacker, eventPlayer, eventDamage * 0.5)
