# 治疗光塔 ProMax (T_TOWER = 24)
# 每 2 秒治疗全体存活队友(含持有者), 数值为持有者最大生命值的 2%, 无距离限制。
#!define FESKA_ROW_TOWER ["治疗光塔 ProMax", "每 2 秒治疗全体存活队友\n数值为持有者最大生命值的 2%", 1, 0, 1, 0, 0, 0]

rule "Feska - Healing tower":
    @Event eachPlayer
    @Team 2
    @Condition Under_Attack
    @Condition eventPlayer.isAlive()
    @Condition T_TOWER in eventPlayer.feska_tech

    wait(2, Wait.ABORT_WHEN_FALSE)
    # 全体治疗不含狂战士(禁疗); 其余存活真人队友都治, 含持有者。
    heal(getLivingPlayers(Team.2).filter(lambda player: not player.isDummy() and player.feska_berserk != true), eventPlayer, feskaMaxHP(eventPlayer) * 0.02)
    if ruleCondition:
        loop()
