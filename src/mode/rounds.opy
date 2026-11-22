#!mainFile "../main.opy"

rule "Players - Round Lead Time Start":
    @Condition isAssemblingHeroes() or isGameInProgress()
    @Condition Current_Wave < Total_Wave_Count
    @Condition not Is_Attack_Phase

    waitUntil(not isAssemblingHeroes() and isGameInProgress(), 999999986991104)
    destroyAllDummies()
    Zombie_Wave_Heroes = random.shuffle(Zombie_Hero_Pool)
    Zombie_Wave_Heroes.append(random.shuffle(Zombie_Hero_Pool))
    chaseOverTime(Wave_Prep_Time_Left, 0, Wave_Prep_Duration, ChaseTimeReeval.NONE)
    bigMessage(getAllPlayers(), "第 {0} 波即将开始".format(Current_Wave + 1))


rule "Players - Round Lead Time End":
    @Condition isGameInProgress()
    @Condition Current_Wave < Total_Wave_Count
    @Condition not Is_Attack_Phase
    @Condition Wave_Prep_Time_Left <= 0
    @Condition getNumberOfLivingPlayers(Team.1) >= zombieWaveQuotaNow()

    Current_Wave++
    Wave_Attack_Time_Left = Wave_Attack_Duration
    Wave_Prep_Time_Left = 0
    Is_Attack_Phase = true


rule "Players - Round Attack Start":
    @Condition isGameInProgress()
    @Condition Current_Wave <= Total_Wave_Count
    @Condition Is_Attack_Phase

    getPlayers(Team.1).clearStatusEffect(Status.INVINCIBLE)
    bigMessage(getAllPlayers(), "第 {0} 波进攻".format(Current_Wave))
    chaseOverTime(Wave_Attack_Time_Left, 0, Wave_Attack_Duration, ChaseTimeReeval.NONE)


rule "Players - Round Attack End":
    @Condition isGameInProgress()
    @Condition Current_Wave < Total_Wave_Count
    @Condition Is_Attack_Phase

    # 铃响只由倒计时决定。超时是防卡死的兜底, 取两倍时长, 不能在倒计时还剩一段时就关复活。
    waitUntil(Wave_Attack_Time_Left <= 0, Wave_Attack_Duration * 2)
    Wave_Attack_Time_Left = 0
    # 铃响后停止补位: 额度没放完也不再放, 把残余僵尸交给玩家清场收尾。
    getPlayers(Team.1).disableRespawn()
    # 安全阀: 清不掉(卡住/无敌残留)也必须能进下一波, 否则整局卡死在这一波。
    waitUntil(getNumberOfLivingPlayers(Team.1) == 0, 30)
    destroyAllDummies()
    # 先结算已持有四项科技的玩家, 再开放本波的新科技机会。
    getPlayers(Team.2).filter(lambda player: not player.isDummy() and len(player.Owned_Tech_Ids) == MAX_TECH_COUNT).Pending_Stat_Upgrade_Count += 1
    Finished_Wave_Count = Current_Wave
    Is_Attack_Phase = false
    Wave_Prep_Time_Left = Wave_Prep_Duration


# 最后一波没有「进攻结束」规则, 铃响后必须在这里停掉补位:
# 额度没放完的僵尸会一直按 3~5 秒复活, Barrier - Win 的「存活数量 == 0」就永远不成立。
rule "Players - Final Wave Stop Respawn":
    @Condition isGameInProgress()
    @Condition Is_Attack_Phase
    @Condition Current_Wave == Total_Wave_Count
    @Condition Wave_Attack_Time_Left == 0
    @Condition getNumberOfLivingPlayers(Team.1) > 0

    getPlayers(Team.1).disableRespawn()
