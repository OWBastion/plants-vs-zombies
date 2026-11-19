#!mainFile "../../../main.opy"

# 玻璃大炮 (T_CANNON = 7)
# 纯数值科技: 数值取自目录行, 获得时在本文件累加, 属性写入器仍只有 progression.opy 一处。
#!define FESKA_ROW_CANNON ["玻璃大炮", "造成的伤害 +55%\n最大生命值 -20%", 1, 0, 1, 55, -20, 0]

rule "Feska - Glass cannon":
    @Event eachPlayer
    @Team 2
    # 条件由假变真即"获得科技"; 科技不移除, 条件不再变化, 所以只结算一次。
    @Condition T_CANNON in eventPlayer.feska_tech

    # 两列都累加完再写入, 避免中间值被 setMaxHealth 采用。
    eventPlayer.feska_bonus[0] += Feska_Upgrades[T_CANNON][FESKA_COL_DAMAGE]
    eventPlayer.feska_bonus[1] += Feska_Upgrades[T_CANNON][FESKA_COL_HEALTH]
    Feska_P = eventPlayer
    feskaApplyUpgradeStats()
