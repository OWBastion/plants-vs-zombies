#!mainFile "../../../main.opy"

# 一板一眼: 弹匣上限变为 1, 被移除的每颗弹药转为 1.5 点主要攻击命中附加伤害。
# 技能与副武器不触发。原容量在选到科技时记录, 重生/换英雄由 progression.opy 重施上限。
# 无弹夹英雄在选牌池里排除(与银质子弹同一处过滤)。
#!define FESKA_METHODICAL_DAMAGE_PER_AMMO 1.5
#!define UPGRADE_ROW_METHODICAL ["一板一眼", "弹匣上限变为 1，被移除的每颗弹药使每次命中附加 1.5 点伤害", UPGRADE_KIND_TECH, 0, 1, 0, 0, 0, abilityIconString(Hero.WIDOWMAKER, Button.PRIMARY_FIRE), []]

rule "Feska - Methodical apply":
    @Event eachPlayer
    @Team 2
    @Condition Tech_Id.METHODICAL in eventPlayer.Owned_Tech_Ids
    @Condition eventPlayer.Methodical_Original_Max_Ammo == 0

    # 必须先读原容量再改上限; 之后读 getMaxAmmo 只能拿到 1。
    eventPlayer.Methodical_Original_Max_Ammo = eventPlayer.getMaxAmmo(0)
    eventPlayer.setMaxAmmo(0, 1)
    eventPlayer.setAmmo(0, 1)


rule "Feska - Methodical damage":
    @Event playerDealtDamage
    @Team 2
    @Condition victim.getTeam() == Team.1
    @Condition Tech_Id.METHODICAL in eventPlayer.Owned_Tech_Ids
    @Condition eventAbility == Button.PRIMARY_FIRE
    @Condition eventDamage > 0
    @Condition not eventPlayer.Is_Spawning_Derived_Damage

    # 上一发命中多只僵尸时只结算一次; 派生伤害也不再触发。
    if eventPlayer.getAmmo(0) == 0 and eventPlayer.Methodical_Ammo_Before_Hit >= 1:
        eventPlayer.Methodical_Ammo_Before_Hit = 0
        eventPlayer.Is_Spawning_Derived_Damage = true
        damage(victim, eventPlayer, ceil((eventPlayer.Methodical_Original_Max_Ammo - 1) * FESKA_METHODICAL_DAMAGE_PER_AMMO))
        wait(0.032)
        eventPlayer.Is_Spawning_Derived_Damage = false
    else:
        eventPlayer.Methodical_Ammo_Before_Hit = eventPlayer.getAmmo(0)
