#!mainFile "../../main.opy"

rule "[Roadhog]: hook lancher":
    @Event playerDealtDamage
    @Team 2
    @Hero roadhog
    @Condition eventAbility == Button.ABILITY_1

    waitUntil(not eventPlayer.isUsingAbility1() or distance(attacker, victim) <= 1.5, 8)
    eventPlayer.cancelPrimaryAction()
    victim.startForcingThrottle(0, 0, 0, 0, 0, 0)
    victim.setGravity(10)
    victim.applyImpulse(attacker.getFacingDirection(), 85, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    # 定身只用于起跳瞬间; 不解除会永久覆盖僵尸自己的寻路油门, 目标原地不动直至被卡死看门狗击杀
    wait(0.5)
    victim.stopForcingThrottle()
    victim.setGravity(100)


rule "[Roadhog]: stun":
    @Event playerDealtDamage
    @Team 2
    @Hero roadhog
    @Condition eventAbility == Button.ABILITY_2
    @Condition eventPlayer.hasStatus(Status.STUNNED) != true

    victim.setStatusEffect(attacker, Status.STUNNED, 1)
    wait(4)
