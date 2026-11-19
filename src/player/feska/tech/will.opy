# 胜利意志 (T_WILL = 25)
# 每波生命值首次低于 25% 时获得 8 秒无敌并恢复全部生命; feska_will_used 每波在波次开始重置。
#!define FESKA_ROW_WILL ["胜利意志", "每波生命值首次低于 25% 时\n获得 8 秒无敌并恢复全部生命", 1, 0, 1, 0, 0, 0]

rule "Feska - Victory will":
    @Event eachPlayer
    @Team 2
    @Condition Under_Attack
    @Condition eventPlayer.isAlive()
    @Condition T_WILL in eventPlayer.feska_tech
    # 狂战士优先: 激活期间胜利意志不触发, 避免禁疗状态被回血和无敌覆盖。
    @Condition eventPlayer.feska_berserk != true
    @Condition eventPlayer.feska_will_used != true
    @Condition eventPlayer.getHealth() <= feskaMaxHP(eventPlayer) * 0.25

    eventPlayer.feska_will_used = true
    heal(eventPlayer, null, feskaMaxHP(eventPlayer))
    eventPlayer.setStatusEffect(eventPlayer, Status.INVINCIBLE, 8)
    smallMessage(eventPlayer, "胜利意志：8 秒无敌")
