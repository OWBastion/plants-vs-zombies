#!mainFile "../main.opy"

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

# 目录由数组驱动: 每行一项, 列固定。科技 ID 沿用 0..7, 新科技追加 14..27, 本轮五项追加 34..38;
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
# 本轮确认的五项新科技
#!define T_AIDKIT 34
#!define T_RADIANT 35
#!define T_CRUSADER 36
#!define T_REACTIVE 37
#!define T_BERSERK 38

# 属性强化 ID
#!define A_ARMOR 28
#!define A_DR 29
#!define A_REGEN 30
#!define A_HEAL_RECEIVED 31
#!define A_ULT 32
#!define A_KBR 33

# 波次成长统一入口: 第 1 波取最小值, 设置的最终波取最大值, 中间线性。总波数来自设置, 不写死。
#!define feskaGrowthAt(progress, base, span) round(base + span * progress)
#!define feskaProgress() min(max((Current_Round - 1) / max(Config_Total_Round - 1, 1), 0), 1)
# 预览成长按实际结算波次: 进攻阶段用当前波, 准备阶段用即将进攻的下一波, 避免显示与结算错一波。
#!define feskaPreviewProgress() min(max(((Current_Round if Under_Attack else Completed_Attacks + 1) - 1) / max(Config_Total_Round - 1, 1), 0), 1)
#!define feskaGrowthHeartsteel() feskaGrowthAt(feskaProgress(), 1, 24)
#!define feskaGrowthPool() feskaGrowthAt(feskaProgress(), 50, 200)

# setMaxHealth 只接受百分比(相对英雄原始最大生命)。可计入最大生命值是绝对点数:
# 英雄原始最大生命×(100+生命加成)% + 心之钢永久增量 + 护甲强化。
# 光子护盾/血肉/反应装甲等本来源生命池不计入, 防止百分比效果把自己新增的生命值再次计入。
# feska_base_hp 在初始化与换英雄时读取工坊实际属性, 不维护英雄基础属性表。
#!define feskaHealthPercent(p) (100 + p.feska_bonus[1])
#!define feskaMaxHP(p) (p.feska_base_hp * (100 + p.feska_bonus[1]) / 100 + p.feska_heartsteel_flat + 25 * p.feska_armor_count)
# 反应装甲护甲量: 固定 100 点 + 可计入最大生命的 10%(护甲池自身不计入, 避免自我放大)
#!define feskaReactiveArmor(p) ceil(100 + feskaMaxHP(p) * 0.1)
# 狂战士之魂: 总生命上限变为可计入最大生命值的 21 倍(2000% 额外 + 100% 基础)。
# setMaxHealth 按英雄原始最大生命的百分比设置且生命池另行叠加, 因此百分比里含生命池的 20 倍补偿。
#!define feskaBerserkPercent(p) (2100 + 21 * p.feska_bonus[1] + 2000 * (p.feska_heartsteel_flat + 25 * p.feska_armor_count) / p.feska_base_hp)
#!define feskaBerserkMaxHP(p) (21 * feskaMaxHP(p))
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
# 英雄原始最大生命(绝对点数), 初始化与换英雄时从工坊实际属性读取
playervar feska_base_hp
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
# 死亡后需要重放一次属性恢复(重生路径), 与真正换英雄区分: 换英雄才重捕英雄原始最大生命
playervar feska_stat_dirty
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
# 反应装甲: 本来源护甲的镜像值, 用于判定伤害是否被护甲拦下(工坊不能读取生命池余量)
playervar feska_reactive_value
playervar feska_reactive_pool
# 反应装甲镜像恢复: 上次受到伤害的比赛时间, 离战一段时间后回满
playervar feska_reactive_last_hit
# 狂战士之魂: 激活期间可自由移动, 禁疗, 每秒自损
playervar feska_berserk
# 狂战士之魂: 未激活期间的不死守卫已武装(持有者只有一条等待规则在跑)
playervar feska_berserk_guard
# 绝对零度: 上次触发的比赛时间, 用于两次触发的最短间隔
playervar feska_freeze_all_last
