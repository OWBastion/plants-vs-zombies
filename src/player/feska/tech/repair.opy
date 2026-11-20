#!mainFile "../../../main.opy"

#!define UPGRADE_ROW_SELF_REPAIR ["自我修复", "每秒恢复 2% 最大生命值", UPGRADE_KIND_TECH, 0, 1, 0, 0, 0, abilityIconString(Hero.ZENYATTA, Button.ULTIMATE), []]

rule "Feska - Regeneration":
    @Event eachPlayer
    @Team 2
    @Condition Is_Attack_Phase
    @Condition eventPlayer.isAlive()
    # 狂战士禁疗: 自我修复与再生强化都不回血。
    @Condition eventPlayer.Is_Berserk != true
    @Condition (Tech_Id.SELF_REPAIR in eventPlayer.Owned_Tech_Ids) or eventPlayer.Bonus_By_Stat[Stat_Bonus.REGENERATION] > 0

    wait(1, Wait.ABORT_WHEN_FALSE)
    heal(eventPlayer, null, feskaMaxHealth(eventPlayer) * ((0.02 if Tech_Id.SELF_REPAIR in eventPlayer.Owned_Tech_Ids else 0) + 0.003 * eventPlayer.Bonus_By_Stat[Stat_Bonus.REGENERATION]))
    if ruleCondition:
        loop()
