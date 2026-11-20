#!mainFile "../main.opy"

# 动态难度: 生命值用设置最大生命值, 减伤与伤害用伤害修正。
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


rule "Difficulty - Zombie max health":
    @Event eachPlayer
    @Team 1
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.isDummy() == true
    @Condition zombieHealthPercent() != 100

    # setMaxHealth 的百分比以英雄原始最大生命为基准, 会把 settings 里该英雄的 health% 顶掉。
    # 先记下出生时(含 health%)的最大生命, 归一到 100% 读出原始值, 再按 难度×玩家数 的倍率写回。
    wait(0.016, Wait.ABORT_WHEN_FALSE)
    eventPlayer.Zombie_Base_Max_Health = eventPlayer.getMaxHealth()
    eventPlayer.setMaxHealth(100)
    # 等 100% 写入后再读, 下面的分母就是原始最大生命。
    wait(0.016, Wait.ABORT_WHEN_FALSE)
    eventPlayer.setMaxHealth(eventPlayer.Zombie_Base_Max_Health * zombieHealthPercent() / eventPlayer.getMaxHealth() * 100)
    # 归一时当前生命被压到新的最大值, 写回后补满, 保证出生即满血。
    eventPlayer.setHealth(eventPlayer.getMaxHealth())
