#!mainFile "../../../main.opy"

# 大运来咯: 你造成的击退会把目标击倒 1 秒。
# 工坊有击退事件, 不需要白名单也不需要坐标差分:
#   playerDealtKnockback(Team 2) 记下持有者的时间戳, playerReceivedKnockback(Team 1) 在被击退的僵尸侧配对。
# 配对条件用"本帧 + 12 米内", 过滤掉非我方来源的击退; 同一帧多人同时击退时归因到第一个匹配的持有者, 效果相同。
# 只覆盖击退事件, 不含路霸钩拉拽、末日铁拳上勾拳这类非击退位移。
# setStatusEffect 的接收者是调用方: 受击方(事件玩家).setStatusEffect(施加者, ...)。
# AI 已把 KNOCKED_DOWN 当作行动中止(src/ai/core.opy), 僵尸会原地停顿。
#!define FESKA_KNOCKDOWN_SECONDS 1
#!define FESKA_KNOCKDOWN_RADIUS 12
#!define FESKA_KNOCKDOWN_WINDOW 0.12
#!define UPGRADE_ROW_KNOCKDOWN ["大运来咯", "你造成的击退会将敌人击倒 1 秒", UPGRADE_KIND_TECH, 0, 1, 0, 0, 0, abilityIconString(Hero.LUCIO, Button.ABILITY_2), []]

rule "Feska - Knockdown dealer":
    @Event playerDealtKnockback
    @Team 2
    @Condition Is_Attack_Phase
    @Condition Tech_Id.KNOCKDOWN in eventPlayer.Owned_Tech_Ids

    eventPlayer.Knockback_Dealt_At = getTotalTimeElapsed()


rule "Feska - Knockdown apply":
    @Event playerReceivedKnockback
    @Team 1
    @Condition eventPlayer.isAlive()
    @Condition not eventPlayer.hasStatus(Status.KNOCKED_DOWN)

    Player_List = getPlayers(Team.2).filter(lambda player: Tech_Id.KNOCKDOWN in player.Owned_Tech_Ids and getTotalTimeElapsed() - player.Knockback_Dealt_At <= FESKA_KNOCKDOWN_WINDOW and distance(player, eventPlayer) <= FESKA_KNOCKDOWN_RADIUS)
    if len(Player_List) > 0:
        eventPlayer.setStatusEffect(Player_List[0], Status.KNOCKED_DOWN, FESKA_KNOCKDOWN_SECONDS)
