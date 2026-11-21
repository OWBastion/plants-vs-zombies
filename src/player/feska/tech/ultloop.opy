#!mainFile "../../../main.opy"

# 迁移自莱因哈特的大招击杀满充能与拉玛刹的大招击杀 +25% 充能, 合并为一张。
# 按用户确认的口径: 只有终极技能造成的击杀才返还 25% 充能。
#!define UPGRADE_ROW_ULTIMATE_LOOP ["终极循环往复", "终极技能消灭敌人时，返还 25% 终极技能充能", UPGRADE_KIND_TECH, 0, 1, 0, 0, 0, abilityIconString(Hero.REINHARDT, Button.ULTIMATE), []]

rule "Feska - Ultimate loop":
    @Event playerDealtFinalBlow
    @Team 2
    @Condition victim.getTeam() == Team.1
    @Condition Tech_Id.ULTIMATE_LOOP in eventPlayer.Owned_Tech_Ids
    @Condition eventAbility == Button.ULTIMATE

    if eventPlayer.getUltCharge() < 100:
        playEffect(eventPlayer, DynamicEffect.SYMMETRA_TELEPORTER_REAPPEAR, Color.AQUA, eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 1.5, 0.5)
    eventPlayer.setUltCharge(min(eventPlayer.getUltCharge() + 25, 100))
