rule "[Juno]: Pulsar Torpedoes":
    @Event playerDealtDamage
    @Team 2
    @Hero juno
    @Condition eventAbility == Button.SECONDARY_FIRE

    damage(victim, attacker, victim.getMaxHealth() * 0.15)


rule "[Juno]: Orbital Ray":
    @Event eachPlayer
    @Team 2
    @Hero juno
    @Condition eventPlayer.isUsingUltimate() == true

    wait(0.496, Wait.ABORT_WHEN_FALSE)
    (getLivingPlayers(eventPlayer.getTeam()).filter(lambda player: isInLoS(eventPlayer, player) == true)).setStatusEffect(null, Status.UNKILLABLE, 8)


rule "[Juno]: 41":
    @Event eachPlayer
    @Team 2
    @Hero juno
    @Condition eventPlayer.isUsingUltimate() == true
    @Condition len(getLivingPlayers(getOppositeTeam(eventPlayer.getTeam())).filter(lambda player: isInLoS(eventPlayer, player) == true)) > 0

    wait(0.496, Wait.ABORT_WHEN_FALSE)
    (getLivingPlayers(getOppositeTeam(eventPlayer.getTeam())).filter(lambda player: isInLoS(eventPlayer, player) == true)).setEnvironmentalKillCreditor(eventPlayer)
    (getLivingPlayers(getOppositeTeam(eventPlayer.getTeam())).filter(lambda player: isInLoS(eventPlayer, player) == true)).setMoveSpeed(15)
    (getLivingPlayers(getOppositeTeam(eventPlayer.getTeam())).filter(lambda player: isInLoS(eventPlayer, player) == true)).setGravity(0)
    (getLivingPlayers(getOppositeTeam(eventPlayer.getTeam())).filter(lambda player: isInLoS(eventPlayer, player) == true)).applyImpulse(vect(0, 1, 0), 10, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    waitUntil(not eventPlayer.isUsingUltimate(), 8)
    (getLivingPlayers(getOppositeTeam(eventPlayer.getTeam())).filter(lambda player: isInLoS(eventPlayer, player) == true)).setGravity(100)
    (getLivingPlayers(getOppositeTeam(eventPlayer.getTeam())).filter(lambda player: isInLoS(eventPlayer, player) == true)).setMoveSpeed(100)


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


rule "[Ramattra]: Pain endures":
    @Event playerDealtFinalBlow
    @Team 2
    @Hero ramattra
    @Condition eventPlayer.isUsingUltimate() == true
    @Condition eventAbility == Button.ULTIMATE

    eventPlayer.setUltCharge(eventPlayer.getUltCharge() + 25)
    wait(0.3)


rule "[Ramattra]: Nemesis Form":
    @Event playerTookDamage
    @Team 1
    @Condition attacker.getHero() == Hero.RAMATTRA == true
    @Condition eventAbility == Button.ABILITY_1

    playEffect(getAllPlayers(), DynamicEffect.SIGMA_HYPERSPHERE_IMPLOSION, Color.WHITE, eventPlayer, 200)
    victim.applyImpulse(worldVector(Vector.FORWARD, attacker, Transform.ROTATION), 25, Relativity.TO_WORLD)
    wait(0.248)


rule "[Ramattra]: Annihilation":
    @Event playerTookDamage
    @Team 1
    @Condition attacker.getHero() == Hero.RAMATTRA == true
    @Condition eventAbility == Button.ULTIMATE

    playEffect(getAllPlayers(), DynamicEffect.SIGMA_HYPERSPHERE_IMPLOSION, Color.WHITE, eventPlayer, 200)
    victim.applyImpulse(Vector.UP, 1, Relativity.TO_PLAYER)
    victim.applyImpulse(worldVector(Vector.BACKWARD, attacker, Transform.ROTATION), 3, Relativity.TO_WORLD)
    wait(1.5)


rule "[Doomfist] Seismic Slam upper":
    @Event playerTookDamage
    @Team 1
    @Condition attacker.getHero() == Hero.DOOMFIST
    @Condition eventAbility == Button.ABILITY_1
    @Condition (victim.getHero() == Hero.ORISA and (victim.isUsingAbility1() or victim.isUsingUltimate())) == false
    @Condition (victim.getHero() == Hero.MAUGA and victim.isUsingAbility1()) == false

    victim.applyImpulse(Vector.UP, 10, Relativity.TO_PLAYER)
    victim.applyImpulse(worldVector(Vector.FORWARD, attacker, Transform.ROTATION), 5, Relativity.TO_WORLD)
    victim.startForcingThrottle(0, 0, 0, 0, 0, 0)
    waitUntil(victim.isOnGround(), 1.2)
    victim.stopForcingThrottle()
    victim.setStatusEffect(attacker, Status.STUNNED, 2)
    wait(1)


rule "[Junker Queen]: Commanding Shout":
    @Event eachPlayer
    @Team 2
    @Hero junkerQueen
    @Condition eventPlayer.isUsingAbility1() == true

    eventPlayer.setStatusEffect(null, Status.INVINCIBLE, 2)


rule "[Junker Queen]: Rampage":
    @Event eachPlayer
    @Team 2
    @Hero junkerQueen
    @Condition eventPlayer.isUsingUltimate() == true

    wait(0.496, Wait.ABORT_WHEN_FALSE)
    eventPlayer.setDamageDealt(1000)
    waitUntil(not eventPlayer.isUsingUltimate(), 0.864)
    eventPlayer.setDamageDealt(100)
    wait(10)


rule "[Reinhardt]: Rocket Hammer stun":
    @Event playerDealtDamage
    @Team 2
    @Hero reinhardt
    @Condition eventAbility == Button.PRIMARY_FIRE

    victim.setStatusEffect(attacker, Status.STUNNED, 0.5)
    wait(0.496)


rule "[Reinhardt]: Earthshatter":
    @Event playerDealtFinalBlow
    @Team 2
    @Hero reinhardt
    @Condition eventAbility == Button.ULTIMATE

    eventPlayer.setUltCharge(100)
    wait(0.5)


rule "[Roadhog]: stun":
    @Event playerDealtDamage
    @Team 2
    @Hero roadhog
    @Condition eventAbility == Button.ABILITY_2
    @Condition eventPlayer.hasStatus(Status.STUNNED) != true

    victim.setStatusEffect(attacker, Status.STUNNED, 1)
    wait(4)


rule "[Winston]: stun":
    @Event playerDealtDamage
    @Team 2
    @Hero winston
    @Condition eventAbility == Button.SECONDARY_FIRE
    @Condition eventPlayer.hasStatus(Status.STUNNED) != true

    victim.setStatusEffect(attacker, Status.STUNNED, 0.75)
    wait(0.75)


rule "[Bastion]: stun":
    @Event playerDealtKnockback
    @Team 2
    @Hero bastion
    @Condition eventAbility == Button.PRIMARY_FIRE
    @Condition eventPlayer.hasStatus(Status.STUNNED) != true

    victim.setStatusEffect(attacker, Status.STUNNED, 0.5)
    wait(0.75)


rule "[Bastion]: stun":
    @Event playerDealtDamage
    @Team 2
    @Hero bastion
    @Condition eventAbility == Button.ULTIMATE
    @Condition eventPlayer.hasStatus(Status.KNOCKED_DOWN) != true

    victim.setStatusEffect(attacker, Status.KNOCKED_DOWN, 5)
    wait(0.16)


rule "[Cassidy.opy]: Revert sniper damage falloff":
    @Event playerDealtDamage
    @Team 2
    @Hero cassidy
    @Condition eventAbility == Button.PRIMARY_FIRE
    @Condition distance(attacker.getEyePosition(), victim) >= 25.1

    eventPlayer.scoped_shot_distance = distance(attacker.getEyePosition(), victim)
    #原OW2衰减计算（25-35米 70%衰减）
    eventPlayer.ow2_scoped_damage_falloff_scalar = 1 - (((eventPlayer.scoped_shot_distance - 25) / 10) * 0.7) + (1 - ((eventPlayer.scoped_shot_distance - 25) / 10))
    if eventPlayer.ow2_scoped_damage_falloff_scalar > 1:
        eventPlayer.ow2_scoped_damage_falloff_scalar = 1
    #Min damage scalar
    elif eventPlayer.ow2_scoped_damage_falloff_scalar < 0.3:
        eventPlayer.ow2_scoped_damage_falloff_scalar = 0.3
    eventPlayer.scoped_damage_base = eventDamage / eventPlayer.ow2_scoped_damage_falloff_scalar
    eventPlayer.ow1_scoped_damage_falloff_scalar = 1 - (((eventPlayer.scoped_shot_distance - 25) / 25) * 0.3)
    #Cap min/max scalar
    # Max damage scalar
    if eventPlayer.ow1_scoped_damage_falloff_scalar < 0.7:
        eventPlayer.ow1_scoped_damage_falloff_scalar = 0.7
    if eventPlayer.scoped_shot_distance > 50:
        eventPlayer.ow1_scoped_damage_falloff_scalar = 0.7
    eventPlayer.expected_scoped_damage = eventPlayer.scoped_damage_base * eventPlayer.ow1_scoped_damage_falloff_scalar
    damage(victim, attacker, ceil(eventPlayer.expected_scoped_damage - eventDamage))


rule "[Cassdy] Peacekeeper Alt Fire":
    @Event eachPlayer
    @Team 2
    @Hero cassidy
    @Condition eventPlayer.isFiringSecondaryFire() == true

    eventPlayer.setDamageDealt(180)
    waitUntil(not eventPlayer.isFiringSecondaryFire(), 0.75)
    eventPlayer.setDamageDealt(100)


rule "[Freja]: Ammo":
    @Event playerEarnedElimination
    @Team 2
    @Hero freja

    eventPlayer.setMaxAmmo(0, eventPlayer.getMaxAmmo() + 1)


rule "[Freja]: Take Aim Damage":
    @Event playerDealtKnockback
    @Team 2
    @Hero freja
    @Condition eventAbility == Button.SECONDARY_FIRE
    @Condition victim.hasStatus(Status.INVINCIBLE) != true

    wait(0.5, Wait.ABORT_WHEN_FALSE)
    playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, Color.BLUE, victim, 0.8)
    playEffect(getAllPlayers(), DynamicEffect.EXPLOSION_SOUND, Color.BLUE, victim, 10)
    damage(victim, attacker, victim.getMaxHealth() * 0.25)


