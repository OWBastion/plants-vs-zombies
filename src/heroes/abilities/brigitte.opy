#!mainFile "../../main.opy"

rule "【布丽吉塔】恢复包选中目标":
    @Event eachPlayer
    @Team 2
    @Hero brigitte
    @Condition eventPlayer.isUsingAbility2() == true
    @Condition distance(eventPlayer, eventPlayer.getPlayerClosestToReticle(eventPlayer.getTeam())) <= 20.25

    sorted(getLivingPlayers(eventPlayer.getTeam()), lambda player: angleBetweenVectors(eventPlayer.getFacingDirection(), directionTowards(eventPlayer.getPosition(), player.getPosition())))[0].brig_repair_pack[0] = true


rule "【布丽吉塔】恢复包提供护甲":
    @Event eachPlayer
    @Team 2
    @Condition eventPlayer.getHero() != Hero.BRIGITTE
    @Condition (eventPlayer.isAlive() and eventPlayer.brig_repair_pack[0]) == true

    eventPlayer.brig_repair_pack[0] = false
    if eventPlayer.brig_repair_pack[1] == null:
        goto lbl_0
    removeHealthPool(eventPlayer.brig_repair_pack[1])
    lbl_0:
    eventPlayer.addHealthPool(Health.ARMOR, 150, false, false)
    smallMessage(eventPlayer, "  {0} 获得来自 {1} 的护甲".format(abilityIconString(Hero.BRIGITTE, Button.ABILITY_2), Hero.BRIGITTE))
    eventPlayer.brig_repair_pack[1] = getLastCreatedHealthPool()


rule "[Brigitte]: Rally provides permanent armor to self":
    @Event eachPlayer
    @Team 2
    @Condition len(eventPlayer.brig_rally_armor_id) == 13

    waitUntil(not getPlayersOnHero(Hero.BRIGITTE, eventPlayer.getTeam()).isUsingUltimate() and eventPlayer.brig_rally_armor_id != [], 30)
    wait(4)
    removeHealthPool(eventPlayer.brig_rally_armor_id[0])
    eventPlayer.brig_rally_armor_id.remove(eventPlayer.brig_rally_armor_id[0])
    if len(eventPlayer.brig_rally_armor_id) != 0:
        loop()


rule "[Brigitte]Rally provides permanent armor to self":
    @Event eachPlayer
    @Team 2
    @Hero brigitte
    @Condition eventPlayer.isUsingUltimate() == true
    @Condition len(eventPlayer.brig_rally_armor_id) < 13

    getLivingPlayers(eventPlayer.getTeam()).addHealthPool(Health.ARMOR, 25, false, false)
    getLivingPlayers(eventPlayer.getTeam()).brig_rally_armor_id.append(getLastCreatedHealthPool())
    wait(0.5)
    if ruleCondition:
        loop()
