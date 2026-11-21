#!mainFile "../../../main.opy"

#!define UPGRADE_ROW_LIFESTEAL ["吸血习性", "每次参与消灭恢复 5% 最大生命值", UPGRADE_KIND_TECH, 0, 1, 0, 0, 0, abilityIconString(Hero.REAPER, Button.PRIMARY_FIRE), []]

rule "Feska - Lifesteal on elimination":
    @Event playerEarnedElimination
    @Team 2
    @Condition Is_Attack_Phase
    @Condition eventPlayer.isAlive()
    @Condition victim.getTeam() == Team.1
    # 狂战士禁疗。
    @Condition eventPlayer.Is_Berserk != true
    @Condition Tech_Id.LIFESTEAL in eventPlayer.Owned_Tech_Ids

    if eventPlayer.getHealth() < eventPlayer.getMaxHealth():
        playEffect(eventPlayer, DynamicEffect.HEAL_TARGET_ACTIVE, Color.GREEN, eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 1.5, 0.5)
    heal(eventPlayer, null, feskaMaxHealth(eventPlayer) * 0.05)
