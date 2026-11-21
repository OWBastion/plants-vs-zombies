#!mainFile "../../../main.opy"

# 亡语: 阵亡后爆炸, 对 25 米内的敌人造成你 50% 最大生命值的伤害。
# 必须先快照坐标: 重生流程会把玩家传送回出生点, 用 eventPlayer 的实时坐标会炸在重生点。
# 伤害来源传 null: 不计击杀(避免触发心之钢统计)、不触发吸血链与其他"造成伤害"类科技。
# getPlayersInRadius 会带上死亡玩家, 这里按存活过滤。
#!define FESKA_DEATH_RATTLE_RADIUS 25
#!define FESKA_DEATH_RATTLE_SHARE 0.5
#!define UPGRADE_ROW_DEATH_RATTLE ["亡语", "阵亡后造成爆炸，对 25 米范围内的敌人造成你 50% 最大生命值的伤害", UPGRADE_KIND_TECH, 0, 1, 0, 0, 0, abilityIconString(Hero.JUNKRAT, Button.ABILITY_1), []]

rule "Feska - Death rattle":
    @Event playerDied
    @Team 2
    @Condition Tech_Id.DEATH_RATTLE in eventPlayer.Owned_Tech_Ids

    Death_Rattle_Position = eventPlayer.getPosition()
    playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, Color.RED, Death_Rattle_Position, 1)
    damage(getPlayersInRadius(Death_Rattle_Position, FESKA_DEATH_RATTLE_RADIUS, Team.1, LosCheck.SURFACES).filter(lambda player: player.isAlive()), null, feskaMaxHealth(eventPlayer) * FESKA_DEATH_RATTLE_SHARE)
