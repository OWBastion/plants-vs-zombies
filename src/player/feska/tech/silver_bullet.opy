#!mainFile "../../../main.opy"

# 银质子弹: 弹匣的最后一枚子弹额外造成 250% 伤害。
# 判定口径按确认结果取第 0 个弹夹(getAmmo(0) == 0 即打空)。
# 无弹夹英雄在选牌阶段就被排除(见 progression.opy 的池过滤), 所以拿到这张卡的英雄一定有弹夹。
# Ammo_Before_Hit 只负责同一发命中多只僵尸时去重: 第一次结算后置 0, 同一发的后续命中不再触发。
# 派生伤害用 Is_Spawning_Derived_Damage 挡住, 避免自我递归。
#!define FESKA_SILVER_BULLET_PERCENT 2.5
#!define UPGRADE_ROW_SILVER_BULLET ["银质子弹", "弹匣的最后一枚子弹额外造成 250% 伤害", UPGRADE_KIND_TECH, 0, 1, 0, 0, 0, abilityIconString(Hero.CASSIDY, Button.PRIMARY_FIRE), []]

rule "Feska - Silver bullet":
    @Event playerDealtDamage
    @Team 2
    @Condition victim.getTeam() == Team.1
    @Condition Tech_Id.SILVER_BULLET in eventPlayer.Owned_Tech_Ids
    @Condition eventDamage > 0

    if eventPlayer.getAmmo(0) == 0 and eventPlayer.Ammo_Before_Hit >= 1 and eventPlayer.Is_Spawning_Derived_Damage != true:
        eventPlayer.Ammo_Before_Hit = 0
        eventPlayer.Is_Spawning_Derived_Damage = true
        damage(victim, eventPlayer, eventDamage * FESKA_SILVER_BULLET_PERCENT)
        wait(0.032)
        eventPlayer.Is_Spawning_Derived_Damage = false
    else:
        eventPlayer.Ammo_Before_Hit = eventPlayer.getAmmo(0)
