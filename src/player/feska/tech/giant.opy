#!mainFile "../../../main.opy"

# 歌利亚巨人 (T_GIANT = 1)
# 纯数值科技: 数值取自目录行, 获得时在本文件累加, 属性写入器仍只有 progression.opy 一处。
#!define FESKA_ROW_GIANT ["歌利亚巨人", "最大生命值 +40%", 1, 0, 1, 0, 40, 0]

rule "Feska - Giant":
    @Event eachPlayer
    @Team 2
    # 条件由假变真即"获得科技"; 科技不移除, 条件不再变化, 所以只结算一次。
    @Condition T_GIANT in eventPlayer.feska_tech

    eventPlayer.feska_bonus[1] += Feska_Upgrades[T_GIANT][FESKA_COL_HEALTH]
    Feska_P = eventPlayer
    feskaApplyUpgradeStats()
