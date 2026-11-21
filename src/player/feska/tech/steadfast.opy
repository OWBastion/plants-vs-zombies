#!mainFile "../../../main.opy"

# 坚定: 每次受击叠一层临时护甲, 每层独立 5 秒, 最多 5 层。
# **暂时停用(enabled=0), 规则体未实现**。
# 原实现依赖已撤除的共用临时池表(feskaAddTempPool), 该写法在游戏内报错/卡住。
# 重做时的关键约束: 每层必须单独建池并单独到期——整池重建会把已经吸收掉的护甲补回来。
# 恢复路径: 用本科技自己的句柄数组记录每层(直接 addHealthPool, 类型与数量内联, 不走全局变量),
# 再配一条按层到期的规则; 完成后把目录行第 5 列改回 1。
#!define FESKA_STEADFAST_MAX_STACKS 5
#!define FESKA_STEADFAST_SECONDS 5
#!define UPGRADE_ROW_STEADFAST ["坚定", "受到伤害时获得 12% 最大生命值的临时护甲\n最多 5 层，每层独立持续 5 秒", UPGRADE_KIND_TECH, 0, 0, 0, 0, 0, abilityIconString(Hero.BRIGITTE, Button.PRIMARY_FIRE), []]
