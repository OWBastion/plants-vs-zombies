#!mainFile "../../../main.opy"

#!define UPGRADE_ROW_PRESSURE_COOKER ["高压锅", "每秒对 15 米内的所有僵尸造成自身最大生命值 4% 的伤害", UPGRADE_KIND_TECH, 0, 1, 0, 0, 0, abilityIconString(Hero.TORBJORN, Button.ULTIMATE), []]

rule "Feska - Pressure cooker":
    @Event eachPlayer
    @Team 2
    @Condition Is_Attack_Phase
    @Condition eventPlayer.isAlive()
    @Condition Tech_Id.PRESSURE_COOKER in eventPlayer.Owned_Tech_Ids

    wait(1, Wait.ABORT_WHEN_FALSE)
    Player_List = getPlayersInRadius(eventPlayer, 15, Team.1, LosCheck.SURFACES)
    Player_List.filter(lambda player: player.isAlive() and not player.hasStatus(Status.BURNING)).setStatusEffect(null, Status.BURNING, 0.8)
    damage(Player_List, eventPlayer, feskaMaxHealth(eventPlayer) * 0.04)
    if ruleCondition:
        loop()
