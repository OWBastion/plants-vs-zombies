#!mainFile "../../main.opy"

# 调用前必须先把目标玩家赋给全局 Target_Player; 子程序自己清理旧池, 重复调用不会叠层。
# 每个生命池由所属科技各持一个句柄字段, 不用共用表:
#   护甲强化 Armor_Health_Pool / 心之钢 Heartsteel_Health_Pool / 光子护盾 Shield_Health_Pool /
#   血肉再生 Regeneration_Health_Pool / 反应装甲 Reactive_Armor_Health_Pool。
# 曾尝试的共用池表(addHealthPool 的类型与数量走全局变量)在游戏内报错/卡住, 已整体撤除。


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
        # 整池重建: 先移除旧池, 再按当前波次与持有者最大生命建新池。
        if Target_Player.Shield_Health_Pool != null:
            removeHealthPool(Target_Player.Shield_Health_Pool)
        Target_Player.addHealthPool(Health.SHIELDS, ceil(feskaPoolGrowthValue() + feskaMaxHealth(shieldTechHolders()[0]) * 0.15), true, false)
        Target_Player.Shield_Health_Pool = getLastCreatedHealthPool()


def feskaApplyReactivePool():
    @Name "Feska - apply reactive armor"

    # 护甲量按当前可计入最大生命结算; 池自身不计入 feskaMaxHealth, 重新应用不会自我放大。
    # 每次调用都整池重建, 击穿后的残余不保留。
    if Tech_Id.REACTIVE in Target_Player.Owned_Tech_Ids and Target_Player.isAlive():
        if Target_Player.Reactive_Armor_Health_Pool != null:
            removeHealthPool(Target_Player.Reactive_Armor_Health_Pool)
        Target_Player.addHealthPool(Health.ARMOR, feskaReactiveArmor(Target_Player), true, false)
        Target_Player.Reactive_Armor_Health_Pool = getLastCreatedHealthPool()
