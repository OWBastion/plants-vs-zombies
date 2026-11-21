#!mainFile "../../../main.opy"

# 不屈意志: 每损失 1% 最大生命, 获得 1% 减伤与 1% 增伤。
# 生命值连续变化, 无法用事件触发, 只能低频重算; 0.25 秒一次, 且只在取整后的百分点变化时重建修改器。
# 减伤与其他来源加算后统一封顶 90%, 增伤不封顶。
#!define UPGRADE_ROW_INDOMITABLE ["不屈意志", "每损失 1% 生命值，获得 1% 伤害减免与 1% 增伤", UPGRADE_KIND_TECH, 0, 1, 0, 0, 0, abilityIconString(Hero.RAMATTRA, Button.PRIMARY_FIRE), []]

rule "Feska - Indomitable":
    @Event eachPlayer
    @Team 2
    @Condition isGameInProgress()
    @Condition eventPlayer.isAlive()
    @Condition Tech_Id.INDOMITABLE in eventPlayer.Owned_Tech_Ids

    eventPlayer.Missing_Health_Percent = round(feskaMissingHealthPercent(eventPlayer))
    feskaRefreshMods()
    wait(0.25, Wait.ABORT_WHEN_FALSE)
    if ruleCondition:
        loop()


rule "Feska - Indomitable cleanup":
    @Event playerDied
    @Team 2
    @Condition Tech_Id.INDOMITABLE in eventPlayer.Owned_Tech_Ids
    @Condition eventPlayer.Missing_Health_Percent != 0

    # 死亡时清零, 否则复活瞬间会带着满层增伤与减伤出手。
    eventPlayer.Missing_Health_Percent = 0
    feskaRefreshMods()
