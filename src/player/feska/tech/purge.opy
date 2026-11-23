#!mainFile "../../../main.opy"

#!define UPGRADE_ROW_SOUL_PURGE ["心灵净化", "最后一击引爆目标，对其 5 米内的其他僵尸造成 60 + 目标最大生命值 12% 的伤害", UPGRADE_KIND_TECH, 0, 1, 0, 0, 0, abilityIconString(Hero.JUNKRAT, Button.ULTIMATE), []]

rule "Feska - Soul purge":
    @Event playerDealtFinalBlow
    @Team 2
    @Condition victim.getTeam() == Team.1
    @Condition Tech_Id.SOUL_PURGE in eventPlayer.Owned_Tech_Ids
    @Condition not eventPlayer.Is_Spawning_Derived_Damage

    # 派生伤害期间关闭引爆, 避免连锁爆炸递归。
    eventPlayer.Is_Spawning_Derived_Damage = true
    playEffect(getPlayers(Team.2), DynamicEffect.ZARYA_PARTICLE_CANNON_EXPLOSION, Color.BLUE, victim, 3)
    damage(getPlayersInRadius(victim, 5, Team.1, LosCheck.SURFACES).filter(lambda player: player != victim), eventPlayer, 60 + victim.getMaxHealth() * 0.12)
    wait(0.032)
    eventPlayer.Is_Spawning_Derived_Damage = false
