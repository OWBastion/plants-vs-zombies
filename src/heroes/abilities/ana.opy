#!mainFile "../../main.opy"

# 手雷灼烧已迁移为费斯卡技能强化"灼蚀"(src/player/feska/tech/ignite.opy), 原生手雷保留。


rule "[ana/init.opy]: Initialize Ana ammo":
    @Event eachPlayer
    @Team 2
    @Hero ana
    @Condition eventPlayer.getAmmo() > 1

    eventPlayer.setMaxAmmo(0, 1)
    eventPlayer.setAmmo(0, 1)


rule "[ana]: 1 shot kill":
    @Event playerDealtDamage
    @Hero ana
    @Condition eventPlayer.isFiringSecondaryFire() == true
    @Condition eventPlayer.isFiringPrimaryFire() == true
    @Condition eventAbility == Button.PRIMARY_FIRE

    damage(victim, attacker, 44444)
    wait(0.8)
