#!mainFile "../../../main.opy"

#!define shieldTechHolders() getPlayers(Team.2).filter(lambda player: not player.isDummy() and Tech_Id.SHIELD in player.Owned_Tech_Ids)

#!define UPGRADE_ROW_SHIELD ["费斯卡光子护盾", "全体队友获得可恢复护盾：50～250 点（随波次递增）+ 持有者最大生命值 × 15%", UPGRADE_KIND_TECH, 1, 1, 0, 0, 0, abilityIconString(Hero.SYMMETRA, Button.ULTIMATE), []]
