#!mainFile "../../main.opy"

# 钩子的拉拽冲量、锁油门与重力改写已移除; 只保留原生钩子效果。
# 85 冲量会把僵尸甩离路线, 且定身期间会覆盖 AI 自己的寻路油门。


rule "[Roadhog]: stun":
    @Event playerDealtDamage
    @Team 2
    @Hero roadhog
    @Condition eventAbility == Button.ABILITY_2
    @Condition eventPlayer.hasStatus(Status.STUNNED) != true

    victim.setStatusEffect(attacker, Status.STUNNED, 1)
    wait(4)
