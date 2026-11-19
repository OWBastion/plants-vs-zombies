#!mainFile "../../../main.opy"

#!define FESKA_ROW_BRUTAL ["残暴之力", "造成的伤害 +35%", 1, 0, 1, 35, 0, 0]

rule "Feska - Brutal":
    @Event eachPlayer
    @Team 2
    @Condition T_BRUTAL in eventPlayer.feska_tech

    eventPlayer.feska_bonus[0] += Feska_Upgrades[T_BRUTAL][FESKA_COL_DAMAGE]
    feskaApplyUpgradeStats()
