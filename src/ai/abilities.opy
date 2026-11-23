#!mainFile "../main.opy"

rule "[ai]: Base Melee":
    @Event eachPlayer
    @Team 1
    @Condition eventPlayer.isAlive()
    @Condition eventPlayer.isDummy()
    @Condition isGameInProgress()
    @Condition Is_Attack_Phase
    @Condition eventPlayer.Chase_Target_Player != null
    @Condition eventPlayer.Chase_Target_Player.isAlive()
    # 只有"按住副武器就完全打不出攻击"的持续技能才挡住近战: 莱因哈特屏障/西格玛吸收/拉玛刹格挡。
    # 其余技能不再挡住近战, 引擎会自己忽略当前状态下无效的那次挥击。
    @Condition eventPlayer.getHero() not in [Hero.REINHARDT, Hero.SIGMA, Hero.RAMATTRA] or not eventPlayer.isHoldingButton(Button.SECONDARY_FIRE)
    # 大招期间默认交给引擎判断; 温斯顿与源氏的普攻本身就是近战, 必须继续出手。
    @Condition not eventPlayer.isUsingUltimate() or eventPlayer.getHero() in [Hero.WINSTON, Hero.GENJI]
    @Condition distance(eventPlayer, eventPlayer.Chase_Target_Player) <= ZOMBIE_MELEE_RANGE

    wait(0.15, Wait.ABORT_WHEN_FALSE)
    eventPlayer.forceButtonPress(Button.MELEE)
    wait(0.5)
    if ruleCondition:
        loop()


rule "[ai]: Use Hero Abilities":
    @Event eachPlayer
    @Team 1
    @Condition eventPlayer.isDummy()
    @Condition eventPlayer.isAlive()
    @Condition Is_Attack_Phase
    @Condition eventPlayer.getHero() in [Hero.DVA, Hero.MAUGA, Hero.WINSTON, Hero.REINHARDT, Hero.HAZARD, Hero.ECHO, Hero.BASTION, Hero.SOLDIER, Hero.FREJA, Hero.REAPER, Hero.GENJI, Hero.TRACER, Hero.SOJOURN, Hero.ILLARI, Hero.BAPTISTE, Hero.JUNO, Hero.SIGMA, Hero.MOIRA]

    # 贴身时优先普攻: 冲刺/举盾/吸收/幽灵形态/消失这几项在近战距离会挡住自己的攻击, 其余技能照常使用。
    if (not zombieInMeleeRange() or eventPlayer.getHero() not in [Hero.SOLDIER, Hero.SIGMA, Hero.REINHARDT, Hero.REAPER, Hero.MOIRA]) and not eventPlayer.isUsingAbility1() and not eventPlayer.isUsingAbility2() and not eventPlayer.isUsingUltimate():
        if eventPlayer.getHero() != Hero.SIGMA and eventPlayer.getAbilityCooldown(Button.ABILITY_1) == 0:
            if eventPlayer.getHero() == Hero.SOLDIER:
                eventPlayer.startForcingButton(Button.ABILITY_1)
                waitUntil(not eventPlayer.isAlive() or not Is_Attack_Phase or zombieInMeleeRange(), 4)
                eventPlayer.stopForcingButton(Button.ABILITY_1)
            else:
                eventPlayer.forceButtonPress(Button.ABILITY_1)
        elif eventPlayer.getHero() in [Hero.ILLARI, Hero.BAPTISTE, Hero.JUNO, Hero.MAUGA] and eventPlayer.getAbilityCooldown(Button.ABILITY_2) == 0:
            eventPlayer.forceButtonPress(Button.ABILITY_2)
        elif eventPlayer.getHero() in [Hero.SIGMA, Hero.REINHARDT] and eventPlayer.getAbilityCooldown(Button.SECONDARY_FIRE) == 0:
            eventPlayer.startForcingButton(Button.SECONDARY_FIRE)
            # 走到近战距离就收盾, 否则会一直挡着自己的攻击。
            waitUntil(not eventPlayer.isAlive() or not Is_Attack_Phase or zombieInMeleeRange(), 4)
            eventPlayer.stopForcingButton(Button.SECONDARY_FIRE)
    wait(1, Wait.ABORT_WHEN_FALSE)
    if ruleCondition:
        loop()


