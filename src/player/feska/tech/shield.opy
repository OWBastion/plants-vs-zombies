#!mainFile "../../../main.opy"

playervar shield_pool 50

#!define shieldHolders() getPlayers(Team.2).filter(lambda player: not player.isDummy() and TechId.SHIELD in player.tech)

#!define UPGRADE_ROW_SHIELD ["费斯卡光子护盾", "全体玩家获得可恢复护盾\n数值为成长固定值 + 持有者最大生命值的 15%", 1, 1, 1, 0, 0, 0]
