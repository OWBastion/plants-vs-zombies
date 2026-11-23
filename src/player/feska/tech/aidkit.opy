#!mainFile "../../../main.opy"

#!define UPGRADE_ROW_FIRST_AID_KIT ["急救用具", "造成的治疗效果提高 35%", UPGRADE_KIND_TECH, 0, 1, 0, 0, 35, abilityIconString(Hero.MERCY, Button.PRIMARY_FIRE), []]

rule "Feska - Aid kit":
    @Event eachPlayer
    @Team 2
    @Condition Tech_Id.FIRST_AID_KIT in eventPlayer.Owned_Tech_Ids

    eventPlayer.Bonus_By_Stat[Stat_Bonus.HEALING] += Upgrade_Catalog[Tech_Id.FIRST_AID_KIT][UPGRADE_COLUMN_HEALING]
    feskaApplyUpgradeStats()
