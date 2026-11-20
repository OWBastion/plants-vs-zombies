#!mainFile "../../../main.opy"

# 技能强化: 灼蚀。E 技能造成原生伤害后, 按目标最大生命值附加持续灼烧。
# 工坊没有"按来源停止持续伤害"的动作, 只有全部停止(会误清其他来源), 因此用僵尸侧的来源到期表防叠层:
# 同一持有者未过期时不重复施加; 不同持有者各自独立, 也不影响其他英雄自带的燃烧。
# 灼烧伤害本身不带 ABILITY_2 标记, 不会再次触发这里, 科技追加的派生伤害另有开关过滤。
#!define FESKA_IGNITE_HERO_POOL [Hero.ANA, Hero.REINHARDT, Hero.HANZO, Hero.EMRE, Hero.SIERRA]
#!define FESKA_IGNITE_PERCENT 5
#!define FESKA_IGNITE_SECONDS 3
#!define UPGRADE_ROW_IGNITE ["技能强化：灼蚀", "E 技能造成伤害后\n目标每秒受到其最大生命值 5% 的灼烧, 持续 3 秒", UPGRADE_KIND_SKILL, 0, 1, 0, 0, 0, abilityIconString(Hero.ANA, Button.ABILITY_2), FESKA_IGNITE_HERO_POOL]

rule "Feska - Ignite on ability 2 damage":
    @Event playerDealtDamage
    @Team 2
    @Condition victim.getTeam() == Team.1
    @Condition Tech_Id.IGNITE in eventPlayer.Owned_Tech_Ids
    @Condition eventAbility == Button.ABILITY_2
    @Condition eventPlayer.getHero() in FESKA_IGNITE_HERO_POOL
    @Condition not eventPlayer.Is_Spawning_Derived_Damage

    Ignite_Source_Index = victim.Ignite_Sources.index(eventPlayer)
    if Ignite_Source_Index >= 0:
        # 同源灼烧仍在进行: 不叠层, 也不延长, 保证单次命中固定 3 秒。
        if victim.Ignite_Expire_Times[Ignite_Source_Index] > getTotalTimeElapsed():
            return
        victim.Ignite_Expire_Times[Ignite_Source_Index] = getTotalTimeElapsed() + FESKA_IGNITE_SECONDS
    else:
        victim.Ignite_Sources.append(eventPlayer)
        victim.Ignite_Expire_Times.append(getTotalTimeElapsed() + FESKA_IGNITE_SECONDS)
    victim.setStatusEffect(eventPlayer, Status.BURNING, FESKA_IGNITE_SECONDS)
    victim.startDamageOverTime(eventPlayer, FESKA_IGNITE_SECONDS, ceil(victim.getMaxHealth() * FESKA_IGNITE_PERCENT / 100))


