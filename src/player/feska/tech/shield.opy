#!mainFile "../../../main.opy"

playervar Shield_Health_Pool

#!define shieldTechHolders() getPlayers(Team.2).filter(lambda player: not player.isDummy() and Tech_Id.SHIELD in player.Owned_Tech_Ids)

#!define UPGRADE_ROW_SHIELD ["费斯卡光子护盾", "全体玩家获得可恢复护盾\n数值为成长固定值 + 持有者最大生命值的 15%", UPGRADE_KIND_TECH, 1, 1, 0, 0, 0, abilityIconString(Hero.SYMMETRA, Button.ULTIMATE), []]
