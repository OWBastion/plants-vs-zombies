#!mainFile "../../main.opy"

# 调用前必须先把目标玩家赋给全局 Target_Player; 子程序自己清理旧池, 重复调用不会叠层。

# 共用临时生命池表(字段见 vars.opy): 三张平行数组 + 三个基本操作。
# register: 追加一条记录, 到期由 "Feska - Temp pool expiry" 移除。
# refresh : 先按标签清掉同源旧记录再加, 用于光子护盾、血肉再生、反应装甲这类整池重建。
# 到期时间 0 表示不按时间到期, 只由来源自己刷新。

#!define feskaTempPoolCount(p, tag) len(p.Temp_Pool_Ids.filter(lambda value: value == tag))


def feskaClearTempPoolsByTag():
    @Name "Feska - clear temp pools by tag"

    # 入参: Target_Player + Temp_Pool_Tag。
    # 数组操作返回副本, 三张表必须同时重组后整体赋回, 否则下标会错位。
    # 未初始化玩家的数组字段还是默认值 0, len(0) 会让整条规则中断, 先按 Is_Initialized 挡住。
    if Target_Player.Is_Initialized:
        Temp_Pool_Keep_Ids = []
        Temp_Pool_Keep_Handles = []
        Temp_Pool_Keep_Expire = []
        for Loop_Index in range(len(Target_Player.Temp_Pool_Handles)):
            if Target_Player.Temp_Pool_Ids[Loop_Index] == Temp_Pool_Tag:
                removeHealthPool(Target_Player.Temp_Pool_Handles[Loop_Index])
            else:
                Temp_Pool_Keep_Ids.append(Target_Player.Temp_Pool_Ids[Loop_Index])
                Temp_Pool_Keep_Handles.append(Target_Player.Temp_Pool_Handles[Loop_Index])
                Temp_Pool_Keep_Expire.append(Target_Player.Temp_Pool_Expire_At[Loop_Index])
        Target_Player.Temp_Pool_Ids = Temp_Pool_Keep_Ids
        Target_Player.Temp_Pool_Handles = Temp_Pool_Keep_Handles
        Target_Player.Temp_Pool_Expire_At = Temp_Pool_Keep_Expire


def feskaClearAllTempPools():
    @Name "Feska - clear all temp pools"

    # 重生与换英雄用: 临时池不跨命保留, 科技本身仍留在 Owned_Tech_Ids 里。
    if Target_Player.Is_Initialized:
        for Loop_Index in range(len(Target_Player.Temp_Pool_Handles)):
            removeHealthPool(Target_Player.Temp_Pool_Handles[Loop_Index])
        Target_Player.Temp_Pool_Ids = []
        Target_Player.Temp_Pool_Handles = []
        Target_Player.Temp_Pool_Expire_At = []


def feskaAddTempPool():
    @Name "Feska - add temp pool"

    # 入参: Target_Player + Temp_Pool_Tag / Type / Amount / Expire。
    if Target_Player.isAlive():
        Target_Player.addHealthPool(Temp_Pool_Type, Temp_Pool_Amount, true, false)
        Target_Player.Temp_Pool_Ids.append(Temp_Pool_Tag)
        Target_Player.Temp_Pool_Handles.append(getLastCreatedHealthPool())
        Target_Player.Temp_Pool_Expire_At.append(Temp_Pool_Expire)


def feskaApplyArmorPool():
    @Name "Feska - apply armor pool"

    # 子程序里的 return 会结束整个调用规则, 因此这里只用条件包裹。
    if Target_Player.Bonus_By_Stat[Stat_Bonus.ARMOR] > 0:
        if Target_Player.Armor_Health_Pool != null:
            removeHealthPool(Target_Player.Armor_Health_Pool)
        Target_Player.addHealthPool(Health.ARMOR, 25 * Target_Player.Bonus_By_Stat[Stat_Bonus.ARMOR], true, false)
        Target_Player.Armor_Health_Pool = getLastCreatedHealthPool()


def feskaApplyHeartsteelPool():
    @Name "Feska - apply heartsteel pool"

    if Target_Player.Heartsteel_Flat_Health > 0:
        if Target_Player.Heartsteel_Health_Pool != null:
            removeHealthPool(Target_Player.Heartsteel_Health_Pool)
        Target_Player.addHealthPool(Health.NORMAL, Target_Player.Heartsteel_Flat_Health, true, false)
        Target_Player.Heartsteel_Health_Pool = getLastCreatedHealthPool()


def feskaApplyShieldToPlayer():
    @Name "Feska - apply photon shield"

    if len(shieldTechHolders()) > 0 and Target_Player.isAlive():
        Temp_Pool_Tag = Temp_Pool_Id.SHIELD
        feskaClearTempPoolsByTag()
        Temp_Pool_Type = Health.SHIELDS
        Temp_Pool_Amount = ceil(feskaPoolGrowthValue() + feskaMaxHealth(shieldTechHolders()[0]) * 0.15)
        Temp_Pool_Expire = 0
        feskaAddTempPool()


def feskaApplyReactivePool():
    @Name "Feska - apply reactive armor"

    # 护甲量按当前可计入最大生命结算; 池自身不计入 feskaMaxHealth, 重新应用不会自我放大。
    # 每次调用都整池重建, 击穿后的残余不保留。
    if Tech_Id.REACTIVE in Target_Player.Owned_Tech_Ids and Target_Player.isAlive():
        Temp_Pool_Tag = Temp_Pool_Id.REACTIVE
        feskaClearTempPoolsByTag()
        Temp_Pool_Type = Health.ARMOR
        Temp_Pool_Amount = feskaReactiveArmor(Target_Player)
        Temp_Pool_Expire = 0
        feskaAddTempPool()


rule "Feska - Temp pool expiry":
    @Event eachPlayer
    @Team 2
    @Condition isGameInProgress()
    # 先判初始化: 未初始化玩家的数组字段还是 0, 不能直接 len()。
    @Condition eventPlayer.Is_Initialized
    @Condition len(eventPlayer.Temp_Pool_Handles) > 0

    # 只处理按时间到期的记录(Expire > 0); 0 表示由来源自己刷新。
    Target_Player = eventPlayer
    Temp_Pool_Keep_Ids = []
    Temp_Pool_Keep_Handles = []
    Temp_Pool_Keep_Expire = []
    for Loop_Index in range(len(eventPlayer.Temp_Pool_Handles)):
        if eventPlayer.Temp_Pool_Expire_At[Loop_Index] > 0 and eventPlayer.Temp_Pool_Expire_At[Loop_Index] <= getTotalTimeElapsed():
            removeHealthPool(eventPlayer.Temp_Pool_Handles[Loop_Index])
        else:
            Temp_Pool_Keep_Ids.append(eventPlayer.Temp_Pool_Ids[Loop_Index])
            Temp_Pool_Keep_Handles.append(eventPlayer.Temp_Pool_Handles[Loop_Index])
            Temp_Pool_Keep_Expire.append(eventPlayer.Temp_Pool_Expire_At[Loop_Index])
    eventPlayer.Temp_Pool_Ids = Temp_Pool_Keep_Ids
    eventPlayer.Temp_Pool_Handles = Temp_Pool_Keep_Handles
    eventPlayer.Temp_Pool_Expire_At = Temp_Pool_Keep_Expire
    wait(0.25, Wait.ABORT_WHEN_FALSE)
    if ruleCondition:
        loop()
