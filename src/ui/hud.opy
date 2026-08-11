rule "Hud text":
    hudSubheader(getAllPlayers(), "植物大战僵尸 PvE（BMAMW）", HudPosition.RIGHT, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    hudSubheader(getAllPlayers(), "选择植物并保护你的脑子（白色光柱）", HudPosition.RIGHT, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    hudSubheader(getAllPlayers(), "准备时间结束后将不能移动", HudPosition.RIGHT, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)


rule "Players - HUD - Show round":
    @Condition Current_Round < Config_Total_Round

    hudText(getPlayers(Team.2), null, "\n\r\n\r\n\r\n\r\n\r", "第 {0}/{1} 波".format(Current_Round, Config_Total_Round), HudPosition.TOP, -3, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    hudSubtext(getPlayers(Team.2), "准备时间 {0}s".format(ceil(Round_Lead_Time)) if Under_Attack == false else "当前波次 {0}s".format(ceil(Round_Attack_Time)), HudPosition.TOP, -2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
