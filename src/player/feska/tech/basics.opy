#!mainFile "../../../main.opy"

#!define UPGRADE_ROW_NO_ULTIMATE ["回归基本功", "禁用终极技能\n伤害、最大生命值、造成的治疗 +50%", UPGRADE_KIND_TECH, 0, 1, 50, 50, 50, abilityIconString(Hero.SOLDIER, Button.PRIMARY_FIRE)]

rule "Feska - Back to basics":
    @Event eachPlayer
    @Team 2
    @Condition Tech_Id.NO_ULTIMATE in eventPlayer.Owned_Tech_Ids

    eventPlayer.Bonus_By_Stat[Stat_Bonus.DAMAGE] += Upgrade_Catalog[Tech_Id.NO_ULTIMATE][UPGRADE_COLUMN_DAMAGE]
    eventPlayer.Bonus_By_Stat[Stat_Bonus.HEALTH] += Upgrade_Catalog[Tech_Id.NO_ULTIMATE][UPGRADE_COLUMN_HEALTH]
    eventPlayer.Bonus_By_Stat[Stat_Bonus.HEALING] += Upgrade_Catalog[Tech_Id.NO_ULTIMATE][UPGRADE_COLUMN_HEALING]
    eventPlayer.setUltEnabled(false)
    feskaApplyUpgradeStats()
