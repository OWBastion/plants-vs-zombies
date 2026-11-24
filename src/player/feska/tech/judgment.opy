#!mainFile "../../../main.opy"

#!define UPGRADE_ROW_JUDGMENT ["裁决使", "造成最后一击时，刷新所有技能冷却", UPGRADE_KIND_TECH, 0, 1, 0, 0, 0, abilityIconString(Hero.REAPER, Button.ULTIMATE), []]

rule "Feska - Judgment":
    @Event playerDealtFinalBlow
    @Team 2
    @Condition victim.getTeam() == Team.1
    @Condition Tech_Id.JUDGMENT in eventPlayer.Owned_Tech_Ids

    eventPlayer.setAbilityCooldown(Button.ABILITY_1, 0)
    eventPlayer.setAbilityCooldown(Button.ABILITY_2, 0)
    eventPlayer.setAbilityCooldown(Button.SECONDARY_FIRE, 0)
    eventPlayer.setAbilityCooldown(Button.ULTIMATE, 0)
