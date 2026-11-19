#!mainFile "../../main.opy"

# 费斯卡生命池应用子程序: 只负责按当前累计状态重建本模式的生命池, 供科技文件与生命周期流程调用。
# 在 main.opy 中先于 player/progression.opy 引入, 这样各科技与 progression 都能直接调用。
# 调用前必须先把目标玩家赋给全局 Feska_P; 子程序自己清理旧池, 重复调用不会叠层。


def feskaApplyArmorPool():
    @Name "Feska - apply armor pool"

    # 子程序里的 return 会结束整个调用规则, 因此这里只用条件包裹。
    if Feska_P.feska_armor_count > 0:
        if Feska_P.feska_armor_pool != null:
            removeHealthPool(Feska_P.feska_armor_pool)
        Feska_P.addHealthPool(Health.ARMOR, 25 * Feska_P.feska_armor_count, true, false)
        Feska_P.feska_armor_pool = getLastCreatedHealthPool()


def feskaApplyHeartsteelPool():
    @Name "Feska - apply heartsteel pool"

    if Feska_P.feska_heartsteel_flat > 0:
        if Feska_P.feska_heartsteel_pool != null:
            removeHealthPool(Feska_P.feska_heartsteel_pool)
        Feska_P.addHealthPool(Health.NORMAL, Feska_P.feska_heartsteel_flat, true, false)
        Feska_P.feska_heartsteel_pool = getLastCreatedHealthPool()


def feskaApplyShieldToPlayer():
    @Name "Feska - apply photon shield"

    if Feska_Shield_Holder != null and Feska_P.isAlive():
        if Feska_P.feska_shield_pool != null:
            removeHealthPool(Feska_P.feska_shield_pool)
        Feska_P.addHealthPool(Health.SHIELDS, ceil(feskaGrowthPool() + feskaMaxHP(Feska_Shield_Holder) * 0.15), true, false)
        Feska_P.feska_shield_pool = getLastCreatedHealthPool()


def feskaApplyReactivePool():
    @Name "Feska - apply reactive armor"

    # 护甲量按当前可计入最大生命结算; 池自身不计入 feskaMaxHP, 重新应用不会自我放大。
    # 每次调用都整池重建, 击穿后的残余不保留。
    if T_REACTIVE in Feska_P.feska_tech and Feska_P.isAlive():
        if Feska_P.feska_reactive_pool != null:
            removeHealthPool(Feska_P.feska_reactive_pool)
        Feska_P.addHealthPool(Health.ARMOR, feskaReactiveArmor(Feska_P), true, false)
        Feska_P.feska_reactive_pool = getLastCreatedHealthPool()
