#!mainFile "../../../main.opy"

# 回归基本功 (T_BASICS = 16)
# 纯数值科技 + 禁用终极技能: 数值取自目录行, 获得时在本文件累加。
# 互斥判定(与充能类科技 T_BATTERY/A_ULT)在选牌流程; 属性写入器仍只有 progression.opy 一处。
#!define FESKA_ROW_BASICS ["回归基本功", "禁用终极技能\n伤害、最大生命值、造成的治疗 +50%", 1, 0, 1, 50, 50, 50]

rule "Feska - Back to basics":
    @Event eachPlayer
    @Team 2
    # 条件由假变真即"获得科技"; 科技不移除, 条件不再变化, 所以只结算一次。
    @Condition T_BASICS in eventPlayer.feska_tech

    eventPlayer.feska_bonus[0] += Feska_Upgrades[T_BASICS][FESKA_COL_DAMAGE]
    eventPlayer.feska_bonus[1] += Feska_Upgrades[T_BASICS][FESKA_COL_HEALTH]
    eventPlayer.feska_bonus[2] += Feska_Upgrades[T_BASICS][FESKA_COL_HEALING]
    eventPlayer.setUltEnabled(false)
    Feska_P = eventPlayer
    feskaApplyUpgradeStats()
