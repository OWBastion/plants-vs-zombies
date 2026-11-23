#!mainFile "../../../main.opy"

# 大招工具人: 禁用技能 1/2, 保留终极技能, 进攻期间快速充能。
# 副武器是武器模式而非技能, 工坊没有定向禁用动作; 重生/换英雄的重放由 progression.opy 负责。
# 充能 10%/秒, 满充约 10 秒。名额上限 2 人, 判定宏见 unique.opy 的 feskaUltimateBotFull()。
#!define FESKA_ULTIMATE_BOT_CHARGE 10
#!define UPGRADE_ROW_ULTIMATE_BOT ["大招工具人", "禁用技能 1 与技能 2，进攻期间每秒获得 10% 终极技能充能", UPGRADE_KIND_TECH, 0, 1, 0, 0, 0, abilityIconString(Hero.ROADHOG, Button.ULTIMATE), []]

rule "Feska - Ultimate bot disable abilities":
    @Event eachPlayer
    @Team 2
    @Condition Tech_Id.ULTIMATE_BOT in eventPlayer.Owned_Tech_Ids

    eventPlayer.setAbility1Enabled(false)
    eventPlayer.setAbility2Enabled(false)


rule "Feska - Ultimate bot charge":
    @Event eachPlayer
    @Team 2
    @Condition Is_Attack_Phase
    @Condition eventPlayer.isAlive()
    @Condition Tech_Id.ULTIMATE_BOT in eventPlayer.Owned_Tech_Ids

    wait(1, Wait.ABORT_WHEN_FALSE)
    eventPlayer.setUltCharge(min(eventPlayer.getUltCharge() + FESKA_ULTIMATE_BOT_CHARGE, 100))
    if ruleCondition:
        loop()
