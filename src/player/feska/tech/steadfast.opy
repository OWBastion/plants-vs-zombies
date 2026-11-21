#!mainFile "../../../main.opy"

# 坚定: 每次受击叠一层临时护甲, 每层独立 5 秒, 最多 5 层。
# **暂时停用(enabled=0), 规则体未实现**。共用临时池表已重做可用(见 pools.opy), 缺的只是这里的规则体。
# 实现时的关键约束: 每层必须单独建池并单独到期——整池重建会把已经吸收掉的护甲补回来。
# 做法: 受击时 Temp_Pool_Tag = Temp_Pool_Id.STEADFAST、Temp_Pool_Amount = 12% 最大生命、
# Temp_Pool_Expire = getTotalTimeElapsed() + 5, 调 feskaAddTempPool(); 层数上限靠同标签记录数判断,
# 到第 6 层时先按标签清一条最早记录(或直接跳过), 到期由 "Feska - Temp pool expiry" 逐条移除。
# 完成后把目录行第 5 列改回 1。
#!define FESKA_STEADFAST_MAX_STACKS 5
#!define FESKA_STEADFAST_SECONDS 5
#!define UPGRADE_ROW_STEADFAST ["坚定", "受到伤害时获得 12% 最大生命值的临时护甲\n最多 5 层，每层独立持续 5 秒", UPGRADE_KIND_TECH, 0, 0, 0, 0, 0, abilityIconString(Hero.BRIGITTE, Button.PRIMARY_FIRE), []]
