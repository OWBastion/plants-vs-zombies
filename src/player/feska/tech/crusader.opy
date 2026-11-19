#!mainFile "../../../main.opy"

# 工坊没有伤前固定点数减伤动作(startDamageModification 只接受百分比), 按用户确认的方案用受伤后回补实现:
# 伤害结算后把生命设为 当前生命 + min(减伤值, 本次伤害), 单次伤害最低结算为 0, 不会变成治疗。
# 已知缺口: 一击致死的伤害无法回补(playerTookDamage 触发时玩家已死亡, setHealth 不生效), 本方案不防秒杀。
#!define UPGRADE_ROW_CRUSADER ["十字军铠甲", "降低 15～80 受到的伤害", 1, 0, 1, 0, 0, 0]
#!define feskaCrusaderFlat() feskaGrowthAt(feskaProgress(), 15, 65)

rule "Feska - Crusader armor":
    @Event playerTookDamage
    @Team 2
    @Condition Under_Attack
    @Condition TechId.CRUSADER in eventPlayer.tech
    @Condition eventPlayer.isAlive()
    @Condition eventDamage > 0
    # 排除自损(狂战士之魂的每秒自损), 否则会抵消该科技的代价。
    @Condition attacker != eventPlayer

    eventPlayer.setHealth(min(eventPlayer.getHealth() + min(feskaCrusaderFlat(), eventDamage), eventPlayer.getMaxHealth()))
    wait()
