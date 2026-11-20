#!mainFile "../../../main.opy"

#!define UPGRADE_ROW_HEALING ["生机增幅", "造成的治疗效果提高 40%", UPGRADE_KIND_TECH, 0, 1, 0, 0, 40, abilityIconString(Hero.BAPTISTE, Button.ULTIMATE), []]

rule "Feska - Healing boost":
    @Event eachPlayer
    @Team 2
    @Condition Tech_Id.HEALING in eventPlayer.Owned_Tech_Ids

    eventPlayer.Bonus_By_Stat[Stat_Bonus.HEALING] += Upgrade_Catalog[Tech_Id.HEALING][UPGRADE_COLUMN_HEALING]
    feskaApplyUpgradeStats()
