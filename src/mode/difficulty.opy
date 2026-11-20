#!mainFile "../main.opy"

# 动态难度: 生命值在僵尸生成时按当前百分比补生命池(见下一条规则), 减伤与伤害用伤害修正实现。
# 伤害修正与 settings 里的 damageReceived%/damageDealt% 相乘, 不会覆盖各英雄已有的属性设置。
rule "Difficulty - Apply zombie damage scaling":
    @Condition isGameInProgress() == true
    @Condition Difficulty_Applied_Player_Count != DIFFICULTY_PLAYER_COUNT() or Difficulty_Applied_For_Wave != Current_Wave

    Difficulty_Applied_Player_Count = DIFFICULTY_PLAYER_COUNT()
    Difficulty_Applied_For_Wave = Current_Wave
    # 接收者与施加者都按队伍取, 新生成的僵尸自动包括在内。
    if Zombie_Received_Modification_Id != null:
        stopDamageModification(Zombie_Received_Modification_Id)
    startDamageModification(getPlayers(Team.1), getPlayers(Team.2), zombieDamageReceivedPercent(), DamageReeval.RECEIVERS_AND_DAMAGERS)
    Zombie_Received_Modification_Id = getLastDamageModification()
    if Zombie_Damage_Modification_Id != null:
        stopDamageModification(Zombie_Damage_Modification_Id)
    startDamageModification(getPlayers(Team.2), getPlayers(Team.1), zombieDamagePercent(), DamageReeval.RECEIVERS_AND_DAMAGERS)
    Zombie_Damage_Modification_Id = getLastDamageModification()


rule "Difficulty - Zombie health pool":
    @Event eachPlayer
    @Team 1
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.isDummy() == true

    # 英雄的 health% 设置在出生时生效, 等一帧再读, 读到的是含设置的当前最大生命。
    wait(0.016, Wait.ABORT_WHEN_FALSE)
    # 生命池是否跨死亡保留没有文档保证: 先按句柄清旧池, 再按当前难度补足, 避免重生叠层。
    if eventPlayer.Zombie_Health_Pool != null:
        removeHealthPool(eventPlayer.Zombie_Health_Pool)
        eventPlayer.Zombie_Health_Pool = null
    if zombieHealthPercent() > 100:
        eventPlayer.addHealthPool(Health.NORMAL, ceil(eventPlayer.getMaxHealth() * (zombieHealthPercent() - 100) / 100), false, false)
        eventPlayer.Zombie_Health_Pool = getLastCreatedHealthPool()
