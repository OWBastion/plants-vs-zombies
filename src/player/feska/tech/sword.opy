#!mainFile "../../../main.opy"

# 亮出你的剑 (Tech_Id.DRAW_SWORD = 17)
# 牺牲远程换近战: 7 米外僵尸受到本玩家的伤害为 0; 伤害 +50%, 最大生命值 +40%, 武器/近战吸血 15%。
# 范围限制用伤害调整的接收者过滤实现: 只把 7 米外僵尸的受伤百分比压到 0, 数组随重算刷新,
# 僵尸进出 7 米自动生效或失效。与既有伤害加成相乘仍是 0。
#!define UPGRADE_ROW_DRAW_SWORD ["亮出你的剑", "7 米外无法造成伤害\n伤害 +50%, 最大生命值 +40%\n武器/近战吸血 15%", UPGRADE_KIND_TECH, 0, 1, 50, 40, 0, abilityIconString(Hero.GENJI, Button.ULTIMATE)]

rule "Feska - Draw sword stats":
    @Event eachPlayer
    @Team 2
    # 条件由假变真即"获得科技"; 科技不移除, 条件不再变化, 所以只结算一次。
    @Condition Tech_Id.DRAW_SWORD in eventPlayer.Owned_Tech_Ids

    eventPlayer.Bonus_By_Stat[Stat_Bonus.DAMAGE] += Upgrade_Catalog[Tech_Id.DRAW_SWORD][UPGRADE_COLUMN_DAMAGE]
    eventPlayer.Bonus_By_Stat[Stat_Bonus.HEALTH] += Upgrade_Catalog[Tech_Id.DRAW_SWORD][UPGRADE_COLUMN_HEALTH]
    feskaApplyUpgradeStats()


rule "Feska - Draw sword range limit":
    @Event eachPlayer
    @Team 2
    @Condition Tech_Id.DRAW_SWORD in eventPlayer.Owned_Tech_Ids

    startDamageModification(getPlayers(Team.1).filter(lambda player: distance(player, eventPlayer) > 7), eventPlayer, 0, DamageReeval.RECEIVERS_AND_DAMAGERS)
    eventPlayer.Sword_Range_Modification_Id = getLastDamageModification()


rule "Feska - Draw sword lifesteal":
    @Event playerDealtDamage
    @Team 2
    @Condition Tech_Id.DRAW_SWORD in eventPlayer.Owned_Tech_Ids
    @Condition victim.getTeam() == Team.1
    # 只算武器/近战命中, 与冰寒之刃同口径。
    @Condition eventAbility in [Button.PRIMARY_FIRE, Button.SECONDARY_FIRE, Button.MELEE]
    # 范围外伤害已压到 0, 不会产生吸血; 狂战士禁疗。
    @Condition eventPlayer.Is_Berserk != true

    heal(eventPlayer, null, eventDamage * 0.15)
