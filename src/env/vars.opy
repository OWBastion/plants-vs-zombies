#!mainFile "../main.opy"

globalvar Zombie_Spawn_Positions
# 脑子位置。用数组只为表达"该地图未配置"的空状态, 引用处只取 [0]。
globalvar Brain_Positions
globalvar Current_Wave
globalvar Total_Wave_Count
globalvar Wave_Attack_Duration
globalvar Wave_Prep_Duration
globalvar Debug_Enabled
globalvar Is_Attack_Phase
globalvar Difficulty_Level
globalvar Wave_Attack_Time_Left
globalvar Wave_Prep_Time_Left
globalvar Zombie_Alive_Limit
globalvar Zombie_Hero_Pool
globalvar Tank_Hero_Pool
globalvar Damage_Hero_Pool
globalvar Support_Hero_Pool
globalvar Hero_Pool_Size_By_Role
globalvar Finished_Wave_Count
globalvar Upgrade_Catalog
globalvar Tech_Catalog_Indexes
globalvar Stat_Catalog_Indexes
# 子程序当前操作的玩家与循环下标。OverPy 子程序不支持参数, 用同步临时变量传递。
globalvar Target_Player
globalvar Loop_Index
# OverPy 只允许单字母的隐式临时变量。需要具名的临时工作值只能显式声明。
globalvar Player_List
globalvar Ready_Ability_Buttons
globalvar Reroll_Candidates
globalvar Blocked_Player_Names

# 目录每行的列下标。3 为唯一性标志(仅光子护盾为 1, 判定仍按 Tech_Id), 8 图标, 9 英雄池。
#!define UPGRADE_COLUMN_NAME 0
#!define UPGRADE_COLUMN_DESCRIPTION 1
#!define UPGRADE_COLUMN_KIND 2
#!define UPGRADE_COLUMN_ENABLED 4
#!define UPGRADE_COLUMN_DAMAGE 5
#!define UPGRADE_COLUMN_HEALTH 6
#!define UPGRADE_COLUMN_HEALING 7
# 仅科技行有图标列; 属性强化行填 0。
#!define UPGRADE_COLUMN_ICON 8
# 技能强化的适配英雄池, 只有 UPGRADE_KIND_SKILL 行有内容, 其他行填空数组。
#!define UPGRADE_COLUMN_HERO_POOL 9

#!define UPGRADE_KIND_TECH 1
#!define UPGRADE_KIND_STAT 2
# 技能强化占用科技槽位与选择节奏, 但只对第 10 列英雄池里的英雄入池。
#!define UPGRADE_KIND_SKILL 3
#!define MAX_TECH_COUNT 4

# 属性强化的累加槽位, 下标即 Bonus_By_Stat[Stat_Bonus.*]。
enum Stat_Bonus:
    DAMAGE = 0
    HEALTH
    HEALING
    ARMOR
    DAMAGE_REDUCTION
    REGENERATION
    HEALING_RECEIVED
    ULTIMATE_CHARGE
    KNOCKBACK_RESISTANCE

# 选牌界面当前展示哪一类候选。
enum Choice_Kind:
    NONE = 0
    TECH
    STAT_UPGRADE

# 科技在 Upgrade_Catalog 中的行号。数值是历史索引, 不可重排。
enum Tech_Id:
    BRUTAL = 0
    GIANT = 1
    HEALING = 2
    SELF_REPAIR = 3
    LIFESTEAL = 4
    THORNS = 5
    PRESSURE_COOKER = 6
    GLASS_CANNON = 7
    SOUL_PURGE = 14
    ICE = 15
    NO_ULTIMATE = 16
    DRAW_SWORD = 17
    SNIPER = 18
    FREEZE_ALL = 19
    ABILITY_REFRESH = 20
    HEARTSTEEL = 21
    SHIELD = 22
    FLESH_REGENERATION = 23
    HEALING_TOWER = 24
    VICTORY_WILL = 25
    ULTIMATE_CHARGE = 26
    LONE_WOLF = 27
    FIRST_AID_KIT = 34
    RADIANT = 35
    CRUSADER = 36
    REACTIVE = 37
    BERSERK = 38
    IGNITE = 39
    CRIT = 40
    ULTIMATE_LOOP = 41
    EXECUTE = 42

# 属性强化在 Upgrade_Catalog 中的行号。数值是历史索引, 不可重排。
enum Stat_Upgrade_Id:
    DAMAGE = 8
    HEALTH = 9
    HEALING = 10
    BALANCED = 11
    RESONANCE = 12
    NOURISHMENT = 13
    ARMOR = 28
    DAMAGE_REDUCTION = 29
    REGENERATION = 30
    HEALING_RECEIVED = 31
    ULTIMATE_CHARGE = 32
    KNOCKBACK_RESISTANCE = 33

