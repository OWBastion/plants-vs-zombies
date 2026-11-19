#!mainFile "../../../main.opy"

#!define UPGRADE_ROW_ICE ["冰寒之刃", "武器命中有 25% 概率冰冻目标 0.6 秒", 1, 0, 1, 0, 0, 0]

rule "Feska - Ice blade":
    @Event playerDealtDamage
    @Team 2
    @Condition victim.getTeam() == Team.1
    @Condition TechId.ICE in eventPlayer.tech
    @Condition eventAbility in [Button.PRIMARY_FIRE, Button.SECONDARY_FIRE, Button.MELEE]
    @Condition random.uniform(0, 100) < 25

    victim.setStatusEffect(eventPlayer, Status.FROZEN, 0.6)
