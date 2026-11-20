#!mainFile "../main.opy"

# 与 main.opy 设置说明里的版本号保持一致。
#!define MODE_VERSION "v2025.0528.1"

# 当前阶段剩余时间的比例(0-100): 进攻期按进攻计时, 准备期按准备计时, 条随时间缩短。
#!define hudWaveRemaining() 100 * (Wave_Attack_Time_Left / Wave_Attack_Duration if Is_Attack_Phase else Wave_Prep_Time_Left / Wave_Prep_Duration)
#!define hudWaveNumber() (Current_Wave if Is_Attack_Phase else Current_Wave + 1)
# 左侧列出当前玩家已选的科技: 名称用子标题(字号大), 描述用子文本(字号小), 按排序号交错, 未选的槽位不显示。
#!define hudTechName(slot) hudSubheader(localPlayer if len(localPlayer.Owned_Tech_Ids) > slot else [], Upgrade_Catalog[localPlayer.Owned_Tech_Ids[slot]][UPGRADE_COLUMN_NAME], HudPosition.LEFT, 2 * slot + 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
#!define hudTechDescription(slot) hudSubtext(localPlayer if len(localPlayer.Owned_Tech_Ids) > slot else [], Upgrade_Catalog[localPlayer.Owned_Tech_Ids[slot]][UPGRADE_COLUMN_DESCRIPTION], HudPosition.LEFT, 2 * slot + 2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)


# 属性栏图标; 属性强化没有对应技能, 取含义相近的英雄技能。
#!define HUD_ICON_DAMAGE abilityIconString(Hero.SOLDIER, Button.ULTIMATE)
#!define HUD_ICON_HEALTH abilityIconString(Hero.REINHARDT, Button.ULTIMATE)
#!define HUD_ICON_HEALING abilityIconString(Hero.ANA, Button.PRIMARY_FIRE)
#!define HUD_ICON_ARMOR abilityIconString(Hero.BRIGITTE, Button.ULTIMATE)
#!define HUD_ICON_REDUCTION abilityIconString(Hero.REINHARDT, Button.SECONDARY_FIRE)
#!define HUD_ICON_HEALING_RECEIVED abilityIconString(Hero.MOIRA, Button.PRIMARY_FIRE)
#!define HUD_ICON_KNOCKBACK abilityIconString(Hero.HAZARD, Button.ULTIMATE)
#!define HUD_ICON_ULTIMATE abilityIconString(Hero.ECHO, Button.ULTIMATE)
#!define hudBonus(stat) localPlayer.Bonus_By_Stat[stat]
# 第一行四项始终显示, 其余项数值为 0 时整段不显示, 避免一排 0 挤在一起。
#!define hudStat(icon, shown, text) ("{0}{1}    ".format(icon, text) if shown else "")
#!define hudGrowth(tech, value) ("{0}+{1}    ".format(Upgrade_Catalog[tech][UPGRADE_COLUMN_ICON], value) if tech in localPlayer.Owned_Tech_Ids else "")


rule "Players - HUD - Hide built-in HUD":
    @Event playerJoined
    @Team 2

    eventPlayer.disableGamemodeHud()


rule "Hud text":
    hudSubheader(getAllPlayers(), "选择植物并保护你的脑子（白色光柱）", HudPosition.RIGHT, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    hudSubheader(getAllPlayers(), "准备时间结束后将不能移动", HudPosition.RIGHT, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)


rule "Players - HUD - Show round":
    hudSubheader(getAllPlayers(), "植物大战僵尸 PvE  {0}".format(MODE_VERSION), HudPosition.TOP, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    progressBarHud(getAllPlayers(), hudWaveRemaining(), "第 {0}/{1} 波  {2} {3}s".format(hudWaveNumber(), Total_Wave_Count, "进攻" if Is_Attack_Phase else "准备", ceil(Wave_Attack_Time_Left if Is_Attack_Phase else Wave_Prep_Time_Left)), HudPosition.TOP, 1, Color.RED if Is_Attack_Phase else Color.GREEN, Color.WHITE, ProgressHudReeval.VISIBILITY_VALUES_AND_COLOR)


rule "Players - HUD - Show own tech":
    hudSubheader(getPlayers(Team.2), "费斯卡科技 {0}/{1}".format(len(localPlayer.Owned_Tech_Ids), MAX_TECH_COUNT), HudPosition.LEFT, 0, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING)
    hudTechName(0)
    hudTechDescription(0)
    hudTechName(1)
    hudTechDescription(1)
    hudTechName(2)
    hudTechDescription(2)
    hudTechName(3)
    hudTechDescription(3)


# 个人属性放在屏幕下方: HUD 文本无法直接贴底, 与 Bastion 一样用开头的换行把内容挤到底部。第三行是持有对应科技时的当前成长值。
rule "Players - HUD - Show own stats":
    hudSubtext(localPlayer if localPlayer.Is_Initialized else [], "{0}{1}".format("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n", "{0}{1}{2}{3}\n{4}{5}{6}{7}\n{8}{9}{10}".format(hudStat(HUD_ICON_DAMAGE, true, "+{0}%".format(hudBonus(Stat_Bonus.DAMAGE))), hudStat(HUD_ICON_HEALTH, true, "{0}%".format(100 + hudBonus(Stat_Bonus.HEALTH))), hudStat(HUD_ICON_HEALING, true, "+{0}%".format(hudBonus(Stat_Bonus.HEALING))), hudStat(HUD_ICON_ARMOR, true, "+{0}".format(25 * hudBonus(Stat_Bonus.ARMOR))), hudStat(HUD_ICON_REDUCTION, hudBonus(Stat_Bonus.DAMAGE_REDUCTION) != 0, "{0}%".format(hudBonus(Stat_Bonus.DAMAGE_REDUCTION))), hudStat(HUD_ICON_HEALING_RECEIVED, hudBonus(Stat_Bonus.HEALING_RECEIVED) != 0, "+{0}%".format(10 * hudBonus(Stat_Bonus.HEALING_RECEIVED))), hudStat(HUD_ICON_KNOCKBACK, hudBonus(Stat_Bonus.KNOCKBACK_RESISTANCE) != 0, "{0}%".format(10 * hudBonus(Stat_Bonus.KNOCKBACK_RESISTANCE))), hudStat(HUD_ICON_ULTIMATE, hudBonus(Stat_Bonus.ULTIMATE_CHARGE) != 0, "+{0}%/秒".format(0.2 * hudBonus(Stat_Bonus.ULTIMATE_CHARGE))), hudGrowth(Tech_Id.HEARTSTEEL, round(1 + 24 * feskaPreviewProgress())), hudGrowth(Tech_Id.FLESH_REGENERATION, round(50 + 200 * feskaPreviewProgress())), hudGrowth(Tech_Id.SHIELD, round(50 + 200 * feskaPreviewProgress())))), HudPosition.TOP, 9, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
