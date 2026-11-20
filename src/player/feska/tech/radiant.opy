#!mainFile "../../../main.opy"

#!define UPGRADE_ROW_RADIANT ["神圣光辉", "每 10 秒为 15 米内所有友方\n提供 2.5 秒无敌", UPGRADE_KIND_TECH, 0, 1, 0, 0, 0, abilityIconString(Hero.MERCY, Button.ULTIMATE)]

rule "Feska - Radiant light":
    @Event eachPlayer
    @Team 2
    @Condition Is_Attack_Phase
    @Condition eventPlayer.isAlive()
    @Condition Tech_Id.RADIANT in eventPlayer.Owned_Tech_Ids

    # 进攻期间每 10 秒一轮; 持有者中途死亡则本规则中止, 不补发。
    wait(10, Wait.ABORT_WHEN_FALSE)
    # 15 米内所有友方(含持有者)获得 2.5 秒无敌。setStatusEffect 只叠加时长,
    # 不会清除其他来源的无敌; 不要求视线, 与卡面"15 米内所有友方"一致。
    getLivingPlayers(Team.2).filter(lambda player: not player.isDummy() and distance(player, eventPlayer) <= 15).setStatusEffect(eventPlayer, Status.INVINCIBLE, 2.5)
    if ruleCondition:
        loop()
