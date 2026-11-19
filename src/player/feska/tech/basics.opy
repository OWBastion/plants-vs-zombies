#!mainFile "../../../main.opy"

#!define FESKA_ROW_BASICS ["回归基本功", "禁用终极技能\n伤害、最大生命值、造成的治疗 +50%", 1, 0, 1, 50, 50, 50]

rule "Feska - Back to basics":
    @Event eachPlayer
    @Team 2
    @Condition T_BASICS in eventPlayer.feska_tech

    eventPlayer.feska_bonus[0] += Feska_Upgrades[T_BASICS][FESKA_COL_DAMAGE]
    eventPlayer.feska_bonus[1] += Feska_Upgrades[T_BASICS][FESKA_COL_HEALTH]
    eventPlayer.feska_bonus[2] += Feska_Upgrades[T_BASICS][FESKA_COL_HEALING]
    eventPlayer.setUltEnabled(false)
    feskaApplyUpgradeStats()
