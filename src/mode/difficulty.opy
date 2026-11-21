#!mainFile "../main.opy"

# 动态难度: 减伤与伤害用伤害修正。僵尸生命值只由 settings 决定, 不随难度和人数量调整。
# 伤害修正与 settings 里的 damageReceived%/damageDealt% 相乘, 不会覆盖各英雄已有的属性设置。
rule "Difficulty - Apply zombie damage scaling":
    @Condition isGameInProgress()
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
