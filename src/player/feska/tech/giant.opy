#!mainFile "../../../main.opy"

#!define UPGRADE_ROW_GIANT ["歌利亚巨人", "最大生命值 +40%", 1, 0, 1, 0, 40, 0]

rule "Feska - Giant":
    @Event eachPlayer
    @Team 2
    @Condition TechId.GIANT in eventPlayer.tech

    eventPlayer.bonus[FeskaBonus.HEALTH] += Upgrades[TechId.GIANT][UPGRADE_COL_HEALTH]
    feskaApplyUpgradeStats()
