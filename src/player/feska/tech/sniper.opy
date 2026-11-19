#!mainFile "../../../main.opy"

#!define UPGRADE_ROW_SNIPER ["老练狙神", "对 15 米外敌人造成伤害时\n返还该技能 70% 剩余冷却", 1, 0, 1, 0, 0, 0]

rule "Feska - Sniper":
    @Event playerDealtDamage
    @Team 2
    @Condition victim.getTeam() == Team.1
    @Condition TechId.SNIPER in eventPlayer.tech
    @Condition eventAbility in [Button.ABILITY_1, Button.ABILITY_2, Button.SECONDARY_FIRE]
    @Condition distance(eventPlayer, victim) >= 15

    # 只在技能确实处于冷却时返还剩余冷却的 70%, 弹丸命中时冷却尚未启动的技能不参与。
    if eventPlayer.getAbilityCooldown(eventAbility) > 0:
        eventPlayer.setAbilityCooldown(eventAbility, eventPlayer.getAbilityCooldown(eventAbility) * 0.3)
