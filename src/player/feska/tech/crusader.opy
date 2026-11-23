#!mainFile "../../../main.opy"

# 工坊没有伤前固定点数减伤动作(startDamageModification 只接受百分比), 按用户确认的方案用受伤后回补实现:
# 伤害结算后把生命设为 当前生命 + min(减伤值, 本次伤害), 单次伤害最低结算为 0, 不会变成治疗。
# 已知缺口: 一击致死的伤害无法回补(playerTookDamage 触发时玩家已死亡, setHealth 不生效), 本方案不防秒杀。
#!define UPGRADE_ROW_CRUSADER ["十字军铠甲", "受到伤害时抵消 15～80 点伤害（随波次成长）", UPGRADE_KIND_TECH, 0, 1, 0, 0, 0, abilityIconString(Hero.REINHARDT, Button.PRIMARY_FIRE), []]
#!define feskaCrusaderFlat() feskaGrowthAt(feskaProgressRatio(), 15, 65)

rule "Feska - Crusader armor":
    @Event playerTookDamage
    @Team 2
    @Condition Is_Attack_Phase
    @Condition Tech_Id.CRUSADER in eventPlayer.Owned_Tech_Ids
    @Condition eventPlayer.isAlive()
    @Condition eventDamage > 0
    # 只认僵尸本体造成的伤害; 脚本流血(死亡之舞)与环境伤害来源为 null, 不参与回补。
    @Condition attacker != null
    @Condition attacker != eventPlayer

    eventPlayer.setHealth(min(eventPlayer.getHealth() + min(feskaCrusaderFlat(), eventDamage), eventPlayer.getMaxHealth()))
    playEffect(eventPlayer, DynamicEffect.BRIGITTE_REPAIR_PACK_ARMOR, Color.YELLOW, eventPlayer.getPosition(), 0.5)
    wait()
