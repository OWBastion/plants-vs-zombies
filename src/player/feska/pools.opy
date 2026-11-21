#!mainFile "../../main.opy"

# 共用临时生命池表。调用前必须先把目标玩家赋给全局 Target_Player;
# 入参用 Temp_Pool_Tag / Temp_Pool_Amount / Temp_Pool_Expire 传递(OverPy 子程序没有参数)。
#
# 一条记录 = 一个池。整池重建型来源(光子护盾/血肉再生/反应装甲)先按标签清旧记录再加;
# 叠加型来源(坚定每层、痛苦疗愈每次受击)直接追加, 由 "Feska - Temp pool expiry" 逐条移除。
#
# 旧实现有两处错误, 都出在子程序本身, 不是"参数走全局变量"这件事不可用:
#
# 1. Health Type 被变量化。Add Health Pool 的 Health Type 是枚举常量槽, 不接受变量:
#      为玩家添加生命池(全局.Target_Player, 全局.Temp_Pool_Type, 全局.Temp_Pool_Amount, 真, 假)
#    编译能过(OverPy 只校验它是数字), 生成的动作在游戏里类型槽是空的, 池加不上并连带规则卡住。
#    数量一直走全局变量却正常——内联版在同一参数位放的就是 ceil(...) 表达式, 位置本身受表达式。
#    现在按标签分派, 每种类型写字面量; 新增标签必须在 feskaAddTempPool 里补一支。
#
# 2. 循环变量重复使用。子程序内部原来用全局 Loop_Index 遍历池表, 而它的调用方
#    (feskaRefreshShields、离场清理)本身也在用 Loop_Index 遍历玩家, 子程序一进循环就把
#    外层的计数改掉, 外层只剩第一个玩家被处理, 后续玩家漏处理甚至越界。
#    池表子程序因此改用自己的 Pool_Index, 与业务循环彻底分开。

#!define feskaTempPoolCount(p, tag) len(p.Temp_Pool_Ids.filter(lambda value: value == tag))


def feskaAddTempPool():
    @Name "Feska - add temp pool"

    # 先判存活: addHealthPool 对死亡玩家无效, 记下来的会是空句柄, 到期移除时才炸。
    if Target_Player.isAlive():
        # 类型必须内联。每个分支只负责建池, 记账统一放在后面。
        if Temp_Pool_Tag == Temp_Pool_Id.SHIELD:
            Target_Player.addHealthPool(Health.SHIELDS, Temp_Pool_Amount, true, false)
        elif Temp_Pool_Tag == Temp_Pool_Id.FLESH_REGENERATION:
            Target_Player.addHealthPool(Health.NORMAL, Temp_Pool_Amount, true, false)
        elif Temp_Pool_Tag == Temp_Pool_Id.REACTIVE:
            Target_Player.addHealthPool(Health.ARMOR, Temp_Pool_Amount, true, false)
        elif Temp_Pool_Tag == Temp_Pool_Id.STEADFAST:
            Target_Player.addHealthPool(Health.ARMOR, Temp_Pool_Amount, true, false)
        elif Temp_Pool_Tag == Temp_Pool_Id.PAINFUL_HEALING:
            Target_Player.addHealthPool(Health.NORMAL, Temp_Pool_Amount, true, false)
        # 上面必须覆盖全部标签。漏配时 getLastCreatedHealthPool() 会拿到上一个池,
        # 记录与实际池不对应, 到期时会误删别的来源。
        Target_Player.Temp_Pool_Ids.append(Temp_Pool_Tag)
        Target_Player.Temp_Pool_Handles.append(getLastCreatedHealthPool())
        Target_Player.Temp_Pool_Expire_At.append(Temp_Pool_Expire)


def feskaClearTempPoolsByTag():
    @Name "Feska - clear temp pools by tag"

    # 入参: Target_Player + Temp_Pool_Tag。
    # 数组操作返回副本, 三张表必须同时重组后整体赋回, 否则下标会错位。
    # 未初始化玩家的数组字段还是默认值 0, len(0) 会让整条规则中断, 先按 Is_Initialized 挡住。
    if Target_Player.Is_Initialized:
        Temp_Pool_Keep_Ids = []
        Temp_Pool_Keep_Handles = []
        Temp_Pool_Keep_Expire = []
        for Pool_Index in range(len(Target_Player.Temp_Pool_Handles)):
            if Target_Player.Temp_Pool_Ids[Pool_Index] == Temp_Pool_Tag:
                removeHealthPool(Target_Player.Temp_Pool_Handles[Pool_Index])
            else:
                Temp_Pool_Keep_Ids.append(Target_Player.Temp_Pool_Ids[Pool_Index])
                Temp_Pool_Keep_Handles.append(Target_Player.Temp_Pool_Handles[Pool_Index])
                Temp_Pool_Keep_Expire.append(Target_Player.Temp_Pool_Expire_At[Pool_Index])
        Target_Player.Temp_Pool_Ids = Temp_Pool_Keep_Ids
        Target_Player.Temp_Pool_Handles = Temp_Pool_Keep_Handles
        Target_Player.Temp_Pool_Expire_At = Temp_Pool_Keep_Expire


def feskaClearAllTempPools():
    @Name "Feska - clear all temp pools"

    # 重生与换英雄用: 临时池不跨命保留, 科技本身仍留在 Owned_Tech_Ids 里。
    if Target_Player.Is_Initialized:
        for Pool_Index in range(len(Target_Player.Temp_Pool_Handles)):
            removeHealthPool(Target_Player.Temp_Pool_Handles[Pool_Index])
        Target_Player.Temp_Pool_Ids = []
        Target_Player.Temp_Pool_Handles = []
        Target_Player.Temp_Pool_Expire_At = []


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
        # 整池重建: 先按标签清掉旧记录, 再按当前波次与持有者最大生命建新池, 不设到期时间。
        Temp_Pool_Tag = Temp_Pool_Id.SHIELD
        feskaClearTempPoolsByTag()
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
    # 这里用规则自己的 Loop_Index 而不是 Pool_Index: 本规则不调用池表子程序, 不会互相干扰。
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
