#Global variables

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
globalvar Feska_Upgrades
globalvar Feska_Tech_Ids
globalvar Feska_Stat_Ids
# 唯一科技(光子护盾)的当前持有者; 离场时释放名额。
globalvar Feska_Shield_Holder
# 子程序当前操作的玩家。OverPy 子程序不支持参数, 用同步临时变量传递。
globalvar Feska_P
globalvar Feska_Index

# 目录由数组驱动: 每行一项, 列固定。科技 ID 沿用 0..7, 新科技追加 14..27;
# 强化 ID 沿用 8..13, 新强化追加 28..33。候选池按类型列生成, 不硬编码 ID 区间。
#!define FESKA_COL_NAME 0
#!define FESKA_COL_DESC 1
#!define FESKA_COL_TYPE 2
#!define FESKA_COL_UNIQUE 3
#!define FESKA_COL_ENABLED 4
#!define FESKA_COL_DAMAGE 5
#!define FESKA_COL_HEALTH 6
#!define FESKA_COL_HEALING 7

#!define FESKA_TYPE_TECH 1
#!define FESKA_TYPE_STAT 2
#!define FESKA_MAX_TECH 4

# 科技 ID
#!define T_BRUTAL 0
#!define T_GIANT 1
#!define T_HEALING 2
#!define T_REPAIR 3
#!define T_LIFESTEAL 4
#!define T_THORNS 5
#!define T_COOKER 6
#!define T_CANNON 7
#!define T_PURGE 14
#!define T_ICE 15
#!define T_BASICS 16
#!define T_SWORD 17
#!define T_SNIPER 18
#!define T_FREEZE_ALL 19
#!define T_F5 20
#!define T_HEARTSTEEL 21
#!define T_SHIELD 22
#!define T_FLESH 23
#!define T_TOWER 24
#!define T_WILL 25
#!define T_BATTERY 26
#!define T_LONE 27

# 属性强化 ID
#!define A_ARMOR 28
#!define A_DR 29
#!define A_REGEN 30
#!define A_HEAL_RECEIVED 31
#!define A_ULT 32
#!define A_KBR 33

# 波次成长: 第 1 波为最小值, 设置的最终波为最大值, 中间线性。总波数来自设置, 不写死。
#!define feskaProgress() min(max((Current_Round - 1) / max(Config_Total_Round - 1, 1), 0), 1)
#!define feskaPreviewProgress() min(max((max(Completed_Attacks, 1) - 1) / max(Config_Total_Round - 1, 1), 0), 1)
#!define feskaGrowthHeartsteel() round(1 + 24 * feskaProgress())
#!define feskaGrowthPool() round(50 + 200 * feskaProgress())

# 成长系统自己的生命基准: 只含本模式的百分比加成, 不计入护盾/临时生命/心之钢等生命池,
# 避免同一来源的百分比把自己新增的生命值再次计入。
#!define feskaMaxHP(p) (100 + p.feska_bonus[1])
#!define feskaDamagePercent(p) (100 + p.feska_bonus[0] + (20 if p.feska_lone else 0))
#!define feskaReceivedPercent(p) ((100 - p.feska_dr) * (0.85 if p.feska_lone else 1))

#!define feskaCardPosition(x, y) (localPlayer.getEyePosition() + 30 * (x * worldVector(Vector.LEFT, localPlayer, Transform.ROTATION) + y * directionFromAngles(localPlayer.getHorizontalFacingAngle(), localPlayer.getVerticalFacingAngle() - 90) + 3 * localPlayer.getFacingDirection()))

#Player variables

playervar BotTarget
playervar Teleported_Hero
playervar Spawned_At
playervar TTK
playervar heros
playervar mov_speed_penalty
playervar zarya_barrier_shields
playervar sym_barrier_shields
playervar tracer_buff
playervar brig_repair_pack
playervar brig_rally_armor_id
playervar lucio_crossfade_dmg
playervar knockback_direction
playervar zen_transcendence
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
playervar feska_initialized
playervar feska_tech
playervar feska_forge_pending
playervar feska_forge_count
playervar feska_bonus
playervar feska_damage_mod
playervar feska_damage_value
playervar feska_recv_mod
playervar feska_recv_value
playervar feska_options
playervar feska_pool
playervar feska_cursor
playervar feska_rerolled
playervar feska_visible
playervar feska_choice_type
playervar feska_choice
playervar feska_lock
playervar feska_stat_hero
# 属性强化的累计状态
playervar feska_armor_count
playervar feska_armor_pool
playervar feska_dr
playervar feska_regen
playervar feska_heal_received
playervar feska_ult_rate
playervar feska_kbr
# 科技状态
playervar feska_elim_count
playervar feska_heartsteel_flat
playervar feska_heartsteel_pool
playervar feska_shield_pool
playervar feska_blood_pool
playervar feska_will_used
playervar feska_lone
playervar feska_chain
# 僵尸: 冰寒之刃的每目标冷却
playervar feska_freeze_cd
