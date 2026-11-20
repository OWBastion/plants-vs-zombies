#!mainFile "../../../main.opy"

#!define UPGRADE_ROW_BRUTAL ["残暴之力", "造成的伤害 +35%", UPGRADE_KIND_TECH, 0, 1, 35, 0, 0, abilityIconString(Hero.DOOMFIST, Button.ULTIMATE)]

rule "Feska - Brutal":
    @Event eachPlayer
    @Team 2
    @Condition Tech_Id.BRUTAL in eventPlayer.Owned_Tech_Ids

    eventPlayer.Bonus_By_Stat[Stat_Bonus.DAMAGE] += Upgrade_Catalog[Tech_Id.BRUTAL][UPGRADE_COLUMN_DAMAGE]
    feskaApplyUpgradeStats()
