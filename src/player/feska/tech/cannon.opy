#!mainFile "../../../main.opy"

#!define FESKA_ROW_CANNON ["玻璃大炮", "造成的伤害 +55%\n最大生命值 -20%", 1, 0, 1, 55, -20, 0]

rule "Feska - Glass cannon":
    @Event eachPlayer
    @Team 2
    @Condition T_CANNON in eventPlayer.feska_tech

    # 两列都累加完再写入, 避免中间值被 setMaxHealth 采用。
    eventPlayer.feska_bonus[0] += Feska_Upgrades[T_CANNON][FESKA_COL_DAMAGE]
    eventPlayer.feska_bonus[1] += Feska_Upgrades[T_CANNON][FESKA_COL_HEALTH]
    feskaApplyUpgradeStats()
