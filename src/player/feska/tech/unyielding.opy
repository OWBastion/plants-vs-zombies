#!mainFile "../../../main.opy"

# 屹立不倒: 每损失 1% 最大生命, 获得 1% 全能吸血(按造成的伤害比例回血), 不封顶。
# 派生伤害与狂战士禁疗期间不触发: 前者会自我递归, 后者本来就无法被治疗。
#!define UPGRADE_ROW_UNYIELDING ["屹立不倒", "每损失 1% 生命值，获得 1% 全能吸血", UPGRADE_KIND_TECH, 0, 1, 0, 0, 0, abilityIconString(Hero.REAPER, Button.ABILITY_1), []]

rule "Feska - Unyielding":
    @Event playerDealtDamage
    @Team 2
    @Condition victim.getTeam() == Team.1
    @Condition Tech_Id.UNYIELDING in eventPlayer.Owned_Tech_Ids
    @Condition eventDamage > 0
    @Condition eventPlayer.isAlive()
    @Condition eventPlayer.Is_Berserk != true
    @Condition eventPlayer.Is_Spawning_Derived_Damage != true

    heal(eventPlayer, null, eventDamage * feskaMissingHealthPercent(eventPlayer) / 100)
