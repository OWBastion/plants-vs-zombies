# 内置界面(英雄面板与顶部模式 HUD)与本模式无关, 进房即隐藏, 只保留自定义文本
rule "Players - HUD - Hide built-in HUD":
    @Event playerJoined
    @Team 2

    eventPlayer.disableHeroHud()
    eventPlayer.disableGamemodeHud()


rule "Hud text":
    hudSubheader(getAllPlayers(), "植物大战僵尸 PvE（BMAMW）", HudPosition.RIGHT, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    hudSubheader(getAllPlayers(), "选择植物并保护你的脑子（白色光柱）", HudPosition.RIGHT, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    hudSubheader(getAllPlayers(), "准备时间结束后将不能移动", HudPosition.RIGHT, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)


# 顶部居中是模式自带的 HUD 区域, 自定义内容放到左侧避免挤压
rule "Players - HUD - Show round":
    @Condition Current_Round < Config_Total_Round

    hudHeader(getPlayers(Team.2), "第 {0}/{1} 波".format(Current_Round, Config_Total_Round), HudPosition.LEFT, -3, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    hudSubtext(getPlayers(Team.2), "准备时间 {0}s".format(ceil(Round_Lead_Time)) if Under_Attack == false else "当前波次 {0}s".format(ceil(Round_Attack_Time)), HudPosition.LEFT, -2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
