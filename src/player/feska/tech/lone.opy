#!mainFile "../../../main.opy"

#!define UPGRADE_ROW_LONE ["一夫当关", "10 米内没有其他队友时\n伤害 +20%, 受到的伤害 -15%", 1, 0, 1, 0, 0, 0]

rule "Feska - Lone wolf":
    @Event eachPlayer
    @Team 2
    @Condition Under_Attack
    @Condition eventPlayer.isAlive()
    @Condition TechId.LONE in eventPlayer.tech

    # 中心传玩家时该玩家自身不计入, 所以最近玩家就是最近的队友。
    # 该值不区分生死: 队友阵亡尸体被传送到脑子旁也会挡住加成, 这是已接受的取舍。
    # 独自成队时返回 null, 需要单独判空, 否则 distance(null) 的比较恒为假。
    eventPlayer.lone = getClosestPlayer(eventPlayer, Team.2) == null or distance(eventPlayer, getClosestPlayer(eventPlayer, Team.2)) > 10
    feskaRefreshMods()
    wait(0.5, Wait.ABORT_WHEN_FALSE)
    if ruleCondition:
        loop()


rule "Feska - Lone wolf cleanup":
    @Event eachPlayer
    @Team 2
    @Condition isGameInProgress()
    @Condition not Under_Attack
    @Condition eventPlayer.lone

    eventPlayer.lone = false
    feskaRefreshMods()
