# 冰寒之刃 (T_ICE = 15)
# 武器命中有 15% 概率冰冻目标 0.6 秒, 每个目标冷却 5 秒(feska_freeze_cd)。
#!define FESKA_ROW_ICE ["冰寒之刃", "武器命中有 15% 概率冰冻目标 0.6 秒\n每个目标冷却 5 秒", 1, 0, 1, 0, 0, 0]

rule "Feska - Ice blade":
    @Event playerDealtDamage
    @Team 2
    @Condition victim.getTeam() == Team.1
    @Condition T_ICE in eventPlayer.feska_tech
    @Condition eventAbility in [Button.PRIMARY_FIRE, Button.SECONDARY_FIRE, Button.MELEE]
    @Condition victim.feska_freeze_cd != true
    @Condition random.uniform(0, 100) < 15

    victim.feska_freeze_cd = true
    victim.setStatusEffect(eventPlayer, Status.FROZEN, 0.6)
    wait(5)
    victim.feska_freeze_cd = false
