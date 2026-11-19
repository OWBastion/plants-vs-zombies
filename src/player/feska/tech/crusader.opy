#!mainFile "../../../main.opy"

# 十字军铠甲 (T_CRUSADER = 36)
# 工坊没有伤前固定点数减伤动作(startDamageModification 只接受百分比), 按用户确认的方案用受伤后回补实现:
# 伤害结算后把生命设为 当前生命 + min(减伤值, 本次伤害), 单次伤害最低结算为 0, 不会变成治疗。
# 已知缺口: 一击致死的伤害无法回补(playerTookDamage 触发时玩家已死亡, setHealth 不生效), 本方案不防秒杀。
#!define FESKA_ROW_CRUSADER ["十字军铠甲", "每次受到伤害后恢复 15～80 点生命\n恢复量不超过本次伤害", 1, 0, 1, 0, 0, 0]
# 回补点数按进攻波次线性成长: 第 1 波 15, 最终波 80。
#!define feskaCrusaderFlat() feskaGrowthAt(feskaProgress(), 15, 65)

rule "Feska - Crusader armor":
    @Event playerTookDamage
    @Team 2
    @Condition Under_Attack
    @Condition T_CRUSADER in eventPlayer.feska_tech
    @Condition eventPlayer.isAlive()
    @Condition eventDamage > 0
    # 排除自损(狂战士之魂的每秒自损), 否则会抵消该科技的代价。
    @Condition attacker != eventPlayer

    # 伤害已结算, 只做点数回补。护盾/护甲池余量读不到, 恢复量按事件伤害估算:
    # 护盾部分吸收时可能多补, 上界是本次减伤值。
    eventPlayer.setHealth(min(eventPlayer.getHealth() + min(feskaCrusaderFlat(), eventDamage), eventPlayer.getMaxHealth()))
