#!mainFile "../../../main.opy"

#!define UPGRADE_ROW_REACTIVE ["反应装甲", "获得 100 + 最大生命值 10% 的可恢复护甲；\n护甲未被击穿时，眩晕攻击者 1.2 秒", UPGRADE_KIND_TECH, 0, 1, 0, 0, 0, abilityIconString(Hero.ORISA, Button.ULTIMATE), []]

rule "Feska - Reactive armor":
    @Event playerTookDamage
    @Team 2
    @Condition Tech_Id.REACTIVE in eventPlayer.Owned_Tech_Ids
    @Condition attacker != null
    @Condition attacker != eventPlayer
    # 护甲为 0 即被击穿, 不再眩晕。不设内置冷却, 触发频率由护甲量自然限制。
    @Condition eventPlayer.getHealthOfType(Health.ARMOR) > 0

    attacker.setStatusEffect(eventPlayer, Status.STUNNED, 1.2)


rule "Feska - Reactive armor pool":
    @Event eachPlayer
    @Team 2
    @Condition Tech_Id.REACTIVE in eventPlayer.Owned_Tech_Ids
    @Condition eventPlayer.isAlive()
    # 池句柄为空即缺池: 选中科技、重生或换英雄后都从这里补建。
    @Condition eventPlayer.Reactive_Armor_Health_Pool == null

    Target_Player = eventPlayer
    feskaApplyReactivePool()


rule "Feska - Reactive armor rebuild":
    @Event eachPlayer
    @Team 2
    @Condition isGameInProgress()
    @Condition Tech_Id.REACTIVE in eventPlayer.Owned_Tech_Ids
    @Condition eventPlayer.isAlive()
    # 进攻阶段条件为假, 每次进入准备阶段时条件重新成立, 整池重建一次。
    @Condition not Is_Attack_Phase

    Target_Player = eventPlayer
    feskaApplyReactivePool()
