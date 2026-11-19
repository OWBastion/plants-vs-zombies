#!mainFile "../../../main.opy"

#!define FESKA_ROW_LIFESTEAL ["吸血习性", "每参与消灭一只僵尸恢复 5% 最大生命值", 1, 0, 1, 0, 0, 0]

rule "Feska - Lifesteal on elimination":
    @Event playerEarnedElimination
    @Team 2
    @Condition Under_Attack
    @Condition eventPlayer.isAlive()
    @Condition victim.getTeam() == Team.1
    # 狂战士禁疗。
    @Condition eventPlayer.feska_berserk != true
    @Condition T_LIFESTEAL in eventPlayer.feska_tech

    heal(eventPlayer, null, feskaMaxHP(eventPlayer) * 0.05)
