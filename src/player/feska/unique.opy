#!mainFile "../../main.opy"

# 全局唯一科技: 全队只能有一名持有者。目前是光子护盾与佛法自然。
# 唯一性判定不过滤存活(死亡不丢科技, 否则持有者死一次别人就能抢同一张卡);
# 只有"生效"才按存活过滤, 例如佛法自然的光环中心。
# 注意: 本版本的 def 不支持带返回值的 return, 需要取值的地方用全局量或宏, 不要写成子程序。

#!define feskaDharmaHolders() getPlayers(Team.2).filter(lambda player: not player.isDummy() and Tech_Id.DHARMA in player.Owned_Tech_Ids)
#!define feskaAliveDharmaHolders() feskaDharmaHolders().filter(lambda player: player.isAlive())
# 这张唯一卡已被别人拿走。写成布尔宏而不是"已占用数组": 空数组字面量的类型推断不可靠,
# 会在 arrayContains 处报 Number|Vector。
#!define feskaUniqueTechTaken(upgrade) ((upgrade == Tech_Id.SHIELD and len(shieldTechHolders()) > 0) or (upgrade == Tech_Id.DHARMA and len(feskaDharmaHolders()) > 0))
