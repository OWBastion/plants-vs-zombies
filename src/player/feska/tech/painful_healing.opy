#!mainFile "../../../main.opy"

# 痛苦疗愈: 受到伤害的 12% 转为临时生命, 8 秒后连同未消耗的部分一起移除。
# **暂时停用(enabled=0), 规则体未实现**。
# 原实现依赖已撤除的共用临时池表(feskaAddTempPool), 该写法在游戏内报错/卡住。
# 重做时的关键约束: 每次受击各建一条记录, 同时存在的记录数要封顶, 避免高攻速受击把
# 玩家身上的生命池数量堆到不可控; 多条小池与一条大池的收益差别可以忽略。
# 恢复路径: 用本科技自己的句柄数组 + 到期时间数组, 直接 addHealthPool(类型与数量内联);
# 完成后把目录行第 5 列改回 1。
#!define FESKA_PAINFUL_SHARE 0.12
#!define FESKA_PAINFUL_SECONDS 8
#!define FESKA_PAINFUL_MAX_POOLS 8
#!define UPGRADE_ROW_PAINFUL_HEALING ["痛苦疗愈", "受到伤害的 12% 转换为临时生命值，持续 8 秒", UPGRADE_KIND_TECH, 0, 0, 0, 0, 0, abilityIconString(Hero.MOIRA, Button.SECONDARY_FIRE), []]
