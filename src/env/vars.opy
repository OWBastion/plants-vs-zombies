#!mainFile "../main.opy"

globalvar Bot_Respawn_Points
globalvar Brain_Points
globalvar Current_Round
globalvar Config_Total_Round
globalvar Config_Round_Attack_Time
globalvar Config_Round_Lead_Time
globalvar Debug
globalvar Under_Attack
globalvar Difficult
globalvar Round_Attack_Time
globalvar Round_Lead_Time
globalvar NumberOfZombies
globalvar Zombie_Heros
globalvar Tank_Heros
globalvar Damage_Heros
globalvar Support_Heros
globalvar ANTI_CRASH_ACTIVATE_PERCENT
globalvar ANTI_CRASH_HOLD_TIME
globalvar ANTI_CRASH_DEACTIVATE_PERCENT
globalvar Hero_BAN
globalvar Completed_Attacks
globalvar Upgrades
globalvar Tech_Ids
globalvar Stat_Ids
globalvar Shield_Holder
# 子程序当前操作的玩家。OverPy 子程序不支持参数, 用同步临时变量传递。
globalvar Target_Player
globalvar Work_Index

#!define UPGRADE_COL_NAME 0
#!define UPGRADE_COL_DESC 1
#!define UPGRADE_COL_TYPE 2
#!define UPGRADE_COL_ENABLED 4
#!define UPGRADE_COL_DAMAGE 5
#!define UPGRADE_COL_HEALTH 6
#!define UPGRADE_COL_HEALING 7

#!define UPGRADE_TYPE_TECH 1
#!define MAX_TECH 4

enum FeskaBonus:
    DAMAGE = 0
    HEALTH
    HEALING

enum TechId:
    BRUTAL = 0
    GIANT = 1
    HEALING = 2
    REPAIR = 3
    LIFESTEAL = 4
    THORNS = 5
    COOKER = 6
    CANNON = 7
    PURGE = 14
    ICE = 15
    BASICS = 16
    SWORD = 17
    SNIPER = 18
    FREEZE_ALL = 19
    F5 = 20
    HEARTSTEEL = 21
    SHIELD = 22
    FLESH = 23
    TOWER = 24
    WILL = 25
    BATTERY = 26
    LONE = 27
    AIDKIT = 34
    RADIANT = 35
    CRUSADER = 36
    REACTIVE = 37
    BERSERK = 38

enum StatId:
    DAMAGE = 8
    HEALTH = 9
    HEALING = 10
    BALANCED = 11
    RESONANCE = 12
    NOURISHMENT = 13
    ARMOR = 28
    DR = 29
    REGEN = 30
    HEAL_RECEIVED = 31
    ULT = 32
    KBR = 33

#!define feskaGrowthAt(progress, base, span) round(base + span * progress)
#!define feskaProgress() min(max((Current_Round - 1) / max(Config_Total_Round - 1, 1), 0), 1)
# 预览成长按实际结算波次: 进攻阶段用当前波, 准备阶段用即将进攻的下一波, 避免显示与结算错一波。
#!define feskaPreviewProgress() min(max(((Current_Round if Under_Attack else Completed_Attacks + 1) - 1) / max(Config_Total_Round - 1, 1), 0), 1)
#!define feskaGrowthHeartsteel() feskaGrowthAt(feskaProgress(), 1, 24)
#!define feskaGrowthPool() feskaGrowthAt(feskaProgress(), 50, 200)

# setMaxHealth 只接受百分比(相对英雄原始最大生命)。可计入最大生命值是绝对点数:
# 英雄原始最大生命×(100+生命加成)% + 心之钢永久增量 + 护甲强化。
# 光子护盾/血肉/反应装甲等本来源生命池不计入, 防止百分比效果把自己新增的生命值再次计入。
# base_hp 在初始化与换英雄时读取工坊实际属性, 不维护英雄基础属性表。
#!define feskaHealthPercent(p) (100 + p.bonus[FeskaBonus.HEALTH])
#!define feskaMaxHP(p) (p.base_hp * (100 + p.bonus[FeskaBonus.HEALTH]) / 100 + p.heartsteel_flat + 25 * p.armor_count)
#!define feskaReactiveArmor(p) ceil(100 + feskaMaxHP(p) * 0.1)
# 狂战士之魂: 总生命上限变为可计入最大生命值的 21 倍(2000% 额外 + 100% 基础)。
# setMaxHealth 按英雄原始最大生命的百分比设置且生命池另行叠加, 因此百分比里含生命池的 20 倍补偿。
#!define feskaBerserkPercent(p) (2100 + 21 * p.bonus[FeskaBonus.HEALTH] + 2000 * (p.heartsteel_flat + 25 * p.armor_count) / p.base_hp)
#!define feskaBerserkMaxHP(p) (21 * feskaMaxHP(p))
#!define feskaDamagePercent(p) (100 + p.bonus[FeskaBonus.DAMAGE] + (20 if p.lone else 0))
#!define feskaReceivedPercent(p) ((100 - p.dr) * (0.85 if p.lone else 1))

#!define feskaCardPosition(x, y) (localPlayer.getEyePosition() + 30 * (x * worldVector(Vector.LEFT, localPlayer, Transform.ROTATION) + y * directionFromAngles(localPlayer.getHorizontalFacingAngle(), localPlayer.getVerticalFacingAngle() - 90) + 3 * localPlayer.getFacingDirection()))

playervar BotTarget
playervar Teleported_Hero
playervar Spawned_At
playervar TTK
playervar heros
playervar mov_speed_penalty
playervar zarya_barrier_shields
playervar tracer_buff
playervar brig_repair_pack
playervar brig_rally_armor_id
playervar knockback_direction
playervar scoped_shot_distance
playervar scoped_damage_base
playervar ow2_scoped_damage_falloff_scalar
playervar ow1_scoped_damage_falloff_scalar
playervar expected_scoped_damage
playervar scan_candidates
playervar juno_ray_targets
playervar stuck_last_pos
playervar stuck_count

# 成长状态属于玩家, 跨波次/死亡/换英雄保留, 离场清理伤害调整句柄与生命池。
playervar initialized
playervar tech
playervar base_hp
playervar forge_pending
playervar forge_count
playervar bonus
playervar damage_mod
playervar damage_value
playervar recv_mod
playervar recv_value
playervar options
playervar pool
playervar cursor
playervar rerolled
playervar visible
playervar choice_type
playervar choice
playervar lock
playervar stat_hero
# 死亡后需要重放一次属性恢复(重生路径), 与真正换英雄区分: 换英雄才重捕英雄原始最大生命
playervar stat_dirty
playervar armor_count
playervar armor_pool
playervar dr
playervar regen
playervar heal_received
playervar ult_rate
playervar kbr
playervar elim_mark
playervar heartsteel_flat
playervar heartsteel_pool
playervar shield_pool
playervar blood_pool
playervar will_used
playervar lone
playervar chain
playervar reactive_pool
playervar berserk
# 狂战士之魂: 未激活期间的不死守卫已武装(持有者只有一条等待规则在跑)
playervar berserk_guard
