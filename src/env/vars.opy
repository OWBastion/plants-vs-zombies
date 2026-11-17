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

# 科技 ID 0..7; 锻体 ID 8..13。表字段: 名称、描述、伤害%、生命%、治疗%。
#!define FESKA_TECH_COUNT 8
#!define FESKA_MAX_TECH 4
#!define FESKA_DAMAGE 2
#!define FESKA_HEALTH 3
#!define FESKA_HEALING 4
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

# 成长状态属于玩家, 跨波次/死亡/换英雄保留, 离场清理伤害调整句柄。
playervar feska_initialized
playervar feska_tech
playervar feska_forge_pending
playervar feska_forge_count
playervar feska_bonus
playervar feska_damage_mod
playervar feska_options
playervar feska_cursor
playervar feska_rerolled
playervar feska_visible
playervar feska_choice_type
playervar feska_choice
playervar feska_stat_hero
