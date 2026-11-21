#!mainFile "../../../main.opy"

#!define UPGRADE_ROW_ICE ["冰寒之刃", "武器命中时有 25% 概率使目标冰冻 0.6 秒", UPGRADE_KIND_TECH, 0, 1, 0, 0, 0, abilityIconString(Hero.MEI, Button.PRIMARY_FIRE), []]

rule "Feska - Ice blade":
    @Event playerDealtDamage
    @Team 2
    @Condition victim.getTeam() == Team.1
    @Condition Tech_Id.ICE in eventPlayer.Owned_Tech_Ids
    @Condition eventAbility in [Button.PRIMARY_FIRE, Button.SECONDARY_FIRE, Button.MELEE]
    @Condition random.uniform(0, 100) < 25

    victim.setStatusEffect(eventPlayer, Status.FROZEN, 0.6)
    playEffect(eventPlayer, DynamicEffect.HANZO_SONIC_ARROW_INITIAL_PULSE, Color.AQUA, victim, 0.5)
