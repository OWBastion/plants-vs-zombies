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
    # 显式判空: 脚本流血与自损的 attacker 为 null, 不在 null 上调用成员方法。
    @Condition attacker != null
    @Condition attacker.getTeam() == Team.1
    @Condition Tech_Id.THORNS in eventPlayer.Owned_Tech_Ids
    @Condition not eventPlayer.Is_Spawning_Derived_Damage

    playEffect(eventPlayer, DynamicEffect.REINHARDT_FIRE_STRIKE_TARGET_IMPACT, Color.ORANGE, attacker, 0.5)
    damage(attacker, eventPlayer, eventDamage * 0.5)
