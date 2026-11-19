# 心灵净化 (T_PURGE = 14)
# 最后一击引爆目标, 对其 5 米内其他僵尸造成 60 点伤害。
#!define FESKA_ROW_PURGE ["心灵净化", "最后一击引爆目标\n对其 5 米内其他僵尸造成 60 点伤害", 1, 0, 1, 0, 0, 0]

rule "Feska - Soul purge":
    @Event playerDealtFinalBlow
    @Team 2
    @Condition victim.getTeam() == Team.1
    @Condition T_PURGE in eventPlayer.feska_tech
    @Condition eventPlayer.feska_chain != true

    # 派生伤害期间关闭引爆, 避免连锁爆炸递归。
    eventPlayer.feska_chain = true
    playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, Color.BLUE, victim, 1)
    damage(getPlayersInRadius(victim, 5, Team.1, LosCheck.SURFACES).filter(lambda player: player != victim), eventPlayer, 60)
    wait(0.032)
    eventPlayer.feska_chain = false
