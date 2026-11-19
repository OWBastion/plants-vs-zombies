#!mainFile "../../../main.opy"

#!define UPGRADE_ROW_CANNON ["玻璃大炮", "造成的伤害 +55%\n最大生命值 -20%", 1, 0, 1, 55, -20, 0]

rule "Feska - Glass cannon":
    @Event eachPlayer
    @Team 2
    @Condition TechId.CANNON in eventPlayer.tech

    # 两列都累加完再写入, 避免中间值被 setMaxHealth 采用。
    eventPlayer.bonus[FeskaBonus.DAMAGE] += Upgrades[TechId.CANNON][UPGRADE_COL_DAMAGE]
    eventPlayer.bonus[FeskaBonus.HEALTH] += Upgrades[TechId.CANNON][UPGRADE_COL_HEALTH]
    feskaApplyUpgradeStats()
