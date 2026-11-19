#!mainFile "../../../main.opy"

#!define UPGRADE_ROW_AIDKIT ["急救用具", "造成的治疗 +35%", 1, 0, 1, 0, 0, 35]

rule "Feska - Aid kit":
    @Event eachPlayer
    @Team 2
    @Condition TechId.AIDKIT in eventPlayer.tech

    eventPlayer.bonus[FeskaBonus.HEALING] += Upgrades[TechId.AIDKIT][UPGRADE_COL_HEALING]
    feskaApplyUpgradeStats()
