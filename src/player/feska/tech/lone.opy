#!mainFile "../../../main.opy"

#!define UPGRADE_ROW_LONE_WOLF ["一夫当关", "10 米内没有其他存活队友时：造成的伤害提高 20%，受到的伤害降低 15%", UPGRADE_KIND_TECH, 0, 1, 0, 0, 0, abilityIconString(Hero.CASSIDY, Button.ULTIMATE), []]

rule "Feska - Lone wolf":
    @Event eachPlayer
    @Team 2
    @Condition Is_Attack_Phase
    @Condition eventPlayer.isAlive()
    @Condition Tech_Id.LONE_WOLF in eventPlayer.Owned_Tech_Ids

    # 中心传玩家时该玩家自身不计入, 所以最近玩家就是最近的队友。
    # 该值不区分生死: 队友阵亡尸体被传送到脑子旁也会挡住加成, 这是已接受的取舍。
    # 独自成队时返回 null, 需要单独判空, 否则 distance(null) 的比较恒为假。
    eventPlayer.Is_Alone = getClosestPlayer(eventPlayer, Team.2) == null or distance(eventPlayer, getClosestPlayer(eventPlayer, Team.2)) > 10
    feskaRefreshMods()
    wait(0.5, Wait.ABORT_WHEN_FALSE)
    if ruleCondition:
        loop()


rule "Feska - Lone wolf cleanup":
    @Event eachPlayer
    @Team 2
    @Condition isGameInProgress()
    @Condition not Is_Attack_Phase
    @Condition eventPlayer.Is_Alone

    eventPlayer.Is_Alone = false
    feskaRefreshMods()
