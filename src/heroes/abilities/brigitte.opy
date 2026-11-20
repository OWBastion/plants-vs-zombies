#!mainFile "../../main.opy"

rule "【布丽吉塔】恢复包选中目标":
    @Event eachPlayer
    @Team 2
    @Hero brigitte
    @Condition eventPlayer.isUsingAbility2() == true
    @Condition distance(eventPlayer, eventPlayer.getPlayerClosestToReticle(eventPlayer.getTeam())) <= 20.25

    sorted(getLivingPlayers(eventPlayer.getTeam()), lambda player: angleBetweenVectors(eventPlayer.getFacingDirection(), directionTowards(eventPlayer.getPosition(), player.getPosition())))[0].Repair_Pack_Pending = true


rule "【布丽吉塔】恢复包提供护甲":
    @Event eachPlayer
    @Team 2
    @Condition eventPlayer.getHero() != Hero.BRIGITTE
    @Condition (eventPlayer.isAlive() and eventPlayer.Repair_Pack_Pending) == true

    eventPlayer.Repair_Pack_Pending = false
    if eventPlayer.Repair_Pack_Health_Pool == null:
        goto lbl_0
    removeHealthPool(eventPlayer.Repair_Pack_Health_Pool)
    lbl_0:
    eventPlayer.addHealthPool(Health.ARMOR, 150, false, false)
    smallMessage(eventPlayer, "  {0} 获得来自 {1} 的护甲".format(abilityIconString(Hero.BRIGITTE, Button.ABILITY_2), Hero.BRIGITTE))
    eventPlayer.Repair_Pack_Health_Pool = getLastCreatedHealthPool()


rule "[Brigitte]: Rally provides permanent armor to self":
    @Event eachPlayer
    @Team 2
    @Condition len(eventPlayer.Rally_Armor_Pool_Ids) == 13

    waitUntil(not getPlayersOnHero(Hero.BRIGITTE, eventPlayer.getTeam()).isUsingUltimate() and eventPlayer.Rally_Armor_Pool_Ids != [], 30)
    wait(4)
    removeHealthPool(eventPlayer.Rally_Armor_Pool_Ids[0])
    eventPlayer.Rally_Armor_Pool_Ids.remove(eventPlayer.Rally_Armor_Pool_Ids[0])
    if len(eventPlayer.Rally_Armor_Pool_Ids) != 0:
        loop()


rule "[Brigitte]Rally provides permanent armor to self":
    @Event eachPlayer
    @Team 2
    @Hero brigitte
    @Condition eventPlayer.isUsingUltimate() == true
    @Condition len(eventPlayer.Rally_Armor_Pool_Ids) < 13

    getLivingPlayers(eventPlayer.getTeam()).addHealthPool(Health.ARMOR, 25, false, false)
    getLivingPlayers(eventPlayer.getTeam()).Rally_Armor_Pool_Ids.append(getLastCreatedHealthPool())
    wait(0.5)
    if ruleCondition:
        loop()
