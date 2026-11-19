#!mainFile "../../main.opy"

rule "[Juno]: Pulsar Torpedoes":
    @Event playerDealtDamage
    @Team 2
    @Hero juno
    @Condition eventAbility == Button.SECONDARY_FIRE

    damage(victim, attacker, victim.getMaxHealth() * 0.15)


rule "[Juno]: 41":
    @Event eachPlayer
    @Team 2
    @Hero juno
    @Condition eventPlayer.isUsingUltimate() == true
    @Condition len(getLivingPlayers(getOppositeTeam(eventPlayer.getTeam())).filter(lambda player: isInLoS(eventPlayer, player) == true)) > 0

    wait(0.496, Wait.ABORT_WHEN_FALSE)
    # 固化受影响名单: 结束还原时若按当时的存活/LoS 重算, 中途死亡或离开视线的僵尸会永久保留 15% 速度与零重力
    eventPlayer.juno_ray_targets = getLivingPlayers(getOppositeTeam(eventPlayer.getTeam())).filter(lambda player: isInLoS(eventPlayer, player) == true)
    eventPlayer.juno_ray_targets.setEnvironmentalKillCreditor(eventPlayer)
    eventPlayer.juno_ray_targets.setMoveSpeed(15)
    eventPlayer.juno_ray_targets.setGravity(0)
    eventPlayer.juno_ray_targets.applyImpulse(vect(0, 1, 0), 10, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    waitUntil(not eventPlayer.isUsingUltimate(), 8)
    eventPlayer.juno_ray_targets.setGravity(100)
    # 还原到僵尸基准速度, 与 [ai]: Create AI Bot 和重生归一化一致
    eventPlayer.juno_ray_targets.setMoveSpeed(90)
    eventPlayer.juno_ray_targets = []
