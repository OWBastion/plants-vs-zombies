#!mainFile "../../../main.opy"

#!define UPGRADE_ROW_LIFESTEAL ["吸血习性", "每参与消灭一只僵尸恢复 5% 最大生命值", UPGRADE_KIND_TECH, 0, 1, 0, 0, 0]

rule "Feska - Lifesteal on elimination":
    @Event playerEarnedElimination
    @Team 2
    @Condition Is_Attack_Phase
    @Condition eventPlayer.isAlive()
    @Condition victim.getTeam() == Team.1
    # 狂战士禁疗。
    @Condition eventPlayer.Is_Berserk != true
    @Condition Tech_Id.LIFESTEAL in eventPlayer.Owned_Tech_Ids

    heal(eventPlayer, null, feskaMaxHealth(eventPlayer) * 0.05)
