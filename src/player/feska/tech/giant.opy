#!mainFile "../../../main.opy"

#!define FESKA_ROW_GIANT ["歌利亚巨人", "最大生命值 +40%", 1, 0, 1, 0, 40, 0]

rule "Feska - Giant":
    @Event eachPlayer
    @Team 2
    @Condition T_GIANT in eventPlayer.feska_tech

    eventPlayer.feska_bonus[1] += Feska_Upgrades[T_GIANT][FESKA_COL_HEALTH]
    feskaApplyUpgradeStats()
