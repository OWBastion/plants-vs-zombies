#!mainFile "../../../main.opy"

#!define UPGRADE_ROW_GLASS_CANNON ["玻璃大炮", "造成的伤害 +55%\n最大生命值 -20%", UPGRADE_KIND_TECH, 0, 1, 55, -20, 0, abilityIconString(Hero.HANZO, Button.ULTIMATE), []]

rule "Feska - Glass cannon":
    @Event eachPlayer
    @Team 2
    @Condition Tech_Id.GLASS_CANNON in eventPlayer.Owned_Tech_Ids

    # 两列都累加完再写入, 避免中间值被 setMaxHealth 采用。
    eventPlayer.Bonus_By_Stat[Stat_Bonus.DAMAGE] += Upgrade_Catalog[Tech_Id.GLASS_CANNON][UPGRADE_COLUMN_DAMAGE]
    eventPlayer.Bonus_By_Stat[Stat_Bonus.HEALTH] += Upgrade_Catalog[Tech_Id.GLASS_CANNON][UPGRADE_COLUMN_HEALTH]
    feskaApplyUpgradeStats()
