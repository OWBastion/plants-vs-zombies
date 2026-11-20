#!mainFile "../main.opy"

# 与 main.opy 设置说明里的版本号保持一致。
#!define MODE_VERSION "v2025.0528.1"

# 当前阶段已过去的比例(0-100): 进攻期按进攻计时, 准备期按准备计时。
#!define hudWaveProgress() 100 * (1 - (Wave_Attack_Time_Left / Wave_Attack_Duration if Is_Attack_Phase else Wave_Prep_Time_Left / Wave_Prep_Duration))
#!define hudWaveNumber() (Current_Wave if Is_Attack_Phase else Current_Wave + 1)
#!define hudTechIcon(p, i) (Upgrade_Catalog[p.Owned_Tech_Ids[i]][UPGRADE_COLUMN_ICON] if len(p.Owned_Tech_Ids) > i else iconString(Icon.RING_THIN))
# 左侧队伍科技栏: 每个玩家槽位一行, 槽位无人时整行不可见; 只对该槽位的玩家求值。
# 颜色标签依赖 main.opy 的 #!setupTags; 每个观看者的本地玩家那一行显示为黄色。
#!define hudTechRow(slot) hudSubtext(getPlayers(Team.2) if len(getPlayers(Team.2)) > slot else [], getPlayers(Team.2).slice(slot, 1).map(lambda p: "{0} <fg{1}>{2}</fg>  {3}{4}{5}{6}".format(heroIcon(p.getHero()), "F2C14EFF" if p == localPlayer else "FFFFFFFF", p, hudTechIcon(p, 0), hudTechIcon(p, 1), hudTechIcon(p, 2), hudTechIcon(p, 3)))[0], HudPosition.LEFT, slot + 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)


rule "Players - HUD - Hide built-in HUD":
    @Event playerJoined
    @Team 2

    eventPlayer.disableGamemodeHud()


rule "Hud text":
    hudSubheader(getAllPlayers(), "选择植物并保护你的脑子（白色光柱）", HudPosition.RIGHT, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    hudSubheader(getAllPlayers(), "准备时间结束后将不能移动", HudPosition.RIGHT, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)


rule "Players - HUD - Show round":
    hudHeader(getAllPlayers(), "植物大战僵尸 PvE  {0}".format(MODE_VERSION), HudPosition.TOP, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    progressBarHud(getAllPlayers(), hudWaveProgress(), "第 {0}/{1} 波  {2} {3}s".format(hudWaveNumber(), Total_Wave_Count, "进攻" if Is_Attack_Phase else "准备", ceil(Wave_Attack_Time_Left if Is_Attack_Phase else Wave_Prep_Time_Left)), HudPosition.TOP, 1, Color.RED if Is_Attack_Phase else Color.GREEN, Color.WHITE, ProgressHudReeval.VISIBILITY_VALUES_AND_COLOR)


rule "Players - HUD - Show team tech":
    hudHeader(getPlayers(Team.2), "费斯卡科技 {0}/{1}".format(len(localPlayer.Owned_Tech_Ids), MAX_TECH_COUNT), HudPosition.LEFT, 0, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING)
    hudTechRow(0)
    hudTechRow(1)
    hudTechRow(2)
    hudTechRow(3)
    hudTechRow(4)
    hudTechRow(5)


# 个人属性放在屏幕下方, 位置沿用选卡界面的视角锚点。
rule "Players - HUD - Show own stats":
    createInWorldText(localPlayer if localPlayer.Is_Initialized else [], "伤害 +{0}%  生命 {1}%  治疗 +{2}%\n护甲 +{3}  减伤 {4}%  受疗 +{5}%  抗击退 {6}%  充能 +{7}%/秒\n成长基准 第 {8} 波  心之钢 +{9}  护盾/血肉 +{10}".format(localPlayer.Bonus_By_Stat[Stat_Bonus.DAMAGE], 100 + localPlayer.Bonus_By_Stat[Stat_Bonus.HEALTH], localPlayer.Bonus_By_Stat[Stat_Bonus.HEALING], 25 * localPlayer.Bonus_By_Stat[Stat_Bonus.ARMOR], localPlayer.Bonus_By_Stat[Stat_Bonus.DAMAGE_REDUCTION], 10 * localPlayer.Bonus_By_Stat[Stat_Bonus.HEALING_RECEIVED], 10 * localPlayer.Bonus_By_Stat[Stat_Bonus.KNOCKBACK_RESISTANCE], 0.2 * localPlayer.Bonus_By_Stat[Stat_Bonus.ULTIMATE_CHARGE], Current_Wave if Is_Attack_Phase else Finished_Wave_Count + 1, round(1 + 24 * feskaPreviewProgress()), round(50 + 200 * feskaPreviewProgress())), feskaCardPosition(0, -1.25), 1, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.WHITE, SpecVisibility.NEVER)
