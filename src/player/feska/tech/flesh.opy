#!mainFile "../../../main.opy"

#!define UPGRADE_ROW_FLESH_REGENERATION ["血肉再生", "每 10 秒获得 50～250 （随波次成长）+ 5% 最大生命值临时生命值", UPGRADE_KIND_TECH, 0, 1, 0, 0, 0, abilityIconString(Hero.MOIRA, Button.ULTIMATE), []]

rule "Feska - Blood regeneration":
    @Event eachPlayer
    @Team 2
    @Condition Is_Attack_Phase
    @Condition eventPlayer.isAlive()
    @Condition Tech_Id.FLESH_REGENERATION in eventPlayer.Owned_Tech_Ids

    wait(10, Wait.ABORT_WHEN_FALSE)
    # 整池重建走共用池表: 先按标签清掉旧记录, 再追加一条不过期的新记录。
    Target_Player = eventPlayer
    Temp_Pool_Tag = Temp_Pool_Id.FLESH_REGENERATION
    feskaClearTempPoolsByTag()
    Temp_Pool_Type = Health.NORMAL
    Temp_Pool_Amount = ceil(feskaPoolGrowthValue() + feskaMaxHealth(eventPlayer) * 0.05)
    Temp_Pool_Expire = 0
    feskaAddTempPool()
    playEffect(getPlayers(Team.2), DynamicEffect.MOIRA_FADE_REAPPEAR, Color.PURPLE, eventPlayer, 1)
    if ruleCondition:
        loop()
