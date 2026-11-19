#!mainFile "../../../main.opy"

#!define UPGRADE_ROW_HEALING ["生机增幅", "造成的治疗 +40%", 1, 0, 1, 0, 0, 40]

rule "Feska - Healing boost":
    @Event eachPlayer
    @Team 2
    @Condition TechId.HEALING in eventPlayer.tech

    eventPlayer.bonus[FeskaBonus.HEALING] += Upgrades[TechId.HEALING][UPGRADE_COL_HEALING]
    feskaApplyUpgradeStats()
