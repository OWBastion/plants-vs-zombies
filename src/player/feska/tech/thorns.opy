#!mainFile "../../../main.opy"

#!define UPGRADE_ROW_THORNS ["反甲", "最大生命值提高 20%，受到攻击时向攻击者反弹 50% 所受伤害", UPGRADE_KIND_TECH, 0, 1, 0, 20, 0, abilityIconString(Hero.ZARYA, Button.ULTIMATE), []]

rule "Feska - Thorns health":
    @Event eachPlayer
    @Team 2
    @Condition Tech_Id.THORNS in eventPlayer.Owned_Tech_Ids

    eventPlayer.Bonus_By_Stat[Stat_Bonus.HEALTH] += Upgrade_Catalog[Tech_Id.THORNS][UPGRADE_COLUMN_HEALTH]
    feskaApplyUpgradeStats()

rule "Feska - Thorns":
    @Event playerTookDamage
    @Team 2
    @Condition Is_Attack_Phase
    @Condition attacker.getTeam() == Team.1
    @Condition Tech_Id.THORNS in eventPlayer.Owned_Tech_Ids
    @Condition eventPlayer.Is_Spawning_Derived_Damage != true

    damage(attacker, eventPlayer, eventDamage * 0.5)
