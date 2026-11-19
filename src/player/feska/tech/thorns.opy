#!mainFile "../../../main.opy"

#!define UPGRADE_ROW_THORNS ["反甲", "最大生命值 +20%\n向攻击自己的僵尸返还所受伤害的 50%", 1, 0, 1, 0, 20, 0]

rule "Feska - Thorns health":
    @Event eachPlayer
    @Team 2
    @Condition TechId.THORNS in eventPlayer.tech

    eventPlayer.bonus[FeskaBonus.HEALTH] += Upgrades[TechId.THORNS][UPGRADE_COL_HEALTH]
    feskaApplyUpgradeStats()

rule "Feska - Thorns":
    @Event playerTookDamage
    @Team 2
    @Condition Under_Attack
    @Condition attacker.getTeam() == Team.1
    @Condition TechId.THORNS in eventPlayer.tech
    @Condition eventPlayer.chain != true

    damage(attacker, eventPlayer, eventDamage * 0.5)