# 温斯顿屏障: 冷却好就放。Jump Pack 走通用规则的 ABILITY_1, 这里补 ABILITY_2(屏障发射器)。
rule "[ai]: Winston Use Barrier":
    @Event eachPlayer
    @Team 1
    @Hero winston
    @Condition eventPlayer.isDummy()
    @Condition eventPlayer.isAlive()
    @Condition Is_Attack_Phase
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_2) == 0

    eventPlayer.forceButtonPress(Button.ABILITY_2)
    wait(1, Wait.ABORT_WHEN_FALSE)
    if ruleCondition:
        loop()


# 标枪旋转(E): 装备设置里僵尸奥丽莎原本禁用了技能2。旋转期间无法攻击, 贴身时只普攻。
rule "[ai]: Orisa Use Ability 2":
    @Event eachPlayer
    @Team 1
    @Hero orisa
    @Condition eventPlayer.isDummy()
    @Condition eventPlayer.isAlive()
    @Condition Is_Attack_Phase
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_2) == 0
    @Condition not zombieInMeleeRange()

    eventPlayer.forceButtonPress(Button.ABILITY_2)
    wait(1, Wait.ABORT_WHEN_FALSE)
    if ruleCondition:
        loop()


rule "[ai]: Zarya Use Barrier":
    @Event eachPlayer
    @Team 1
    @Hero zarya
    @Condition eventPlayer.isDummy()
    @Condition eventPlayer.isAlive()
    @Condition Is_Attack_Phase
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_1) == 0

    eventPlayer.forceButtonPress(Button.ABILITY_1)
    wait(1, Wait.ABORT_WHEN_FALSE)
    if ruleCondition:
        loop()


rule "[ai]: Orisa Use Fortify":
    @Event eachPlayer
    @Team 1
    @Hero orisa
    @Condition eventPlayer.isDummy()
    @Condition eventPlayer.isAlive()
    @Condition Is_Attack_Phase
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_1) == 0

    eventPlayer.forceButtonPress(Button.ABILITY_1)
    wait(1, Wait.ABORT_WHEN_FALSE)
    if ruleCondition:
        loop()


rule "[ai]: Cassidy Use Roll":
    @Event eachPlayer
    @Team 1
    @Hero cassidy
    @Condition eventPlayer.isDummy()
    @Condition eventPlayer.isAlive()
    @Condition Is_Attack_Phase
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_1) == 0

    eventPlayer.forceButtonPress(Button.ABILITY_1)
    wait(1, Wait.ABORT_WHEN_FALSE)
    if ruleCondition:
        loop()


rule "[ai]: Lucio Speed Song":
    @Event eachPlayer
    @Team 1
    @Hero lucio
    @Condition eventPlayer.isDummy()
    @Condition eventPlayer.isAlive()
    @Condition Is_Attack_Phase

    eventPlayer.forceButtonPress(Button.ABILITY_1)
    waitUntil(not eventPlayer.isAlive() or not Is_Attack_Phase, 999999986991104)


rule "[ai]: Lucio Amp":
    @Event eachPlayer
    @Team 1
    @Hero lucio
    @Condition eventPlayer.isDummy()
    @Condition eventPlayer.isAlive()
    @Condition Is_Attack_Phase
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_2) == 0

    eventPlayer.forceButtonPress(Button.ABILITY_2)
    wait(1, Wait.ABORT_WHEN_FALSE)
    if ruleCondition:
        loop()


rule "[ai]: Roadhog Use Breather":
    @Event eachPlayer
    @Team 1
    @Hero roadhog
    @Condition eventPlayer.isDummy()
    @Condition eventPlayer.isAlive()
    @Condition Is_Attack_Phase
    @Condition eventPlayer.getHealth() <= eventPlayer.getMaxHealth() * 0.5
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_2) == 0

    eventPlayer.forceButtonPress(Button.ABILITY_2)
    wait(3)
    if ruleCondition:
        loop()


