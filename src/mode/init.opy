#!mainFile "../main.opy"

rule "Copyright (c) 2025 他又（aka Teakowa）":
    disableInspector()
    Tank_Hero_Pool = getTankHeroes()
    Damage_Hero_Pool = getDamageHeroes()
    Support_Hero_Pool = getSupportHeroes()
    Tank_Hero_Pool.remove(Hero.WRECKING_BALL)
    Damage_Hero_Pool.remove(Hero.VENTURE)


rule "Initialize global variables":
    Debug_Enabled = createWorkshopSettingBool("Debug", "Debug开关", false, 100)
    Total_Wave_Count = createWorkshopSettingInt("模式", "最大攻击波次", 12, 4, 36, 12)
    Difficulty_Level = createWorkshopSettingEnum("模式", "难度", 0, ["简单： AI 逐渐生成至上限", "困难：AI 在第6波达到生成上限", "专家：AI 在第4波达到生成上限", "苦难：AI 在第1波达到生成上限"])
    Zombie_Alive_Limit = createWorkshopSettingInt("模式", "AI 上限", 13, 4, 16, 15)
    Wave_Attack_Duration = createWorkshopSettingInt("模式", "攻击波持续时间", 300, 30, 600, 13)
    Wave_Prep_Duration = createWorkshopSettingInt("模式", "攻击波间隔时间", 30, 15, 60, 14)
    Wave_Prep_Time_Left = Wave_Prep_Duration
    Wave_Attack_Time_Left = Wave_Attack_Duration
    Hero_Pool_Size_By_Role[0] = createWorkshopSettingInt("英雄池", "随机英雄池：重装", 4, 1, 6, 11)
    Hero_Pool_Size_By_Role[1] = createWorkshopSettingInt("英雄池", "随机英雄池：输出", 8, 1, 12, 12)
    Hero_Pool_Size_By_Role[2] = createWorkshopSettingInt("英雄池", "随机英雄池：支援", 4, 1, 6, 13)


rule "[Global]Setup N":
    Blocked_Player_Names = []
    Blocked_Player_Names.append("永远有多远-十六岁添柴少年-枫叶红时多可怜-再见-毒蛇堂堂主山鸡-呆头飞鸟阿羞羞-马萨国人-老八没有饱疲-XHeAns-李面瘫-爆裂黎明".split("-"))
    Blocked_Player_Names.append("易千万-贪睡之熊-八十八岁八世同堂-情绪化的小腻腻-真白-暗夜之鸦-忧郁小恶魔-星空-李秋实-老牛带你入坑-秋沫-cosmic-青云子".split("-"))
    Blocked_Player_Names.append("修改回忆中的你-荔枝汽水-港九九九-她说那天只是阳了-你男神王守义-月照七星北斗-疯间彻-无敌叮当大王-宇冉-Tragheir-枫桥踏雪歌".split("-"))
    Blocked_Player_Names.append("小涵是人间理想-萨克斯-老板放过我吧-茉莉小哥-她曾胜过世间所有-呆萌学徒法师-烫头纹身真男人-RunXenia-风催雨-春和景明-别烦".split("-"))
    Blocked_Player_Names.append("小千丶云长-暗影之风暴-teaser1225-前尘舊夢".split("-"))


rule "[Player]Remove Player from N":
    @Event playerJoined
    @Team 2
    @Condition "{0}".format(eventPlayer) in Blocked_Player_Names

    eventPlayer.removeFromGame()


rule "[Mode]: setup zombie heros":
    Zombie_Hero_Pool = []
    Zombie_Hero_Pool.append(Hero.DVA)
    Zombie_Hero_Pool.append(Hero.ORISA)
    Zombie_Hero_Pool.append(Hero.RAMATTRA)
    Zombie_Hero_Pool.append(Hero.DOOMFIST)
    Zombie_Hero_Pool.append(Hero.ZARYA)
    Zombie_Hero_Pool.append(Hero.MAUGA)
    Zombie_Hero_Pool.append(Hero.JUNKER_QUEEN)
    Zombie_Hero_Pool.append(Hero.WINSTON)
    Zombie_Hero_Pool.append(Hero.REINHARDT)
    Zombie_Hero_Pool.append(Hero.SIGMA)
    Zombie_Hero_Pool.append(Hero.ROADHOG)
    Zombie_Hero_Pool.append(Hero.HAZARD)
    Zombie_Hero_Pool.append(Hero.HANZO)
    Zombie_Hero_Pool.append(Hero.CASSIDY)
    Zombie_Hero_Pool.append(Hero.ECHO)
    Zombie_Hero_Pool.append(Hero.BASTION)
    Zombie_Hero_Pool.append(Hero.SOLDIER)
    Zombie_Hero_Pool.append(Hero.FREJA)
    Zombie_Hero_Pool.append(Hero.TORBJORN)
    Zombie_Hero_Pool.append(Hero.VENTURE)
    Zombie_Hero_Pool.append(Hero.REAPER)
    Zombie_Hero_Pool.append(Hero.PHARAH)
    Zombie_Hero_Pool.append(Hero.GENJI)
    Zombie_Hero_Pool.append(Hero.TRACER)
    Zombie_Hero_Pool.append(Hero.SYMMETRA)
    Zombie_Hero_Pool.append(Hero.SOJOURN)
    Zombie_Hero_Pool.append(Hero.ASHE)
    Zombie_Hero_Pool.append(Hero.SOMBRA)
    Zombie_Hero_Pool.append(Hero.WIDOWMAKER)
    Zombie_Hero_Pool.append(Hero.ILLARI)
    Zombie_Hero_Pool.append(Hero.LUCIO)
    Zombie_Hero_Pool.append(Hero.ANA)
    Zombie_Hero_Pool.append(Hero.BAPTISTE)
    Zombie_Hero_Pool.append(Hero.BRIGITTE)
    Zombie_Hero_Pool.append(Hero.JUNO)
    Zombie_Hero_Pool.append(Hero.ZENYATTA)
    Zombie_Hero_Pool.append(Hero.MOIRA)
    Zombie_Hero_Pool.append(Hero.KIRIKO)


rule "[Player]: Override allowed heroes list when player joins lobby":
    @Event playerJoined
    @Team 2

    if Debug_Enabled:
        eventPlayer.setAllowedHeroes(getAllHeroes())
    else:
        applyAllowedHeroes()


def applyAllowedHeroes():
    @Name "[Player]: set heros"

    eventPlayer.Allowed_Hero_Pool = [eventPlayer.getHero()]
    wait(0.16)
    eventPlayer.Allowed_Hero_Pool = [random.shuffle(Tank_Hero_Pool).slice(0, Hero_Pool_Size_By_Role[0]), random.shuffle(Damage_Hero_Pool).slice(0, Hero_Pool_Size_By_Role[1]), random.shuffle(Support_Hero_Pool).slice(0, Hero_Pool_Size_By_Role[2])]
    eventPlayer.setAllowedHeroes(eventPlayer.Allowed_Hero_Pool)
