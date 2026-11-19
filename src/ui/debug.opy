#!mainFile "../main.opy"

rule "[debug.opy]: player debug (Top Right)":
    @Event eachPlayer
    @Condition Debug == true

    hudSubheader(eventPlayer, "重生室位置 = {0}".format(getSpawnPoints(Team.1).getPosition()), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    hudSubheader(eventPlayer, "重生室 = {0}/{1}".format(getLivingPlayers(Team.1).filter(lambda player: distance(player.getPosition(), getSpawnPoints(Team.1).getPosition()) <= 25), len(getLivingPlayers(Team.1))), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    hudSubheader(eventPlayer, "距离 = {0}".format(distance(eventPlayer.getPosition(), getSpawnPoints(Team.1).getPosition())), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    hudSubheader(eventPlayer, "当前位置 = {0}".format(eventPlayer.getPosition()), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)


rule "[Debug]: Log zombie deaths":
    @Event playerDied
    @Team 1
    @Condition Debug == true

    enableInspector()
    logToInspector("僵尸阵亡 存活 {0}s 位置 {1} 击杀者 {2} 卡死计数 {3} 回合 {4} 进攻中 {5}".format(getTotalTimeElapsed() - eventPlayer.Spawned_At, eventPlayer.getPosition(), attacker, eventPlayer.stuck_count, Current_Round, Under_Attack))
