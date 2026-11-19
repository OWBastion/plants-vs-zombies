#!mainFile "../../../main.opy"

#!define UPGRADE_ROW_BRUTAL ["残暴之力", "造成的伤害 +35%", 1, 0, 1, 35, 0, 0]

rule "Feska - Brutal":
    @Event eachPlayer
    @Team 2
    @Condition TechId.BRUTAL in eventPlayer.tech

    eventPlayer.bonus[FeskaBonus.DAMAGE] += Upgrades[TechId.BRUTAL][UPGRADE_COL_DAMAGE]
    feskaApplyUpgradeStats()
