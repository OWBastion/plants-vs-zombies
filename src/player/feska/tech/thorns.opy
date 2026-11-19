#!mainFile "../../../main.opy"

#!define FESKA_ROW_THORNS ["反甲", "最大生命值 +20%\n向攻击自己的僵尸返还所受伤害的 50%", 1, 0, 1, 0, 20, 0]

rule "Feska - Thorns health":
    @Event eachPlayer
    @Team 2
    @Condition T_THORNS in eventPlayer.feska_tech

    eventPlayer.feska_bonus[FeskaBonus.HEALTH] += Feska_Upgrades[T_THORNS][FESKA_COL_HEALTH]
    feskaApplyUpgradeStats()

rule "Feska - Thorns":
    @Event playerTookDamage
    @Team 2
    @Condition Under_Attack
    @Condition attacker.getTeam() == Team.1
    @Condition T_THORNS in eventPlayer.feska_tech
    @Condition eventPlayer.feska_chain != true

    damage(attacker, eventPlayer, eventDamage * 0.5)
