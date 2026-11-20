#!mainFile "../../main.opy"

rule "[Cassidy.opy]: Revert sniper damage falloff":
    @Event playerDealtDamage
    @Team 2
    @Hero cassidy
    @Condition eventAbility == Button.PRIMARY_FIRE
    @Condition distance(attacker.getEyePosition(), victim) >= 25.1

    eventPlayer.Shot_Distance = distance(attacker.getEyePosition(), victim)
    #原OW2衰减计算（25-35米 70%衰减）
    eventPlayer.Observed_Falloff_Ratio = 1 - (((eventPlayer.Shot_Distance - 25) / 10) * 0.7) + (1 - ((eventPlayer.Shot_Distance - 25) / 10))
    if eventPlayer.Observed_Falloff_Ratio > 1:
        eventPlayer.Observed_Falloff_Ratio = 1
    elif eventPlayer.Observed_Falloff_Ratio < 0.3:
        eventPlayer.Observed_Falloff_Ratio = 0.3
    eventPlayer.Raw_Damage_Before_Falloff = eventDamage / eventPlayer.Observed_Falloff_Ratio
    eventPlayer.Target_Falloff_Ratio = 1 - (((eventPlayer.Shot_Distance - 25) / 25) * 0.3)
    if eventPlayer.Target_Falloff_Ratio < 0.7:
        eventPlayer.Target_Falloff_Ratio = 0.7
    if eventPlayer.Shot_Distance > 50:
        eventPlayer.Target_Falloff_Ratio = 0.7
    eventPlayer.Recalculated_Damage = eventPlayer.Raw_Damage_Before_Falloff * eventPlayer.Target_Falloff_Ratio
    damage(victim, attacker, ceil(eventPlayer.Recalculated_Damage - eventDamage))


rule "[Cassdy] Peacekeeper Alt Fire":
    @Event eachPlayer
    @Team 2
    @Hero cassidy
    @Condition eventPlayer.isFiringSecondaryFire() == true

    eventPlayer.setDamageDealt(180)
    waitUntil(not eventPlayer.isFiringSecondaryFire(), 0.75)
    eventPlayer.setDamageDealt(100)