rule "[ai]: Junker Queen Use Shout":
    @Event eachPlayer
    @Team 1
    @Hero junker_queen
    @Condition eventPlayer.isDummy()
    @Condition eventPlayer.isAlive()
    @Condition Is_Attack_Phase
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_1) == 0

    eventPlayer.forceButtonPress(Button.ABILITY_1)
    wait(1, Wait.ABORT_WHEN_FALSE)
    if ruleCondition:
        loop()


rule "[ai]: Torbjorn Use Overload":
    @Event eachPlayer
    @Team 1
    @Hero torbjorn
    @Condition eventPlayer.isDummy()
    @Condition eventPlayer.isAlive()
    @Condition Is_Attack_Phase
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_2) == 0

    eventPlayer.forceButtonPress(Button.ABILITY_2)
    wait(1, Wait.ABORT_WHEN_FALSE)
    if ruleCondition:
        loop()


rule "[ai]: venture Use Ability 1":
    @Event eachPlayer
    @Team 1
    @Hero venture
    @Condition eventPlayer.isAlive()
    @Condition isGameInProgress()
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_1) == 0
    @Condition Is_Attack_Phase
    # 钻地期间无法攻击, 贴身时只普攻。
    @Condition not zombieInMeleeRange()

    wait(0.1, Wait.ABORT_WHEN_FALSE)
    eventPlayer.forceButtonPress(Button.ABILITY_1)
    wait(3.6)
    eventPlayer.forceButtonPress(Button.JUMP)
    if ruleCondition:
        loop()


# 大招: 名单内英雄充能满即释放; 按下后充能归零, 条件自然失效。
# 新增英雄需同时在 main.opy 的 team1 设置里放开终极技能。
#!define AI_ULT_HEROES [Hero.LUCIO, Hero.ZENYATTA, Hero.BRIGITTE]

rule "[ai]: Use Ultimate":
    @Event eachPlayer
    @Team 1
    @Condition eventPlayer.isDummy()
    @Condition eventPlayer.isAlive()
    @Condition Is_Attack_Phase
    @Condition eventPlayer.getHero() in AI_ULT_HEROES
    @Condition eventPlayer.getUltCharge() == 100

    eventPlayer.forceButtonPress(Button.ULTIMATE)
    wait(1)


rule "[ai]: ram Use Ability 1":
    @Event eachPlayer
    @Team 1
    @Hero ramattra
    @Condition eventPlayer.isAlive()
    @Condition isGameInProgress()
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_1) == 0
    @Condition not eventPlayer.isUsingAbility1()
    @Condition Is_Attack_Phase
    # 格挡会挡住近战判定, 贴身时只普攻。
    @Condition not zombieInMeleeRange()

    wait(0.1, Wait.ABORT_WHEN_FALSE)
    eventPlayer.forceButtonPress(Button.ABILITY_1)
    eventPlayer.startForcingButton(Button.SECONDARY_FIRE)
    waitUntil(not eventPlayer.isAlive() or not Is_Attack_Phase or zombieInMeleeRange(), 4)
    eventPlayer.stopForcingButton(Button.SECONDARY_FIRE)
    if ruleCondition:
        loop()


rule "[ai]: Pharah Use Ability 1":
    @Event eachPlayer
    @Team 1
    @Hero pharah
    @Condition eventPlayer.isAlive()
    @Condition isGameInProgress()
    @Condition not eventPlayer.isInAir()
    @Condition Is_Attack_Phase

    wait(0.1, Wait.ABORT_WHEN_FALSE)
    eventPlayer.forceButtonPress(Button.ABILITY_1)
    eventPlayer.startForcingButton(Button.JUMP)
    wait(4)
    eventPlayer.stopForcingButton(Button.JUMP)
    if ruleCondition:
        loop()
