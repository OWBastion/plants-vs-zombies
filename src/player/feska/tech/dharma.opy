#!mainFile "../../../main.opy"

# 佛法自然(全局唯一): 15 米内的僵尸视为易损, 受到的伤害增加 25%。
# 不给每只僵尸挂易伤标记, 直接改伤害结算倍率: 一个持有者一个修改器句柄, 接收者用半径查询并每帧重估,
# 僵尸走进走出 15 米自动增删。与难度修改器乘算。
# 唯一性由 unique.opy 的 feskaUniqueTechTaken() 保证, 光环中心就是唯一的存活持有者。
#!define FESKA_DHARMA_RADIUS 15
#!define FESKA_DHARMA_PERCENT 125
#!define UPGRADE_ROW_DHARMA ["佛法自然", "15 米内的敌人视为易损，受到的伤害增加 25%", UPGRADE_KIND_TECH, 1, 1, 0, 0, 0, abilityIconString(Hero.ZENYATTA, Button.ABILITY_1), []]

rule "Feska - Dharma aura":
    @Event eachPlayer
    @Team 2
    @Condition isGameInProgress()
    @Condition len(feskaDharmaHolders()) > 0 or Dharma_Mod_Id != null

    # 唯一科技: 存活持有者就是光环中心。0.25 秒重算一次, 中心变化才重建句柄;
    # 僵尸进出 15 米由每帧重估维护, 没有延迟。
    Player_List = feskaAliveDharmaHolders()
    Dharma_Holder = Player_List[0] if len(Player_List) > 0 else null
    if Dharma_Holder != Dharma_Mod_Owner:
        if Dharma_Mod_Id != null:
            stopDamageModification(Dharma_Mod_Id)
            Dharma_Mod_Id = null
        Dharma_Mod_Owner = Dharma_Holder
        if Dharma_Mod_Owner != null:
            startDamageModification(getPlayersInRadius(Dharma_Mod_Owner, FESKA_DHARMA_RADIUS, Team.1, LosCheck.SURFACES), getPlayers(Team.2), FESKA_DHARMA_PERCENT, DamageReeval.RECEIVERS_DAMAGERS_AND_DMGPERCENT)
            Dharma_Mod_Id = getLastDamageModification()
    wait(0.25, Wait.ABORT_WHEN_FALSE)
    if ruleCondition:
        loop()


rule "Feska - Dharma orb":
    @Event eachPlayer
    @Team 2
    @Condition Is_Attack_Phase
    @Condition Tech_Id.DHARMA in eventPlayer.Owned_Tech_Ids
    @Condition getTotalTimeElapsed() >= Dharma_Orb_Next_At

    # 特效只是视觉: 0.5 秒扫一次范围, 缺特效就建、出范围或死亡就收, 不影响伤害结算。
    Dharma_Orb_Next_At = getTotalTimeElapsed() + 0.5
    Effect_Targets = getPlayersInRadius(eventPlayer, FESKA_DHARMA_RADIUS, Team.1, LosCheck.SURFACES).filter(lambda player: player.isAlive() and player.Dharma_Orb_Id == 0)
    for Loop_Index in range(len(Effect_Targets)):
        createEffect(getAllPlayers(), Effect.ZENYATTA_ORB_OF_DISCORD_TARGET, Color.PURPLE, Effect_Targets[Loop_Index], 0.3, EffectReeval.POSITION_AND_RADIUS)
        Effect_Targets[Loop_Index].Dharma_Orb_Id = getLastCreatedEntity()
    Effect_Targets = getPlayers(Team.1).filter(lambda player: player.Dharma_Orb_Id != 0 and (not player.isAlive() or distance(eventPlayer, player) > FESKA_DHARMA_RADIUS))
    for Loop_Index in range(len(Effect_Targets)):
        destroyEffect(Effect_Targets[Loop_Index].Dharma_Orb_Id)
        Effect_Targets[Loop_Index].Dharma_Orb_Id = 0