#!define feskaGrowthAt(progress, base, span) round(base + span * progress)
#!define feskaProgressRatio() min(max((Current_Wave - 1) / max(Total_Wave_Count - 1, 1), 0), 1)
# 预览成长按实际结算波次: 进攻阶段用当前波, 准备阶段用即将进攻的下一波, 避免显示与结算错一波。
#!define feskaPreviewProgress() min(max(((Current_Wave if Is_Attack_Phase else Finished_Wave_Count + 1) - 1) / max(Total_Wave_Count - 1, 1), 0), 1)
#!define feskaGrowthHeartsteel() feskaGrowthAt(feskaProgressRatio(), 1, 24)
#!define feskaPoolGrowthValue() feskaGrowthAt(feskaProgressRatio(), 50, 200)

# setMaxHealth 只接受百分比(相对英雄原始最大生命)。可计入最大生命值是绝对点数:
# 英雄原始最大生命×(100+生命加成)% + 心之钢永久增量 + 护甲强化。
# 光子护盾/血肉/反应装甲等本来源生命池不计入, 防止百分比效果把自己新增的生命值再次计入。
# Base_Max_Health 在初始化与换英雄时读取工坊实际属性, 不维护英雄基础属性表。
#!define feskaHealthPercent(p) (100 + p.Bonus_By_Stat[Stat_Bonus.HEALTH])
#!define feskaMaxHealth(p) (p.Base_Max_Health * (100 + p.Bonus_By_Stat[Stat_Bonus.HEALTH]) / 100 + p.Heartsteel_Flat_Health + 25 * p.Bonus_By_Stat[Stat_Bonus.ARMOR])
#!define feskaReactiveArmor(p) ceil(100 + feskaMaxHealth(p) * 0.1)
# 狂战士之魂: 总生命上限变为可计入最大生命值的 21 倍(2000% 额外 + 100% 基础)。
# setMaxHealth 按英雄原始最大生命的百分比设置且生命池另行叠加, 因此百分比里含生命池的 20 倍补偿。
#!define feskaBerserkPercent(p) (2100 + 21 * p.Bonus_By_Stat[Stat_Bonus.HEALTH] + 2000 * (p.Heartsteel_Flat_Health + 25 * p.Bonus_By_Stat[Stat_Bonus.ARMOR]) / p.Base_Max_Health)
#!define feskaBerserkMaxHealth(p) (21 * feskaMaxHealth(p))
#!define feskaDamagePercent(p) (100 + p.Bonus_By_Stat[Stat_Bonus.DAMAGE] + (20 if p.Is_Alone else 0))
#!define feskaReceivedPercent(p) ((100 - p.Bonus_By_Stat[Stat_Bonus.DAMAGE_REDUCTION]) * (0.85 if p.Is_Alone else 1))

#!define feskaCardPosition(x, y) (localPlayer.getEyePosition() + 30 * (x * worldVector(Vector.LEFT, localPlayer, Transform.ROTATION) + y * directionFromAngles(localPlayer.getHorizontalFacingAngle(), localPlayer.getVerticalFacingAngle() - 90) + 3 * localPlayer.getFacingDirection()))

# 僵尸 AI 与英雄机制状态。布尔量统一 Is_ 前缀。
playervar Chase_Target_Player
playervar Last_Teleported_Hero
playervar Spawn_Time
playervar Target_Refresh_Time
playervar Allowed_Hero_Pool
playervar Visible_Target_Candidates
playervar Last_Progress_Position
playervar No_Progress_Count

# 成长状态属于玩家, 跨波次/死亡/换英雄保留, 离场清理伤害调整句柄与生命池。
playervar Is_Initialized
playervar Owned_Tech_Ids
# 左侧队伍科技栏显示的 4 个科技图标, 持有科技变化时刷新, HUD 只读它。
playervar Tech_Icon_Text
playervar Base_Max_Health
playervar Pending_Stat_Upgrade_Count
playervar Taken_Stat_Upgrade_Count
playervar Bonus_By_Stat
playervar Damage_Modification_Id
playervar Damage_Modification_Percent
playervar Received_Modification_Id
playervar Received_Modification_Percent
# 亮出你的剑: 把 7 米外僵尸受伤压到 0 的伤害调整句柄。
playervar Sword_Range_Modification_Id
playervar Card_Upgrade_Ids
playervar Candidate_Upgrade_Ids
playervar Selected_Card_Index
playervar Card_Rerolled_Flags
playervar Is_Card_Panel_Visible
playervar Current_Choice_Kind
playervar Chosen_Upgrade_Id
playervar Is_Choice_Locked
playervar Restored_For_Hero
# 死亡后需要重放一次属性恢复(重生路径), 与真正换英雄区分: 换英雄才重捕英雄原始最大生命
playervar Needs_Stat_Restore
playervar Armor_Health_Pool
playervar Elimination_Baseline
playervar Heartsteel_Flat_Health
playervar Heartsteel_Health_Pool
playervar Regeneration_Health_Pool
playervar Victory_Will_Used_This_Wave
playervar Is_Alone
playervar Is_Spawning_Derived_Damage
playervar Reactive_Armor_Health_Pool
playervar Is_Berserk
# 狂战士之魂: 未激活期间的不死守卫已武装(持有者只有一条等待规则在跑)
playervar Is_Berserk_Guard_Armed