rule "[Freja]: Ex":
    @Event playerDealtKnockback
    @Team 2
    @Hero freja
    @Condition eventAbility == null
    @Condition victim.hasStatus(Status.INVINCIBLE) != true

    if not victim.isAlive() or victim.getHealth() > victim.getMaxHealth() * 0.3:
        goto lbl_0
    damage(victim, attacker, 44444)
    smallMessage(eventPlayer, "  斩杀： {0} ".format(heroIcon(victim.getHero())))
    wait(1, Wait.ABORT_WHEN_FALSE)
    lbl_0:


rule "[Mei]: Endothermic Blaster":
    @Event playerDealtDamage
    @Hero mei
    @Condition eventWasCriticalHit == true
    @Condition eventAbility == Button.SECONDARY_FIRE

    victim.setStatusEffect(attacker, Status.FROZEN, 0.5 if eventWasCriticalHit == true else 1.25)
    wait(0.2)


rule "[Mei]: Ice move":
    @Event eachPlayer
    @Hero mei
    @Condition eventPlayer.isUsingAbility1() == true
    @Condition eventPlayer.isHoldingButton(Button.JUMP) == true

    eventPlayer.applyImpulse(eventPlayer.getFacingDirection(), 5, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    wait()
    if ruleCondition:
        loop()


rule "[Reaper]: Death Blossom remove Mov. speed penalty":
    @Event eachPlayer
    @Hero reaper
    @Condition eventPlayer.isUsingUltimate() == true

    eventPlayer.setDamageDealt(200)
    eventPlayer.setMoveSpeed(200)
    waitUntil(not eventPlayer.isUsingUltimate(), 3.5)
    eventPlayer.setMoveSpeed(100)
    eventPlayer.setDamageDealt(100)


rule "[Sojourn] Execution players less 10% HP expectancy":
    @Event playerDealtDamage
    @Hero sojourn
    @Condition (eventAbility == Button.SECONDARY_FIRE or eventAbility == Button.ULTIMATE) == true
    @Condition victim.getHealth() <= victim.getMaxHealth() * 0.2

    damage(victim, attacker, 44444)
    wait(0.2)


rule "[Ana] Biotic Grenade Hit":
    @Event playerTookDamage
    @Team 1
    @Condition eventAbility == Button.ABILITY_2
    @Condition attacker.getHero() == Hero.ANA == true

    eventPlayer.setStatusEffect(attacker, Status.BURNING, 3)
    eventPlayer.startDamageOverTime(attacker, 3, ceil(0.15 * victim.getMaxHealth()))
    wait(3)


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


rule "[Baptiste]: headshot damage":
    @Event playerDealtDamage
    @Team 2
    @Hero baptiste
    @Condition eventWasCriticalHit == true
    @Condition eventAbility == Button.PRIMARY_FIRE

    damage(victim, attacker, ceil(eventDamage / 4))


rule "[Kiriko]: headshot damage":
    @Event playerDealtDamage
    @Team 2
    @Hero kiriko
    @Condition eventWasCriticalHit == true
    @Condition eventAbility == Button.PRIMARY_FIRE

    damage(victim, attacker, ceil(eventDamage / 4))


rule "[Hazard]: Mov speed penalty":
    @Event playerDealtDamage
    @Team 2
    @Hero hazard
    @Condition eventAbility == Button.SECONDARY_FIRE
    @Condition victim.mov_speed_penalty != true

    victim.mov_speed_penalty = true
    wait(1)
    victim.mov_speed_penalty = false


rule "[Hazard]: Mov speed penalty":
    @Event eachPlayer
    @Team 1
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.mov_speed_penalty == true

    eventPlayer.startForcingThrottle(0, 0.5, 0, 0.5, 0, 0.5)
    waitUntil(not eventPlayer.mov_speed_penalty, 1)
    eventPlayer.stopForcingThrottle()
    eventPlayer.mov_speed_penalty = false


rule "[Mauga]: Cardiac Overdrive Dmg. reduction":
    @Event eachPlayer
    @Team 2
    @Hero mauga
    @Condition eventPlayer.isUsingAbility2() == true

    eventPlayer.setStatusEffect(null, Status.INVINCIBLE, 5)


rule "[Orisa]: Fortify":
    @Event eachPlayer
    @Team 2
    @Hero orisa
    @Condition eventPlayer.isUsingAbility1() == true

    (getLivingPlayers(eventPlayer.getTeam()).filter(lambda player: isInLoS(eventPlayer, player) == true)).setDamageReceived(50)
    waitUntil(not eventPlayer.isUsingAbility1(), 4.1)
    getPlayers(eventPlayer.getTeam()).setDamageReceived(100)


rule "[Orisa]: ult":
    @Event eachPlayer
    @Team 2
    @Hero orisa
    @Condition eventPlayer.isUsingUltimate() == true

    getLivingPlayers(eventPlayer.getTeam()).setStatusEffect(eventPlayer, Status.INVINCIBLE, 4)
    waitUntil(not eventPlayer.isUsingUltimate(), 4.1)
    getPlayers(eventPlayer.getTeam()).clearStatusEffect(Status.INVINCIBLE)


rule "[Zarya]: Projected Barrier Target":
    @Event eachPlayer
    @Hero zarya
    @Condition eventPlayer.isUsingAbility2() == true

    sorted(getLivingPlayers(eventPlayer.getTeam()), lambda player: angleBetweenVectors(eventPlayer.getFacingDirection(), directionTowards(eventPlayer.getPosition(), player.getPosition()))).filter(lambda x: x.hasStatus(Status.INVINCIBLE))[0].zarya_barrier_shields[0] = true


rule "[Zarya]: Projected Barrier Shields":
    @Event eachPlayer
    @Condition eventPlayer.getHero() != Hero.ZARYA
    @Condition (eventPlayer.isAlive() and eventPlayer.zarya_barrier_shields[0]) == true

    eventPlayer.zarya_barrier_shields[0] = false
    if eventPlayer.zarya_barrier_shields[1] == null:
        goto lbl_0
    removeHealthPool(eventPlayer.zarya_barrier_shields[1])
    lbl_0:
    eventPlayer.addHealthPool(Health.NORMAL, 50, false, false)
    eventPlayer.zarya_barrier_shields[1] = getLastCreatedHealthPool()
    wait(6, Wait.RESTART_WHEN_TRUE)
    removeHealthPool(eventPlayer.zarya_barrier_shields[1])
    eventPlayer.zarya_barrier_shields[1] = null


rule "[Echo]: kill to reset abilities":
    @Event playerEarnedElimination
    @Team 2
    @Hero echo
    @Condition eventAbility in [Button.SECONDARY_FIRE, Button.ABILITY_2] == true

    eventPlayer.setAbilityCooldown(eventAbility, 0)


rule "[Genji]: Deflect":
    @Event eachPlayer
    @Hero genji
    @Condition eventPlayer.isUsingAbility2() == true

    eventPlayer.setStatusEffect(eventPlayer, Status.INVINCIBLE, 2.192)


rule "[Soldier: 76]: Helix Rockets lose control":
    @Event playerDealtDamage
    @Team 2
    @Hero soldier
    #@Condition attacker.getHero() == Hero.SOLDIER
    @Condition eventAbility == Button.SECONDARY_FIRE
    @Condition attacker != victim

    victim.setStatusEffect(attacker, Status.BURNING, 2)
    victim.startDamageOverTime(attacker, 2, ceil(victim.getMaxHealth() * 0.1 / 2))


rule "[Symmetra]: Barrier Shields":
    @Event eachPlayer
    @Team 2
    @Hero symmetra
    @Condition eventPlayer.isUsingUltimate() == true

    ((getLivingPlayers(eventPlayer.getTeam()).filter(lambda player: isInLoS(eventPlayer, player) == true)).sym_barrier_shields)[0] = true
    waitUntil(not eventPlayer.isUsingUltimate(), 12.5)
    getPlayers(eventPlayer.getTeam()).sym_barrier_shields[0] = false


rule "[Symmetra]: Barrier Shields":
    @Event eachPlayer
    @Team 2
    @Condition eventPlayer.sym_barrier_shields[0] == true

    if eventPlayer.sym_barrier_shields[1] == null:
        goto lbl_0
    removeHealthPool(eventPlayer.sym_barrier_shields[1])
    lbl_0:
    eventPlayer.addHealthPool(Health.SHIELDS, 1000, true, false)
    eventPlayer.sym_barrier_shields[1] = getLastCreatedHealthPool()
    waitUntil(not eventPlayer.sym_barrier_shields[0], 12.5)
    removeHealthPool(eventPlayer.sym_barrier_shields[1])
    eventPlayer.sym_barrier_shields[1] = null


rule "[Tracer]: Blink explosion target":
    @Event playerTookDamage
    @Team 1
    @Condition eventAbility == Button.ULTIMATE
    @Condition attacker.getHero() == Hero.TRACER == true
    @Condition eventDamage >= 70
    @Condition len(getPlayersInRadius(eventPlayer, 25, eventPlayer.getTeam(), LosCheck.SURFACES)) != 0

    damage(eventPlayer, eventPlayer.tracer_buff[1], ceil(eventPlayer.getMaxHealth() * 0.1))
    wait(0.5)
    getPlayersInRadius(eventPlayer, 25, eventPlayer.getTeam(), LosCheck.SURFACES).tracer_buff[0] = true
    getPlayersInRadius(eventPlayer, 25, eventPlayer.getTeam(), LosCheck.SURFACES).tracer_buff[1] = attacker


rule "[Tracer]: Blink explosion":
    @Event eachPlayer
    @Team 1
    @Condition eventPlayer.tracer_buff[0] == true
    @Condition eventPlayer.isAlive() == true

    playEffect(getAllPlayers(), DynamicEffect.DVA_SELF_DESTRUCT_EXPLOSION, Color.TEAM_1, eventPlayer, 200)
    playEffect(getAllPlayers(), DynamicEffect.DVA_SELF_DESTRUCT_EXPLOSION_SOUND, Color.WHITE, eventPlayer, 200)
    damage(eventPlayer, eventPlayer.tracer_buff[1], ceil(eventPlayer.getMaxHealth() * 0.08))
    wait(0.16)
    eventPlayer.tracer_buff[0] = false
    eventPlayer.tracer_buff[1] = null


rule "[widowmaker/init.opy]: Initialize Widowmaker ammo":
    @Event eachPlayer
    @Team 2
    @Hero widowmaker
    @Condition eventPlayer.getAmmo() > 5

    #eventPlayer.setMaxAmmo(0, 1)
    eventPlayer.setAmmo(0, 5)


rule "[widowmaker.opy]: Infra-Sight headshot":
    @Event playerDealtDamage
    @Team 2
    @Hero widowmaker
    @Condition eventWasCriticalHit == true
    @Condition eventPlayer.isFiringSecondaryFire() == true
    @Condition eventPlayer.isFiringPrimaryFire() == true
    @Condition eventAbility == Button.PRIMARY_FIRE
    @Condition eventDamage >= 200

    damage(victim, attacker, victim.getMaxHealth() * 0.5)


rule "【布丽吉塔】恢复包选中目标":
    @Event eachPlayer
    @Team 2
    @Hero brigitte
    @Condition eventPlayer.isUsingAbility2() == true
    @Condition distance(eventPlayer, eventPlayer.getPlayerClosestToReticle(eventPlayer.getTeam())) <= 20.25

    sorted(getLivingPlayers(eventPlayer.getTeam()), lambda player: angleBetweenVectors(eventPlayer.getFacingDirection(), directionTowards(eventPlayer.getPosition(), player.getPosition())))[0].brig_repair_pack[0] = true


rule "【布丽吉塔】恢复包提供护甲":
    @Event eachPlayer
    @Team 2
    @Condition eventPlayer.getHero() != Hero.BRIGITTE
    @Condition (eventPlayer.isAlive() and eventPlayer.brig_repair_pack[0]) == true

    eventPlayer.brig_repair_pack[0] = false
    if eventPlayer.brig_repair_pack[1] == null:
        goto lbl_0
    removeHealthPool(eventPlayer.brig_repair_pack[1])
    lbl_0:
    eventPlayer.addHealthPool(Health.ARMOR, 150, false, false)
    smallMessage(eventPlayer, "  {0} 获得来自 {1} 的护甲".format(abilityIconString(Hero.BRIGITTE, Button.ABILITY_2), Hero.BRIGITTE))
    eventPlayer.brig_repair_pack[1] = getLastCreatedHealthPool()


rule "[Brigitte]: Rally provides permanent armor to self":
    @Event eachPlayer
    @Team 2
    @Condition len(eventPlayer.brig_rally_armor_id) == 13

    waitUntil(not getPlayersOnHero(Hero.BRIGITTE, eventPlayer.getTeam()).isUsingUltimate() and eventPlayer.brig_rally_armor_id != [], 30)
    wait(4)
    removeHealthPool(eventPlayer.brig_rally_armor_id[0])
    #eventPlayer.brig_rally_armor_id = []
    eventPlayer.brig_rally_armor_id.remove(eventPlayer.brig_rally_armor_id[0])
    if len(eventPlayer.brig_rally_armor_id) != 0:
        loop()


rule "[Brigitte]Rally provides permanent armor to self":
    @Event eachPlayer
    @Team 2
    @Hero brigitte
    @Condition eventPlayer.isUsingUltimate() == true
    @Condition len(eventPlayer.brig_rally_armor_id) < 13

    getLivingPlayers(eventPlayer.getTeam()).addHealthPool(Health.ARMOR, 25, false, false)
    getLivingPlayers(eventPlayer.getTeam()).brig_rally_armor_id.append(getLastCreatedHealthPool())
    wait(0.5)
    if ruleCondition:
        loop()


rule "[Lucio]: Crossfade dmg":
    @Event eachPlayer
    @Team 2
    @Hero lucio
    @Condition eventPlayer.isAlive() == true
    @Condition (len(getLivingPlayers(getOppositeTeam(eventPlayer.getTeam())).filter(lambda player: distance(eventPlayer, player) <= 12.5 and not player.lucio_crossfade_dmg[0]))) > 0

    ((getLivingPlayers(getOppositeTeam(eventPlayer.getTeam())).filter(lambda player: distance(eventPlayer, player) <= 12.5 and not player.lucio_crossfade_dmg[0])).lucio_crossfade_dmg)[0] = true
    ((getLivingPlayers(getOppositeTeam(eventPlayer.getTeam())).filter(lambda player: distance(eventPlayer, player) <= 12.5)).lucio_crossfade_dmg)[1] = eventPlayer
    wait(1)
    if ruleCondition:
        loop()


rule "[Lucio]: Crossfade dmg":
    @Event eachPlayer
    @Team 1
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.lucio_crossfade_dmg[0] == true
    @Condition distance(eventPlayer, eventPlayer.lucio_crossfade_dmg[1]) <= 12.5

    eventPlayer.setStatusEffect(eventPlayer.lucio_crossfade_dmg[1], Status.BURNING, 1)
    eventPlayer.startDamageOverTime(eventPlayer.lucio_crossfade_dmg[1], 1, ceil(eventPlayer.getMaxHealth() * 0.1))
    wait(1)
    eventPlayer.lucio_crossfade_dmg[0] = false


def knockBack():
    @Name "[Zenyatta] Sub Knockback"

    wait()
    eventPlayer.applyImpulse(eventPlayer.knockback_direction, 22.5, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    eventPlayer.applyImpulse(Vector.UP, 22.5 * 0.3, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)


rule "[Zenyatta] Snap Kick (enemy)":
    @Event playerTookDamage
    @Team 1
    @Condition eventAbility == Button.MELEE
    @Condition attacker.getHero() == Hero.ZENYATTA == true

    eventPlayer.knockback_direction = directionFromAngles(attacker.getHorizontalFacingAngle(), -10)
    eventPlayer.startForcingThrottle(0, 0, 0, 0, 0, 0.5)
    knockBack()
    wait()
    eventPlayer.stopForcingThrottle()


rule "[Zenyatta]: Transcendence":
    @Event eachPlayer
    @Team 2
    @Hero zenyatta
    @Condition eventPlayer.isUsingUltimate() == true

    wait(0.16)
    ((getLivingPlayers(getOppositeTeam(eventPlayer.getTeam())).filter(lambda player: distance(eventPlayer, player) <= 10.5 and not player.zen_transcendence[0])).zen_transcendence)[0] = true
    ((getLivingPlayers(getOppositeTeam(eventPlayer.getTeam())).filter(lambda player: distance(eventPlayer, player) <= 10.5)).zen_transcendence)[1] = eventPlayer
    wait(6)


rule "[Zenyatta]: Transcendence dmg":
    @Event eachPlayer
    @Team 1
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.zen_transcendence[0] == true
    @Condition distance(eventPlayer, eventPlayer.zen_transcendence[1]) <= 10.5

    eventPlayer.setStatusEffect(eventPlayer.zen_transcendence[1], Status.BURNING, 6)
    eventPlayer.startDamageOverTime(eventPlayer.zen_transcendence[1], 6, ceil(eventPlayer.getMaxHealth() * 0.1))
    wait(6)
    eventPlayer.zen_transcendence[0] = false


rule "[Illari]: Solar Rifle Alt Fire":
    @Event eachPlayer
    @Team 2
    @Hero illari
    @Condition eventPlayer.isFiringSecondaryFire() == true

    wait(0.12)
    damage(raycastHitPlayer(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 20, getPlayers(Team.1), eventPlayer, true), eventPlayer, 25)
    wait(0.12)
    if ruleCondition:
        loop()
