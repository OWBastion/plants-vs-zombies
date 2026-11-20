#!mainFile "../../main.opy"

rule "[Juno]: Pulsar Torpedoes":
    @Event playerDealtDamage
    @Team 2
    @Hero juno
    @Condition eventAbility == Button.SECONDARY_FIRE

    damage(victim, attacker, victim.getMaxHealth() * 0.15)

# 轨道射线对僵尸的 15% 移速、零重力与上抛已移除; 大招只保留原生增伤/治疗光环。
# 浮空与减速属于位移控制, 会让僵尸离开寻路路线。
