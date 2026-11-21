#!mainFile "../../../main.opy"

# 痛苦疗愈: 受到伤害的 12% 转为临时生命, 8 秒后连同未消耗的部分一起移除。
# 每次受击各建一条记录, 不做叠层计数——多条小池与一条大池的收益差别可以忽略。
# 同时存在的记录数封顶, 避免高攻速受击时把玩家身上的生命池数量堆到不可控。
#!define FESKA_PAINFUL_SHARE 0.12
#!define FESKA_PAINFUL_SECONDS 8
#!define FESKA_PAINFUL_MAX_POOLS 8
#!define UPGRADE_ROW_PAINFUL_HEALING ["痛苦疗愈", "受到伤害的 12% 转换为临时生命值，持续 8 秒", UPGRADE_KIND_TECH, 0, 1, 0, 0, 0, abilityIconString(Hero.MOIRA, Button.SECONDARY_FIRE), []]

rule "Feska - Painful healing":
    @Event playerTookDamage
    @Team 2
    @Condition Is_Attack_Phase
    @Condition Tech_Id.PAINFUL_HEALING in eventPlayer.Owned_Tech_Ids
    @Condition eventPlayer.isAlive()
    @Condition eventDamage > 0
    @Condition attacker != null
    @Condition attacker != eventPlayer
    @Condition feskaTempPoolCount(eventPlayer, Temp_Pool_Id.PAINFUL_HEALING) < FESKA_PAINFUL_MAX_POOLS

    Target_Player = eventPlayer
    Temp_Pool_Tag = Temp_Pool_Id.PAINFUL_HEALING
    Temp_Pool_Type = Health.NORMAL
    Temp_Pool_Amount = eventDamage * FESKA_PAINFUL_SHARE
    Temp_Pool_Expire = getTotalTimeElapsed() + FESKA_PAINFUL_SECONDS
    feskaAddTempPool()
