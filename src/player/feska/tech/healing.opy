#!mainFile "../../../main.opy"

# 生机增幅 (T_HEALING = 2)
# 纯数值科技: 数值取自目录行, 获得时在本文件累加, 属性写入器仍只有 progression.opy 一处。
# 与 T23 急救用具是同一乘区, 现均计入 feska_bonus[2]; 是否合并只保留一张待用户决定。
#!define FESKA_ROW_HEALING ["生机增幅", "造成的治疗 +40%", 1, 0, 1, 0, 0, 40]

rule "Feska - Healing boost":
    @Event eachPlayer
    @Team 2
    # 条件由假变真即"获得科技"; 科技不移除, 条件不再变化, 所以只结算一次。
    @Condition T_HEALING in eventPlayer.feska_tech

    eventPlayer.feska_bonus[2] += Feska_Upgrades[T_HEALING][FESKA_COL_HEALING]
    Feska_P = eventPlayer
    feskaApplyUpgradeStats()
