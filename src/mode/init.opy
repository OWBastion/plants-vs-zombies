rule "Copyright (c) 2025 他又（aka Teakowa）":
    disableInspector()
    Tank_Heros = getTankHeroes()
    Damage_Heros = getDamageHeroes()
    Support_Heros = getSupportHeroes()
    Tank_Heros.remove(Hero.WRECKING_BALL)
    Damage_Heros.remove(Hero.VENTURE)


rule "Initialize global variables":
    Debug = createWorkshopSettingBool("Debug", "Debug开关", false, 100)
    Config_Total_Round = createWorkshopSettingInt("模式", "最大攻击波次", 12, 4, 36, 12)
    Difficult = createWorkshopSettingEnum("模式", "难度", 0, ["简单： AI 逐渐生成至上限", "困难：AI 在第6波达到生成上限", "专家：AI 在第4波达到生成上限", "苦难：AI 在第1波达到生成上限"])
    NumberOfZombies = createWorkshopSettingInt("模式", "AI 上限", 13, 4, 16, 15)
    Config_Round_Attack_Time = createWorkshopSettingInt("模式", "攻击波持续时间", 300, 30, 600, 13)
    Config_Round_Lead_Time = createWorkshopSettingInt("模式", "攻击波间隔时间", 30, 15, 60, 14)
    Round_Lead_Time = Config_Round_Lead_Time
    Round_Attack_Time = Config_Round_Attack_Time
    ANTI_CRASH_ACTIVATE_PERCENT = createWorkshopSettingInt("Anti Crash", "激活阈值", 230, 0, 250)
    ANTI_CRASH_HOLD_TIME = createWorkshopSettingFloat("Anti Crash", "激活持续时间", 8, 0, 20, 1)
    ANTI_CRASH_DEACTIVATE_PERCENT = createWorkshopSettingInt("Anti Crash", "停用阈值", 180, 0, 250, 2)
    Hero_BAN[0] = createWorkshopSettingInt("英雄池", "随机英雄池：重装", 4, 1, 6, 11)
    Hero_BAN[1] = createWorkshopSettingInt("英雄池", "随机英雄池：输出", 8, 1, 12, 12)
    Hero_BAN[2] = createWorkshopSettingInt("英雄池", "随机英雄池：支援", 4, 1, 6, 13)


rule "[Anti Crash]: Activate anti crash":
    @Condition getServerLoad() > ANTI_CRASH_ACTIVATE_PERCENT

    wait(ANTI_CRASH_HOLD_TIME, Wait.ABORT_WHEN_FALSE)
    smallMessage(getAllPlayers(), "  服务器过载  ")
    setSlowMotion(1)
    wait(0.5)
    waitUntil(getServerLoad() < ANTI_CRASH_DEACTIVATE_PERCENT, 999999986991104)
    setSlowMotion(100)


rule "[Global]Setup Blacklist":
    N = []
    N.append("永远有多远-十六岁添柴少年-枫叶红时多可怜-再见-毒蛇堂堂主山鸡-呆头飞鸟阿羞羞-马萨国人-老八没有饱疲-XHeAns-李面瘫-爆裂黎明".split("-"))
    N.append("易千万-贪睡之熊-八十八岁八世同堂-情绪化的小腻腻-真白-暗夜之鸦-忧郁小恶魔-星空-李秋实-老牛带你入坑-秋沫-cosmic-青云子".split("-"))
    N.append("修改回忆中的你-荔枝汽水-港九九九-她说那天只是阳了-你男神王守义-月照七星北斗-疯间彻-无敌叮当大王-宇冉-Tragheir-枫桥踏雪歌".split("-"))
    N.append("小涵是人间理想-萨克斯-老板放过我吧-茉莉小哥-她曾胜过世间所有-呆萌学徒法师-烫头纹身真男人-RunXenia-风催雨-春和景明-别烦".split("-"))
    N.append("小千丶云长-暗影之风暴-teaser1225-前尘舊夢".split("-"))


rule "[Player]Remove Player from Blacklist":
    @Event playerJoined
    @Team 2
    @Condition "{0}".format(eventPlayer) in N == true

    eventPlayer.removeFromGame()


rule "[Mode]: setup zombie heros":
    Zombie_Heros = []
    Zombie_Heros.append(Hero.DVA)
    Zombie_Heros.append(Hero.ORISA)
    Zombie_Heros.append(Hero.RAMATTRA)
    Zombie_Heros.append(Hero.DOOMFIST)
    Zombie_Heros.append(Hero.ZARYA)
    Zombie_Heros.append(Hero.MAUGA)
    Zombie_Heros.append(Hero.JUNKER_QUEEN)
    Zombie_Heros.append(Hero.WINSTON)
    Zombie_Heros.append(Hero.REINHARDT)
    Zombie_Heros.append(Hero.SIGMA)
    Zombie_Heros.append(Hero.ROADHOG)
    Zombie_Heros.append(Hero.HAZARD)
    Zombie_Heros.append(Hero.HANZO)
    Zombie_Heros.append(Hero.CASSIDY)
    Zombie_Heros.append(Hero.ECHO)
    Zombie_Heros.append(Hero.BASTION)
    Zombie_Heros.append(Hero.SOLDIER)
    Zombie_Heros.append(Hero.FREJA)
    Zombie_Heros.append(Hero.TORBJORN)
    Zombie_Heros.append(Hero.VENTURE)
    Zombie_Heros.append(Hero.REAPER)
    Zombie_Heros.append(Hero.PHARAH)
    Zombie_Heros.append(Hero.GENJI)
    Zombie_Heros.append(Hero.TRACER)
    Zombie_Heros.append(Hero.SYMMETRA)
    Zombie_Heros.append(Hero.SOJOURN)
    Zombie_Heros.append(Hero.ASHE)
    Zombie_Heros.append(Hero.SOMBRA)
    Zombie_Heros.append(Hero.WIDOWMAKER)
    Zombie_Heros.append(Hero.ILLARI)
    Zombie_Heros.append(Hero.LUCIO)
    Zombie_Heros.append(Hero.ANA)
    Zombie_Heros.append(Hero.BAPTISTE)
    Zombie_Heros.append(Hero.BRIGITTE)
    Zombie_Heros.append(Hero.JUNO)
    Zombie_Heros.append(Hero.ZENYATTA)
    Zombie_Heros.append(Hero.MOIRA)
    Zombie_Heros.append(Hero.KIRIKO)


rule "[Player]: Override allowed heroes list when player joins lobby":
    @Event playerJoined
    @Team 2

    if Debug:
        eventPlayer.setAllowedHeroes(getAllHeroes())
    else:
        setPlayerHeros()


def setPlayerHeros():
    @Name "[Player]: set heros"

    eventPlayer.heros = [eventPlayer.getHero()]
    wait(0.16)
    eventPlayer.heros = [random.shuffle(Tank_Heros).slice(0, Hero_BAN[0]), random.shuffle(Damage_Heros).slice(0, Hero_BAN[1]), random.shuffle(Support_Heros).slice(0, Hero_BAN[2])]
    eventPlayer.setAllowedHeroes(eventPlayer.heros)
