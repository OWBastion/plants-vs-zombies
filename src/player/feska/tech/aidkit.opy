#!mainFile "../../../main.opy"

#!define FESKA_ROW_AIDKIT ["急救用具", "造成的治疗 +35%", 1, 0, 1, 0, 0, 35]

rule "Feska - Aid kit":
    @Event eachPlayer
    @Team 2
    @Condition T_AIDKIT in eventPlayer.feska_tech

    eventPlayer.feska_bonus[2] += Feska_Upgrades[T_AIDKIT][FESKA_COL_HEALING]
    Feska_P = eventPlayer
    feskaApplyUpgradeStats()
