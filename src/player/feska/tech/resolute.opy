#!mainFile "../../../main.opy"

# 坚韧: 受到伤害后, 接下来 4 秒内受到的伤害降低 40%。
# 单一时间戳窗口: 窗口内再次受击只把到期时间往后推, 不叠层。
#!define FESKA_RESOLUTE_SECONDS 4
#!define UPGRADE_ROW_RESOLUTE ["坚韧", "受到伤害后，接下来 4 秒内受到的伤害降低 40%", UPGRADE_KIND_TECH, 0, 1, 0, 0, 0, abilityIconString(Hero.REINHARDT, Button.SECONDARY_FIRE), []]

rule "Feska - Resolute":
    @Event playerTookDamage
    @Team 2
    @Condition Is_Attack_Phase
    @Condition Tech_Id.RESOLUTE in eventPlayer.Owned_Tech_Ids
    @Condition eventPlayer.isAlive()
    @Condition eventDamage > 0
    @Condition attacker != null
    @Condition attacker != eventPlayer

    if eventPlayer.Is_Resolute != true:
        eventPlayer.Is_Resolute = true
        feskaRefreshMods()
    eventPlayer.Resolute_Until = getTotalTimeElapsed() + FESKA_RESOLUTE_SECONDS


rule "Feska - Resolute expire":
    @Event eachPlayer
    @Team 2
    @Condition eventPlayer.Is_Resolute
    @Condition getTotalTimeElapsed() >= eventPlayer.Resolute_Until

    eventPlayer.Is_Resolute = false
    feskaRefreshMods()
