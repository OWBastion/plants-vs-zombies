#!mainFile "../../../main.opy"

#!define UPGRADE_ROW_ULTIMATE_CHARGE ["我按Q辣", "进攻期间每秒额外获得\n0.8% 终极技能充能", UPGRADE_KIND_TECH, 0, 1, 0, 0, 0, abilityIconString(Hero.ROADHOG, Button.ULTIMATE), []]

rule "Feska - Ultimate charge":
    @Event eachPlayer
    @Team 2
    @Condition Is_Attack_Phase
    @Condition eventPlayer.isAlive()
    @Condition (Tech_Id.ULTIMATE_CHARGE in eventPlayer.Owned_Tech_Ids) or eventPlayer.Bonus_By_Stat[Stat_Bonus.ULTIMATE_CHARGE] > 0

    wait(1, Wait.ABORT_WHEN_FALSE)
    eventPlayer.setUltCharge(min(eventPlayer.getUltCharge() + (0.8 if Tech_Id.ULTIMATE_CHARGE in eventPlayer.Owned_Tech_Ids else 0) + 0.2 * eventPlayer.Bonus_By_Stat[Stat_Bonus.ULTIMATE_CHARGE], 100))
    if ruleCondition:
        loop()
