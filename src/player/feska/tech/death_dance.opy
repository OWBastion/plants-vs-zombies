#!mainFile "../../../main.opy"

# 死亡之舞: 受到的伤害 50% 在 2 秒内以流血形式扣除; 击杀僵尸回复 25~75 + 5% 最大生命值。
# 工坊无法延后伤害结算, 只能先回补再扣回: heal 之后立刻起一段 2 秒的持续伤害。
# 回补量必须夹住当前可恢复生命: 满血挨打时回补会被最大生命截断, 而 DOT 不会, 否则玩家凭空多受伤。
# 流血来源传 null, 其他"受到伤害"类科技(坚定/痛苦疗愈/坚韧/十字军)都带 attacker != null, 不会连锁触发。
# 狂战士禁疗期间回补为 0, 此时同步跳过 DOT, 不做纯多扣。
# 25~75 按进攻波次线性插值(与 feskaGrowthAt 同一口径)。
#!define FESKA_DEATH_DANCE_SHARE 0.5
#!define FESKA_DEATH_DANCE_SECONDS 2
#!define UPGRADE_ROW_DEATH_DANCE ["死亡之舞", "受到的伤害 50% 在 2 秒内以流血形式扣除\n击杀僵尸回复 25～75 + 5% 最大生命值", UPGRADE_KIND_TECH, 0, 1, 0, 0, 0, abilityIconString(Hero.REAPER, Button.ABILITY_2), []]

rule "Feska - Death dance":
    @Event playerTookDamage
    @Team 2
    @Condition Is_Attack_Phase
    @Condition Tech_Id.DEATH_DANCE in eventPlayer.Owned_Tech_Ids
    @Condition eventPlayer.isAlive()
    @Condition eventDamage > 0
    @Condition attacker != null
    @Condition attacker.getTeam() == Team.1
    @Condition not eventPlayer.Is_Berserk

    Bleed_Amount = min(eventDamage * FESKA_DEATH_DANCE_SHARE, eventPlayer.getMaxHealth() - eventPlayer.getHealth())
    if Bleed_Amount > 0:
        heal(eventPlayer, null, Bleed_Amount)
        eventPlayer.startDamageOverTime(null, FESKA_DEATH_DANCE_SECONDS, Bleed_Amount / FESKA_DEATH_DANCE_SECONDS)


rule "Feska - Death dance final blow":
    @Event playerDealtFinalBlow
    @Team 2
    @Condition victim.getTeam() == Team.1
    @Condition Tech_Id.DEATH_DANCE in eventPlayer.Owned_Tech_Ids
    @Condition not eventPlayer.Is_Berserk

    heal(eventPlayer, null, feskaGrowthAt(feskaProgressRatio(), 25, 50) + feskaMaxHealth(eventPlayer) * 0.05)
