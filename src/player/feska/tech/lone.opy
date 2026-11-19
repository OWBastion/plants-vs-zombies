#!mainFile "../../../main.opy"

# 一夫当关 (T_LONE = 27)
# 10 米内没有其他存活队友时伤害 +20%, 受到的伤害 -15%; 结果写入 feska_lone, 由伤害调整宏结算。
#!define FESKA_ROW_LONE ["一夫当关", "10 米内没有其他存活队友时\n伤害 +20%, 受到的伤害 -15%", 1, 0, 1, 0, 0, 0]

rule "Feska - Lone wolf":
    @Event eachPlayer
    @Team 2
    @Condition Under_Attack
    @Condition eventPlayer.isAlive()
    @Condition T_LONE in eventPlayer.feska_tech

    eventPlayer.feska_lone = len(getLivingPlayers(Team.2).filter(lambda player: player != eventPlayer and not player.isDummy() and distance(player, eventPlayer) <= 10)) == 0
    Feska_P = eventPlayer
    feskaRefreshMods()
    wait(0.5, Wait.ABORT_WHEN_FALSE)
    if ruleCondition:
        loop()
