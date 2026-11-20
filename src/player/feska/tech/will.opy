#!mainFile "../../../main.opy"

#!define UPGRADE_ROW_VICTORY_WILL ["胜利意志", "生命值首次低于 25% 时获得 8 秒无敌并恢复全部生命值", UPGRADE_KIND_TECH, 0, 1, 0, 0, 0, abilityIconString(Hero.ILLARI, Button.ULTIMATE), []]

rule "Feska - Victory will":
    @Event eachPlayer
    @Team 2
    @Condition Is_Attack_Phase
    @Condition eventPlayer.isAlive()
    @Condition Tech_Id.VICTORY_WILL in eventPlayer.Owned_Tech_Ids
    # 狂战士优先: 激活期间胜利意志不触发, 避免禁疗状态被回血和无敌覆盖。
    @Condition eventPlayer.Is_Berserk != true
    @Condition eventPlayer.Victory_Will_Used_This_Wave != true
    @Condition eventPlayer.getHealth() <= feskaMaxHealth(eventPlayer) * 0.25

    eventPlayer.Victory_Will_Used_This_Wave = true
    heal(eventPlayer, null, feskaMaxHealth(eventPlayer))
    eventPlayer.setStatusEffect(eventPlayer, Status.INVINCIBLE, 8)
    smallMessage(eventPlayer, "胜利意志：8 秒无敌")
