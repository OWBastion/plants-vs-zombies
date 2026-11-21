#!mainFile "../../../main.opy"

# 坚定: 每次受击叠一层临时护甲, 每层独立 5 秒, 最多 5 层。
# 每层只能单独建池: 整池重建会把已经吸收掉的护甲补回来。
#!define FESKA_STEADFAST_MAX_STACKS 5
#!define FESKA_STEADFAST_SECONDS 5
#!define UPGRADE_ROW_STEADFAST ["坚定", "受到伤害时获得 12% 最大生命值的临时护甲\n最多 5 层，每层独立持续 5 秒", UPGRADE_KIND_TECH, 0, 1, 0, 0, 0, abilityIconString(Hero.BRIGITTE, Button.PRIMARY_FIRE), []]

rule "Feska - Steadfast":
    @Event playerTookDamage
    @Team 2
    @Condition Is_Attack_Phase
    @Condition Tech_Id.STEADFAST in eventPlayer.Owned_Tech_Ids
    @Condition eventPlayer.isAlive()
    @Condition eventDamage > 0
    # 只认僵尸本体造成的伤害: 脚本流血与狂战士自损不算受击。
    @Condition attacker != null
    @Condition attacker != eventPlayer
    @Condition feskaTempPoolCount(eventPlayer, Temp_Pool_Id.STEADFAST) < FESKA_STEADFAST_MAX_STACKS

    Target_Player = eventPlayer
    Temp_Pool_Tag = Temp_Pool_Id.STEADFAST
    Temp_Pool_Type = Health.ARMOR
    Temp_Pool_Amount = ceil(feskaMaxHealth(eventPlayer) * 0.12)
    Temp_Pool_Expire = getTotalTimeElapsed() + FESKA_STEADFAST_SECONDS
    feskaAddTempPool()
