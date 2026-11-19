#!mainFile "../../../main.opy"

# 残暴之力 (T_BRUTAL = 0)
# 纯数值科技: 数值取自目录行, 获得时在本文件累加, 属性写入器仍只有 progression.opy 一处。
#!define FESKA_ROW_BRUTAL ["残暴之力", "造成的伤害 +35%", 1, 0, 1, 35, 0, 0]

rule "Feska - Brutal":
    @Event eachPlayer
    @Team 2
    # 条件由假变真即"获得科技"; 科技不移除, 条件不再变化, 所以只结算一次。
    @Condition T_BRUTAL in eventPlayer.feska_tech

    eventPlayer.feska_bonus[0] += Feska_Upgrades[T_BRUTAL][FESKA_COL_DAMAGE]
    Feska_P = eventPlayer
    feskaApplyUpgradeStats()
