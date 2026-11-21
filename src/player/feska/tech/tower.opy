#!mainFile "../../../main.opy"

#!define UPGRADE_ROW_HEALING_TOWER ["治疗光塔 ProMax", "每 2 秒治疗全体存活队友 2% 最大生命值", UPGRADE_KIND_TECH, 0, 1, 0, 0, 0, abilityIconString(Hero.LUCIO, Button.ULTIMATE), []]

rule "Feska - Healing tower":
    @Event eachPlayer
    @Team 2
    @Condition Is_Attack_Phase
    @Condition eventPlayer.isAlive()
    @Condition Tech_Id.HEALING_TOWER in eventPlayer.Owned_Tech_Ids

    wait(2, Wait.ABORT_WHEN_FALSE)
    # 全体治疗不含狂战士(禁疗); 其余存活真人队友都治, 含持有者。
    Player_List = getLivingPlayers(Team.2).filter(lambda player: not player.isDummy() and player.Is_Berserk != true)
    if Player_List.any(lambda player: player.getHealth() < player.getMaxHealth()):
        playEffect(getPlayers(Team.2), DynamicEffect.BRIGITTE_WHIP_SHOT_HEAL_AREA, Color.GREEN, eventPlayer, 2)
    heal(Player_List, eventPlayer, feskaMaxHealth(eventPlayer) * 0.02)
    if ruleCondition:
        loop()
