#!mainFile "../../main.opy"

# 调用前必须先把目标玩家赋给全局 Target_Player; 子程序自己清理旧池, 重复调用不会叠层。


def feskaApplyArmorPool():
    @Name "Feska - apply armor pool"

    # 子程序里的 return 会结束整个调用规则, 因此这里只用条件包裹。
    if Target_Player.armor_count > 0:
        if Target_Player.armor_pool != null:
            removeHealthPool(Target_Player.armor_pool)
        Target_Player.addHealthPool(Health.ARMOR, 25 * Target_Player.armor_count, true, false)
        Target_Player.armor_pool = getLastCreatedHealthPool()


def feskaApplyHeartsteelPool():
    @Name "Feska - apply heartsteel pool"

    if Target_Player.heartsteel_flat > 0:
        if Target_Player.heartsteel_pool != null:
            removeHealthPool(Target_Player.heartsteel_pool)
        Target_Player.addHealthPool(Health.NORMAL, Target_Player.heartsteel_flat, true, false)
        Target_Player.heartsteel_pool = getLastCreatedHealthPool()


def feskaApplyShieldToPlayer():
    @Name "Feska - apply photon shield"

    if Shield_Holder != null and Target_Player.isAlive():
        if Target_Player.shield_pool != null:
            removeHealthPool(Target_Player.shield_pool)
        Target_Player.addHealthPool(Health.SHIELDS, ceil(feskaGrowthPool() + feskaMaxHP(Shield_Holder) * 0.15), true, false)
        Target_Player.shield_pool = getLastCreatedHealthPool()


def feskaApplyReactivePool():
    @Name "Feska - apply reactive armor"

    # 护甲量按当前可计入最大生命结算; 池自身不计入 feskaMaxHP, 重新应用不会自我放大。
    # 每次调用都整池重建, 击穿后的残余不保留。
    if TechId.REACTIVE in Target_Player.tech and Target_Player.isAlive():
        if Target_Player.reactive_pool != null:
            removeHealthPool(Target_Player.reactive_pool)
        Target_Player.addHealthPool(Health.ARMOR, feskaReactiveArmor(Target_Player), true, false)
        Target_Player.reactive_pool = getLastCreatedHealthPool()
