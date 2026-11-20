#!mainFile "../../../main.opy"

# 铁血无情: 合并已删除的索杰恩 20% 血线斩杀与 Freja 残血斩杀, 改为所有英雄通用的科技。
# 阈值与伤害口径写在两个宏里; 伤害取 剩余生命 + 两倍最大生命, 使 50% 以内的减伤也无法救回目标。
# 斩杀伤害本身也会产生 playerDealtDamage, 用派生伤害开关挡住, 避免自我递归。
#!define FESKA_EXECUTE_THRESHOLD 12
#!define UPGRADE_ROW_EXECUTE ["铁血无情", "处决生命值低于 12% 的敌人", UPGRADE_KIND_TECH, 0, 1, 0, 0, 0, abilityIconString(Hero.SOJOURN, Button.SECONDARY_FIRE), []]

rule "Feska - Execute":
    @Event playerDealtDamage
    @Team 2
    @Condition victim.getTeam() == Team.1
    @Condition Tech_Id.EXECUTE in eventPlayer.Owned_Tech_Ids
    @Condition eventPlayer.Is_Spawning_Derived_Damage != true
    @Condition victim.isAlive() == true
    @Condition victim.getHealth() <= victim.getMaxHealth() * FESKA_EXECUTE_THRESHOLD / 100

    eventPlayer.Is_Spawning_Derived_Damage = true
    damage(victim, eventPlayer, victim.getHealth() + victim.getMaxHealth() * 2)
    wait(0.032)
    eventPlayer.Is_Spawning_Derived_Damage = false
