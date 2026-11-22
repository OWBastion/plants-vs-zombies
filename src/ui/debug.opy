#!mainFile "../main.opy"

rule "[debug.opy]: player debug (Top Right)":
    @Event eachPlayer
    @Condition Debug_Enabled

    hudSubheader(eventPlayer, "重生室位置 = {0}".format(getSpawnPoints(Team.1).getPosition()), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    hudSubheader(eventPlayer, "重生室 = {0}/{1}".format(getLivingPlayers(Team.1).filter(lambda player: distance(player.getPosition(), getSpawnPoints(Team.1).getPosition()) <= 25), len(getLivingPlayers(Team.1))), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    hudSubheader(eventPlayer, "距离 = {0}".format(distance(eventPlayer.getPosition(), getSpawnPoints(Team.1).getPosition())), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    hudSubheader(eventPlayer, "当前位置 = {0}".format(eventPlayer.getPosition()), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)


rule "[Debug]: Log zombie deaths":
    @Event playerDied
    @Team 1
    @Condition Debug_Enabled

    enableInspector()
    logToInspector("僵尸阵亡 存活 {0}s 位置 {1} 击杀者 {2} 卡死计数 {3} 回合 {4} 进攻中 {5}".format(getTotalTimeElapsed() - eventPlayer.Spawn_Time, eventPlayer.getPosition(), attacker, eventPlayer.No_Progress_Count, Current_Wave, Is_Attack_Phase))


rule "[Debug]: Zombie spawn state":
    @Condition Debug_Enabled

    hudSubheader(getAllPlayers(), "僵尸 总数/存活/配额 = {0}/{1}/{2}".format(getNumberOfPlayers(Team.1), getNumberOfLivingPlayers(Team.1), zombieWaveQuotaNow()), HudPosition.RIGHT, 2, Color.WHITE, HudReeval.STRING)
    hudSubheader(getAllPlayers(), "队列 首位 = {0} 剩余 = {1} 创建失败 = {2}".format(Zombie_Wave_Heroes[0], len(Zombie_Wave_Heroes), Zombie_Spawn_Failures), HudPosition.RIGHT, 3, Color.WHITE, HudReeval.STRING)
    hudSubheader(getAllPlayers(), "在场英雄 = {0}".format(getPlayers(Team.1).map(lambda player: player.getHero())), HudPosition.RIGHT, 4, Color.WHITE, HudReeval.STRING)
