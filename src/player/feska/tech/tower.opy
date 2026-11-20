#!mainFile "../../../main.opy"

#!define UPGRADE_ROW_HEALING_TOWER ["治疗光塔 ProMax", "每 2 秒治疗全体存活队友\n数值为持有者最大生命值的 2%", UPGRADE_KIND_TECH, 0, 1, 0, 0, 0]

rule "Feska - Healing tower":
    @Event eachPlayer
    @Team 2
    @Condition Is_Attack_Phase
    @Condition eventPlayer.isAlive()
    @Condition Tech_Id.HEALING_TOWER in eventPlayer.Owned_Tech_Ids

    wait(2, Wait.ABORT_WHEN_FALSE)
    # 全体治疗不含狂战士(禁疗); 其余存活真人队友都治, 含持有者。
    heal(getLivingPlayers(Team.2).filter(lambda player: not player.isDummy() and player.Is_Berserk != true), eventPlayer, feskaMaxHealth(eventPlayer) * 0.02)
    if ruleCondition:
        loop()
