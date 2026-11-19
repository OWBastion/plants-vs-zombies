#!mainFile "../../../main.opy"

#!define FESKA_ROW_FREEZE_ALL ["绝对零度", "施放终极技能时\n冰冻所有存活僵尸 2.5 秒\n两次触发至少间隔 2.5 秒", 1, 0, 1, 0, 0, 0]

rule "Feska - Absolute zero":
    @Event eachPlayer
    @Team 2
    @Condition T_FREEZE_ALL in eventPlayer.feska_tech
    @Condition eventPlayer.isUsingUltimate()

    getLivingPlayers(Team.1).setStatusEffect(eventPlayer, Status.FROZEN, 2.5)
    wait(2.5)
