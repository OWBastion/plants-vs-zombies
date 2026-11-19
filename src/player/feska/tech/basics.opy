#!mainFile "../../../main.opy"

#!define UPGRADE_ROW_BASICS ["回归基本功", "禁用终极技能\n伤害、最大生命值、造成的治疗 +50%", 1, 0, 1, 50, 50, 50]

rule "Feska - Back to basics":
    @Event eachPlayer
    @Team 2
    @Condition TechId.BASICS in eventPlayer.tech

    eventPlayer.bonus[FeskaBonus.DAMAGE] += Upgrades[TechId.BASICS][UPGRADE_COL_DAMAGE]
    eventPlayer.bonus[FeskaBonus.HEALTH] += Upgrades[TechId.BASICS][UPGRADE_COL_HEALTH]
    eventPlayer.bonus[FeskaBonus.HEALING] += Upgrades[TechId.BASICS][UPGRADE_COL_HEALING]
    eventPlayer.setUltEnabled(false)
    feskaApplyUpgradeStats()
