#!mainFile "../../../main.opy"

#!define UPGRADE_ROW_GIANT ["歌利亚巨人", "最大生命值提高 60%，体型增大 70%", UPGRADE_KIND_TECH, 0, 1, 0, 60, 0, abilityIconString(Hero.WINSTON, Button.ULTIMATE), []]

rule "Feska - Giant":
    @Event eachPlayer
    @Team 2
    @Condition Tech_Id.GIANT in eventPlayer.Owned_Tech_Ids

    eventPlayer.Bonus_By_Stat[Stat_Bonus.HEALTH] += Upgrade_Catalog[Tech_Id.GIANT][UPGRADE_COLUMN_HEALTH]
    eventPlayer.startScalingSize(1.7 + 0.05 * eventPlayer.Heartsteel_Stacks, false)
    feskaApplyUpgradeStats()
