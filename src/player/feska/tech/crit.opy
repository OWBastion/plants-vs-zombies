#!mainFile "../../../main.opy"

# 迁移自巴蒂斯特与雾子的爆头额外伤害, 合并为对所有英雄开放的会心科技。
# 只加脚本伤害, 不改原生爆头倍率; 脚本伤害不产生暴击标记, 不会自我递归。
#!define UPGRADE_ROW_CRIT ["会心一击", "造成暴击时附加 60 + 目标最大生命值 8% 的额外伤害", UPGRADE_KIND_TECH, 0, 1, 0, 0, 0, abilityIconString(Hero.BAPTISTE, Button.PRIMARY_FIRE), []]

rule "Feska - Critical strike":
    @Event playerDealtDamage
    @Team 2
    @Condition victim.getTeam() == Team.1
    @Condition Tech_Id.CRIT in eventPlayer.Owned_Tech_Ids
    @Condition eventWasCriticalHit == true

    damage(victim, eventPlayer, ceil(60 + victim.getMaxHealth() * 0.08))
