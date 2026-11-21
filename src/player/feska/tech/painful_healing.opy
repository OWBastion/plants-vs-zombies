#!mainFile "../../../main.opy"

# 痛苦疗愈: 受到伤害的 12% 转为临时生命, 8 秒后连同未消耗的部分一起移除。
# **暂时停用(enabled=0), 规则体未实现**。共用临时池表已重做可用(见 pools.opy), 缺的只是这里的规则体。
# 实现时的关键约束: 每次受击各建一条记录, 同时存在的记录数要封顶, 避免高攻速受击把
# 玩家身上的生命池数量堆到不可控; 多条小池与一条大池的收益差别可以忽略。
# 做法: Temp_Pool_Tag = Temp_Pool_Id.PAINFUL_HEALING、Temp_Pool_Amount = 伤害 × 12%、
# Temp_Pool_Expire = getTotalTimeElapsed() + 8, 调 feskaAddTempPool(); 记录数用
# feskaTempPoolCount(eventPlayer, Temp_Pool_Id.PAINFUL_HEALING) 判断, 到上限就不再追加。
# 完成后把目录行第 5 列改回 1。
#!define FESKA_PAINFUL_SHARE 0.12
#!define FESKA_PAINFUL_SECONDS 8
#!define FESKA_PAINFUL_MAX_POOLS 8
#!define UPGRADE_ROW_PAINFUL_HEALING ["痛苦疗愈", "受到伤害的 12% 转换为临时生命值，持续 8 秒", UPGRADE_KIND_TECH, 0, 0, 0, 0, 0, abilityIconString(Hero.MOIRA, Button.SECONDARY_FIRE), []]
