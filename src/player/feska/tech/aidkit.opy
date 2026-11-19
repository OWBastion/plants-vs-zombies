#!mainFile "../../../main.opy"

# 急救用具 (T_AIDKIT = 34)
# 纯数值科技: 数值取自目录行, 获得时在本文件累加, 属性写入器仍只有 progression.opy 一处。
# 与 T03 生机增幅同一乘区, 均计入 feska_bonus[2]; 是否合并只保留一张, 待用户决定。
#!define FESKA_ROW_AIDKIT ["急救用具", "造成的治疗 +35%", 1, 0, 1, 0, 0, 35]

rule "Feska - Aid kit":
    @Event eachPlayer
    @Team 2
    # 条件由假变真即"获得科技"; 科技不移除, 条件不再变化, 所以只结算一次。
    @Condition T_AIDKIT in eventPlayer.feska_tech

    eventPlayer.feska_bonus[2] += Feska_Upgrades[T_AIDKIT][FESKA_COL_HEALING]
    Feska_P = eventPlayer
    feskaApplyUpgradeStats()
