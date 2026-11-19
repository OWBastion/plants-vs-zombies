#!mainFile "../../../main.opy"

#!define FESKA_ROW_HEALING ["生机增幅", "造成的治疗 +40%", 1, 0, 1, 0, 0, 40]

rule "Feska - Healing boost":
    @Event eachPlayer
    @Team 2
    @Condition T_HEALING in eventPlayer.feska_tech

    eventPlayer.feska_bonus[FeskaBonus.HEALING] += Feska_Upgrades[T_HEALING][FESKA_COL_HEALING]
    feskaApplyUpgradeStats()
