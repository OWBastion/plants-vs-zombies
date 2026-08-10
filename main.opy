settings {
    "main": {
        "description": "植物大战僵尸 PvE 代码: BMAMW \n\nKook频道：kook.vip/EEC9UH\n\n企鹅坐牢群：361913638\n\n最后更新| v2025.0528.1",
        "modeName": "植物大战僵尸 PvE"
    },
    "lobby": {
        "mapRotation": "afterGame",
        "swapTeamsAfterMatch": false,
        "enableMatchVoiceChat": true,
        "team1Slots": 0,
        "team2Slots": 6,
        "spectatorSlots": 10,
        "returnToLobby": "never"
    },
    "gamemodes": {
        "elimination": {
            "enabledMaps": [
                "iliosRuins",
                "iliosLighthouse",
                "nepalShrine",
                "nepalSanctum",
                "nepalVillage",
                "lijiangNightMarket",
                "lijiangControlCenter",
                "ayutthaya"
            ]
        },
        "general": {
            "enablePerks": true,
            "perkGeneration%": 500,
            "spawnHealthPacks": "disabled",
            "drawTime": 300,
            "enableWallhack": true,
            "wallhackEnabledTime": 25,
            "gamemodeStartTrigger": "manual",
            "enableTiebreaker": false,
            "tiebreakerTime": 300,
            "heroLimit": "2PerTeam",
            "追赶等级时造成消灭威能加值": "100%",
            "enableKillCam": false
        }
    },
    "heroes": {
        "team1": {
            "dva": {
                "enablePrimaryFire": false,
                "damageDealt%": 400,
                "enableAbility2": false,
                "ability1Cooldown%": 500,
                "ability1Kb%": 0,
                "health%": 200,
                "movementGravity%": 90,
                "ultGen%": 25,
                "secondaryFireRechargeRate%": 500,
                "secondaryFireMaximumTime%": 500
            },
            "illari": {
                "enablePrimaryFire": false,
                "enableInfiniteAmmo": true,
                "enableAbility1": false,
                "health%": 200,
                "enableUlt": false
            },
            "hanzo": {
                "ability3Cooldown%": 275,
                "ability3Distance%": 85,
                "enablePrimaryFire": false,
                "damageDealt%": 400,
                "damageReceived%": 105,
                "enableAbility2": false,
                "health%": 150,
                "enableUlt": false,
                "enableAbility1": false
            },
            "cassidy": {
                "enablePrimaryFire": false,
                "damageDealt%": 95,
                "ability1Cooldown%": 200,
                "health%": 200,
                "enableUlt": false,
                "enableSecondaryFire": false,
                "ability2Cooldown%": 125
            },
            "lucio": {
                "enablePrimaryFire": false,
                "damageDealt%": 130,
                "jumpVerticalSpeed%": 90,
                "enableAbility2": false,
                "health%": 200,
                "movementSpeed%": 50,
                "enableUlt": false,
                "enableSecondaryFire": false
            },
            "bastion": {
                "enablePrimaryFire": false,
                "damageDealt%": 400,
                "jumpVerticalSpeed%": 150,
                "health%": 250,
                "movementSpeed%": 55,
                "ultDuration%": 25
            },
            "soldier": {
                "enablePrimaryFire": false,
                "damageDealt%": 400,
                "healingDealt%": 150,
                "health%": 140,
                "ability2Cooldown%": 67,
                "movementSpeed%": 50,
                "enableUlt": false,
                "enableSecondaryFire": false
            },
            "mercy": {
                "damageDealt%": 120,
                "weaponsEnabled": "staff",
                "health%": 150,
                "movementSpeed%": 60,
                "enableUlt": false,
                "ability2Cooldown%": 120
            },
            "orisa": {
                "enablePrimaryFire": false,
                "damageDealt%": 400,
                "ability1Cooldown%": 100,
                "enableAbility2": false,
                "health%": 100,
                "movementSpeed%": 50,
                "enableSecondaryFire": false
            },
            "ana": {
                "enablePrimaryFire": false,
                "damageDealt%": 65,
                "combatUltGen%": 130,
                "healingDealt%": 175,
                "health%": 150,
                "ability2Cooldown%": 180,
                "movementSpeed%": 55,
                "ultGen%": 130,
                "passiveUltGen%": 140,
                "ability1Cooldown%": 190
            },
            "baptiste": {
                "enablePrimaryFire": false,
                "damageDealt%": 300,
                "ability1Cooldown%": 300,
                "healingDealt%": 175,
                "health%": 250,
                "movementSpeed%": 55,
                "ultGen%": 140,
                "ability2Cooldown%": 240
            },
            "brigitte": {
                "damageDealt%": 120,
                "secondaryFireRechargeRate%": 75,
                "combatUltGen%": 110,
                "enableAbility1": false,
                "health%": 200,
                "movementSpeed%": 50,
                "ultGen%": 110,
                "passiveUltGen%": 110,
                "shieldBashCooldown%": 400,
                "shieldBashKb%": 25,
                "enableSpawningWithUlt": true
            },
            "torbjorn": {
                "damageDealt%": 400,
                "weaponsEnabled": "hammer",
                "jumpVerticalSpeed%": 150,
                "ammoClipSize%": 50,
                "combatUltGen%": 0,
                "projectileGravity%": 400,
                "ability2Cooldown%": 35,
                "ability2Duration%": 25,
                "health%": 325,
                "movementSpeed%": 55,
                "ultGen%": 10,
                "ultDuration%": 25,
                "passiveUltGen%": 0,
                "enableSecondaryFire": false,
                "enableAbility1": false
            },
            "ramattra": {
                "enablePrimaryFire": false,
                "enableAbility2": false,
                "ability1Cooldown%": 0,
                "enableUlt": false
            },
            "venture": {
                "enablePrimaryFire": false,
                "enableUlt": false,
                "ability1Cooldown%": 50,
                "ability1Duration%": 200
            },
            "doomfist": {
                "enablePrimaryFire": false,
                "damageDealt%": 400,
                "jumpVerticalSpeed%": 25,
                "secondaryFireCooldown%": 0,
                "secondaryFireKb%": 0,
                "health%": 220,
                "movementSpeed%": 50,
                "movementGravity%": 60,
                "enableUlt": false,
                "enableAbility2": false
            },
            "juno": {
                "enablePrimaryFire": false,
                "damageDealt%": 450,
                "jumpVerticalSpeed%": 150,
                "enableSecondaryFire": false,
                "ability2Cooldown%": 20
            },
            "zarya": {
                "enablePrimaryFire": false,
                "damageDealt%": 400,
                "jumpVerticalSpeed%": 125,
                "projectileSpeed%": 125,
                "ability2Cooldown%": 75,
                "health%": 200,
                "movementSpeed%": 50,
                "ability1Cooldown%": 75,
                "enableUlt": false,
                "enableSecondaryFire": false
            },
            "reaper": {
                "enablePrimaryFire": false,
                "damageDealt%": 400,
                "enableAbility1": false,
                "ability2Cooldown%": 140,
                "healingDealt%": 35,
                "health%": 200,
                "movementSpeed%": 50,
                "enableUlt": false
            },
            "mauga": {
                "damageDealt%": 450,
                "enablePrimaryFire": false,
                "enableSecondaryFire": false,
                "enableUlt": false,
                "ability1Kb%": 0
            },
            "pharah": {
                "enablePrimaryFire": false,
                "damageDealt%": 450,
                "damageReceived%": 105,
                "jumpVerticalSpeed%": 80,
                "enablePassiveUnlimitedFuel": true,
                "primaryFireKb%": 75,
                "health%": 100,
                "movementSpeed%": 50,
                "enableUlt": false,
                "enableAbility2": false,
                "ability2Kb%": 25
            },
            "junkerQueen": {
                "enablePrimaryFire": false,
                "damageDealt%": 325,
                "ability1Cooldown%": 67,
                "health%": 200,
                "movementSpeed%": 50,
                "secondaryFireKb%": 0,
                "锯齿利刃（格雷西）": "禁用"
            },
            "winston": {
                "enablePrimaryFire": false,
                "damageDealt%": 400,
                "ultKb%": 50,
                "ability1Cooldown%": 225,
                "ability1Kb%": 20,
                "ability1Acceleration%": 35,
                "ability2Cooldown%": 175,
                "combatUltGen%": 130,
                "movementSpeed%": 50,
                "movementGravity%": 110,
                "ultGen%": 130,
                "ultDuration%": 75,
                "passiveUltGen%": 130,
                "enableSecondaryFire": false
            },
            "genji": {
                "enablePrimaryFire": false,
                "damageDealt%": 500,
                "damageReceived%": 95,
                "enableAbility1": false,
                "combatUltGen%": 180,
                "health%": 200,
                "movementSpeed%": 50,
                "ultGen%": 180,
                "ultDuration%": 175,
                "passiveUltGen%": 180,
                "enableSecondaryFire": false,
                "ability2Cooldown%": 100
            },
            "junkrat": {
                "enablePrimaryFire": false,
                "damageDealt%": 400,
                "combatUltGen%": 0,
                "projectileGravity%": 400,
                "enableAbility2": false,
                "primaryFireKb%": 75,
                "health%": 300,
                "ultGen%": 10,
                "ultDuration%": 25,
                "passiveUltGen%": 20,
                "enableSpawningWithUlt": true,
                "enableAbility1": false
            },
            "tracer": {
                "enablePrimaryFire": false,
                "damageDealt%": 400,
                "combatUltGen%": 300,
                "projectileGravity%": 200,
                "health%": 500,
                "movementSpeed%": 50,
                "ultGen%": 300,
                "passiveUltGen%": 300,
                "enableSpawningWithUlt": true,
                "ability2Cooldown%": 125,
                "enableAbility1": false
            },
            "lifeweaver": {
                "weaponsEnabled": "healingBlossom",
                "enableAbility2": false
            },
            "wreckingBall": {
                "enablePrimaryFire": false,
                "damageDealt%": 200,
                "enableRollOnly": true,
                "secondaryFireCooldown%": 200,
                "ammoClipSize%": 25,
                "enableAbility2": false,
                "combatUltGen%": 0,
                "health%": 130,
                "movementSpeed%": 50,
                "ultGen%": 10,
                "ultDuration%": 500,
                "passiveUltGen%": 50,
                "ability3Cooldown%": 75
            },
            "zenyatta": {
                "enablePrimaryFire": false,
                "enableAbility2": false,
                "damageDealt%": 400,
                "health%": 150,
                "movementSpeed%": 50,
                "enableSecondaryFire": false,
                "enableSpawningWithUlt": true
            },
            "symmetra": {
                "enablePrimaryFire": false,
                "enableAbility2": false,
                "damageDealt%": 85,
                "ability1Cooldown%": 300,
                "projectileSpeed%": 10,
                "combatUltGen%": 80,
                "health%": 400,
                "ultGen%": 80,
                "passiveUltGen%": 95,
                "enableSecondaryFire": false
            },
            "sojourn": {
                "enablePrimaryFire": false,
                "damageDealt%": 400,
                "damageReceived%": 100,
                "health%": 140,
                "movementSpeed%": 50,
                "辅助攻击模式": "禁用"
            },
            "mei": {
                "enablePrimaryFire": false,
                "damageDealt%": 400,
                "ability2Cooldown%": 200,
                "primaryFireFreezeDuration%": 130,
                "primaryFireFreezeRate%": 120,
                "ability1Cooldown%": 500,
                "ultFreezeRate%": 120,
                "health%": 400,
                "movementSpeed%": 50,
                "enableUlt": false,
                "enableSecondaryFire": false
            },
            "ashe": {
                "“毒蛇”无法进行普通攻击": "开启",
                "enablePrimaryFire": false,
                "damageDealt%": 350,
                "ability1EnemyKb%": 75,
                "ability1SelfKb%": 60,
                "ability2Cooldown%": 300,
                "ability2FuseTime%": 1,
                "combatUltGen%": 15,
                "projectileGravity%": 400,
                "health%": 400,
                "enableAbility1": false,
                "ultGen%": 15,
                "passiveUltGen%": 15
            },
            "moira": {
                "damageDealt%": 225,
                "ability1Cooldown%": 300,
                "ability2MaxDamage%": 10,
                "ability2Cooldown%": 225,
                "ability2MaxHealing%": 150,
                "primaryFireRechargeRate%": 125,
                "health%": 200,
                "ultDuration%": 25,
                "enableUlt": false,
                "enableSecondaryFire": false
            },
            "reinhardt": {
                "damageDealt%": 325,
                "ability1Cooldown%": 175,
                "ability1Kb%": 15,
                "secondaryFireRechargeRate%": 75,
                "enableAbility2": false,
                "health%": 50,
                "movementSpeed%": 50,
                "enableUlt": false
            },
            "sigma": {
                "enablePrimaryFire": false,
                "damageDealt%": 300,
                "ability1Cooldown%": 200,
                "secondaryFireCooldown%": 300,
                "projectileSpeed%": 50,
                "health%": 125,
                "movementSpeed%": 55,
                "enableUlt": false,
                "ability2Cooldown%": 200
            },
            "roadhog": {
                "enablePrimaryFire": false,
                "damageDealt%": 400,
                "healingReceived%": 85,
                "health%": 200,
                "movementSpeed%": 50,
                "enableUlt": false,
                "enableAbility1": false
            },
            "kiriko": {
                "enablePrimaryFire": false,
                "health%": 200
            },
            "hazard": {
                "enablePrimaryFire": false,
                "enableAbility2": false,
                "尖刺护体移动速度惩罚": "150%",
                "尖刺护体资源消耗": "0%",
                "health%": 150,
                "enableUlt": false
            },
            "sombra": {
                "enablePrimaryFire": false,
                "damageDealt%": 400,
                "ability2Cooldown%": 400,
                "projectileGravity%": 500,
                "health%": 100,
                "enableUlt": false,
                "secondaryFireCooldown%": 250
            },
            "widowmaker": {
                "enablePrimaryFire": false,
                "damageDealt%": 325,
                "ability2Cooldown%": 140,
                "ability1Cooldown%": 200,
                "projectileGravity%": 80,
                "health%": 140,
                "movementSpeed%": 50,
                "ultDuration%": 300,
                "enableSpawningWithUlt": true
            },
            "general": {
                "damageDealt%": 400,
                "jumpVerticalSpeed%": 190,
                "movementSpeed%": 50,
                "movementGravity%": 90,
                "ultGen%": 180,
                "passiveUltGen%": 180
            }
        },
        "team2": {
            "dva": {
                "damageDealt%": 125,
                "damageReceived%": 500,
                "callMechKb%": 125,
                "ability2Cooldown%": 28,
                "ability1Cooldown%": 350,
                "ability1Kb%": 125,
                "health%": 50,
                "movementGravity%": 60,
                "passiveUltGen%": 95,
                "selfDestructKb%": 125
            },
            "illari": {
                "damageDealt%": 120,
                "damageReceived%": 400,
                "solarEnergyMax%": 500,
                "solarEnergyRecharge%": 500,
                "projectileSpeed%": 100,
                "enableInfiniteAmmo": true,
                "ability2Cooldown%": 50
            },
            "hanzo": {
                "ability3Cooldown%": 275,
                "ability3Distance%": 85,
                "damageDealt%": 90,
                "damageReceived%": 500,
                "combatUltGen%": 105,
                "health%": 100,
                "ultGen%": 105,
                "passiveUltGen%": 105,
                "ability1Cooldown%": 0
            },
            "cassidy": {
                "damageDealt%": 95,
                "damageReceived%": 500,
                "ammoClipSize%": 400,
                "combatUltGen%": 95,
                "ability1Cooldown%": 250,
                "health%": 100,
                "ultGen%": 95
            },
            "lucio": {
                "damageDealt%": 125,
                "damageReceived%": 325,
                "projectileSpeed%": 200,
                "enableInfiniteAmmo": true,
                "health%": 100,
                "enableSpawningWithUlt": true,
                "secondaryFireKb%": 150
            },
            "echo": {
                "ability2Cooldown%": 75,
                "secondaryFireCooldown%": 67
            },
            "bastion": {
                "damageDealt%": 90,
                "damageReceived%": 500,
                "jumpVerticalSpeed%": 230,
                "enableInfiniteAmmo": true,
                "ultDuration%": 75
            },
            "soldier": {
                "damageDealt%": 95,
                "damageReceived%": 150,
                "combatUltGen%": 125,
                "health%": 100,
                "ability2Cooldown%": 67,
                "ultGen%": 125,
                "ultDuration%": 200,
                "passiveUltGen%": 125,
                "enableSpawningWithUlt": true
            },
            "mercy": {
                "damageDealt%": 95,
                "damageReceived%": 500,
                "combatUltGen%": 120,
                "enableInfiniteAmmo": true,
                "health%": 150,
                "ultGen%": 120,
                "passiveUltGen%": 120,
                "ability2Cooldown%": 8
            },
            "orisa": {
                "damageReceived%": 500,
                "projectileSpeed%": 130,
                "ability1Cooldown%": 150,
                "enableInfiniteAmmo": true,
                "health%": 50,
                "secondaryFireCooldown%": 50
            },
            "ana": {
                "damageDealt%": 110,
                "damageReceived%": 500,
                "ammoClipSize%": 200,
                "combatUltGen%": 130,
                "health%": 100,
                "ability2Cooldown%": 150,
                "ultGen%": 130,
                "passiveUltGen%": 130,
                "ability1Cooldown%": 72
            },
            "baptiste": {
                "damageDealt%": 110,
                "damageReceived%": 330,
                "enableInfiniteAmmo": true,
                "healingDealt%": 50,
                "health%": 150,
                "ultGen%": 120
            },
            "brigitte": {
                "damageDealt%": 170,
                "damageReceived%": 90,
                "secondaryFireRechargeRate%": 200,
                "secondaryFireCooldown%": 100,
                "combatUltGen%": 165,
                "ability1Kb%": 125,
                "health%": 200,
                "ultGen%": 165,
                "passiveUltGen%": 165,
                "shieldBashKb%": 300,
                "enableSpawningWithUlt": true
            },
            "freja": {
                "ability2Cooldown%": 80,
                "secondaryFireCooldown%": 75
            },
            "torbjorn": {
                "damageDealt%": 100,
                "damageReceived%": 300,
                "weaponsEnabled": "hammer",
                "jumpVerticalSpeed%": 225,
                "ammoClipSize%": 50,
                "combatUltGen%": 165,
                "projectileGravity%": 200,
                "ability2Cooldown%": 40,
                "ability2Duration%": 200,
                "health%": 200,
                "movementSpeed%": 135,
                "movementGravity%": 80,
                "ultGen%": 165,
                "ultDuration%": 250,
                "passiveUltGen%": 165,
                "ability1Cooldown%": 150
            },
            "ramattra": {
                "damageReceived%": 90,
                "ability2Cooldown%": 36,
                "ability1Cooldown%": 50,
                "ultDuration%": 500,
                "enableSpawningWithUlt": true
            },
            "doomfist": {
                "damageDealt%": 110,
                "damageReceived%": 90,
                "ability1Cooldown%": 50,
                "combatUltGen%": 125,
                "enableInfiniteAmmo": true,
                "secondaryFireCooldown%": 120,
                "secondaryFireKb%": 120,
                "health%": 120,
                "ultGen%": 125,
                "ultDuration%": 50,
                "passiveUltGen%": 125,
                "ability2Cooldown%": 124
            },
            "juno": {
                "damageDealt%": 130,
                "enableInfiniteAmmo": true,
                "secondaryFireCooldown%": 60,
                "ability2Cooldown%": 20
            },
            "zarya": {
                "damageDealt%": 120,
                "damageReceived%": 90,
                "jumpVerticalSpeed%": 125,
                "projectileSpeed%": 130,
                "combatUltGen%": 155,
                "ability2Cooldown%": 89,
                "enableInfiniteAmmo": true,
                "health%": 200,
                "ability1Cooldown%": 73,
                "ultGen%": 155,
                "passiveUltGen%": 160
            },
            "reaper": {
                "damageDealt%": 120,
                "damageReceived%": 90,
                "ability1Cooldown%": 95,
                "combatUltGen%": 140,
                "enableInfiniteAmmo": true,
                "ability2Cooldown%": 125,
                "healingDealt%": 105,
                "health%": 200,
                "ultGen%": 140,
                "passiveUltGen%": 140
            },
            "mauga": {
                "damageReceived%": 400,
                "ammoClipSize%": 200,
                "ability2Cooldown%": 50,
                "primaryFireIgniteDamage": 166,
                "primaryFireIgniteDuration": 150,
                "health%": 50,
                "终极技能持续时间无限": "开启",
                "enableAbility1": false
            },
            "pharah": {
                "damageDealt%": 95,
                "damageReceived%": 500,
                "passiveRechargeRate%": 15,
                "passiveMaxTime%": 60,
                "enableAbility1": false,
                "enableInfiniteAmmo": true,
                "primaryFireKb%": 75,
                "health%": 150,
                "ability2Cooldown%": 200
            },
            "junkerQueen": {
                "damageDealt%": 125,
                "damageReceived%": 90,
                "ability1Cooldown%": 67,
                "health%": 200,
                "secondaryFireKb%": 0
            },
            "winston": {
                "damageDealt%": 130,
                "ultKb%": 125,
                "damageReceived%": 205,
                "ability1Cooldown%": 110,
                "ability1Kb%": 125,
                "jumpVerticalSpeed%": 110,
                "ability2Cooldown%": 75,
                "combatUltGen%": 125,
                "enableInfiniteAmmo": true,
                "health%": 60,
                "ultGen%": 125,
                "passiveUltGen%": 125
            },
            "genji": {
                "damageReceived%": 100,
                "projectileSpeed%": 225,
                "ability1Cooldown%": 150,
                "enableInfiniteAmmo": true,
                "health%": 200,
                "ultDuration%": 134,
                "ability2Cooldown%": 50
            },
            "junkrat": {
                "damageDealt%": 90,
                "damageReceived%": 500,
                "projectileSpeed%": 125,
                "combatUltGen%": 95,
                "ability2Cooldown%": 200,
                "enableInfiniteAmmo": true,
                "primaryFireKb%": 75,
                "health%": 150,
                "movementGravity%": 110,
                "ultGen%": 95,
                "ultDuration%": 50,
                "ability1Cooldown%": 300,
                "ability1Kb%": 55
            },
            "tracer": {
                "damageDealt%": 95,
                "damageReceived%": 500,
                "ammoClipSize%": 250,
                "enableInfiniteAmmo": true,
                "health%": 200,
                "ability2Cooldown%": 275,
                "ability1Cooldown%": 450
            },
            "lifeweaver": {
                "ability1Cooldown%": 200,
                "enableInfiniteAmmo": true,
                "ability2Cooldown%": 50,
                "primaryFireRange%": 200,
                "secondaryFireCooldown%": 20
            },
            "wreckingBall": {
                "damageDealt%": 135,
                "secondaryFireCooldown%": 50,
                "ability1Kb%": 150,
                "combatUltGen%": 125,
                "enableInfiniteAmmo": true,
                "health%": 50,
                "ultGen%": 125,
                "passiveUltGen%": 125,
                "ability3Cooldown%": 30,
                "enableSpawningWithUlt": true
            },
            "zenyatta": {
                "damageReceived%": 90,
                "projectileSpeed%": 200,
                "combatUltGen%": 125,
                "enableInfiniteAmmo": true,
                "health%": 200,
                "ultGen%": 125,
                "passiveUltGen%": 125
            },
            "symmetra": {
                "ability2Cooldown%": 275,
                "damageDealt%": 80,
                "damageReceived%": 500,
                "ability1Cooldown%": 260,
                "jumpVerticalSpeed%": 150,
                "ammoClipSize%": 120,
                "combatUltGen%": 125,
                "enableInfiniteAmmo": true,
                "health%": 100,
                "movementGravity%": 75,
                "ultGen%": 125,
                "passiveUltGen%": 125,
                "enableSpawningWithUlt": true
            },
            "sojourn": {
                "充能速度 充能射击": "125%",
                "终极技能持续时间": "150%",
                "ability2Cooldown%": 54
            },
            "mei": {
                "damageDealt%": 110,
                "enablePrimaryFireFreezeStack": true,
                "ability2Cooldown%": 67,
                "primaryFireFreezeDuration%": 200,
                "primaryFireFreezeRate%": 200,
                "primaryFireFreezeMinimum%": 20,
                "damageReceived%": 90,
                "jumpVerticalSpeed%": 110,
                "projectileSpeed%": 120,
                "ability1Cooldown%": 50,
                "combatUltGen%": 125,
                "projectileGravity%": 110,
                "enableInfiniteAmmo": true,
                "ultFreezeRate%": 120,
                "ultFreezeMinimum%": 40,
                "health%": 200,
                "ultGen%": 125,
                "passiveUltGen%": 145
            },
            "ashe": {
                "damageDealt%": 90,
                "ability1EnemyKb%": 150,
                "damageReceived%": 500,
                "ability2Cooldown%": 50,
                "ability2FuseTime%": 1,
                "combatUltGen%": 110,
                "enableInfiniteAmmo": true,
                "ability1Cooldown%": 80,
                "ultGen%": 110,
                "ultDuration%": 150,
                "passiveUltGen%": 110
            },
            "moira": {
                "damageDealt%": 120,
                "damageReceived%": 90,
                "jumpVerticalSpeed%": 110,
                "combatUltGen%": 165,
                "ability1Cooldown%": 225,
                "ability2Cooldown%": 75,
                "ability2MaxHealing%": 200,
                "primaryFireRechargeRate%": 500,
                "health%": 200,
                "ultGen%": 165,
                "passiveUltGen%": 155
            },
            "reinhardt": {
                "damageDealt%": 130,
                "ability1Cooldown%": 144,
                "ability1Kb%": 250,
                "damageReceived%": 90,
                "secondaryFireRechargeRate%": 150,
                "secondaryFireCooldown%": 0,
                "projectileSpeed%": 150,
                "combatUltGen%": 140,
                "primaryFireKb%": 250,
                "ability2Cooldown%": 72,
                "ultGen%": 140,
                "passiveUltGen%": 185
            },
            "sigma": {
                "damageDealt%": 130,
                "ability1Cooldown%": 0,
                "damageReceived%": 500,
                "health%": 70,
                "enableUlt": false,
                "ability2Cooldown%": 150
            },
            "roadhog": {
                "damageDealt%": 80,
                "damageReceived%": 90,
                "healingReceived%": 25,
                "secondaryFireRechargeRate%": 500,
                "secondaryFireMaximumTime%": 200,
                "projectileSpeed%": 150,
                "combatUltGen%": 165,
                "enableInfiniteAmmo": true,
                "healingDealt%": 50,
                "health%": 100,
                "ultGen%": 165,
                "passiveUltGen%": 165,
                "ability1Cooldown%": 55,
                "ultKb%": 125
            },
            "kiriko": {
                "ability1Distance%": 300,
                "damageDealt%": 115,
                "projectileSpeed%": 115,
                "无需装弹": "开启",
                "healingDealt%": 160,
                "ultGen%": 185,
                "ability2Cooldown%": 53
            },
            "hazard": {
                "damageReceived%": 90,
                "尖刺墙生命值": "400%",
                "尖刺护体资源恢复": "200%",
                "尖刺护体资源消耗": "50%",
                "ability1Cooldown%": 134,
                "health%": 150
            },
            "sombra": {
                "damageDealt%": 95,
                "ability2Cooldown%": 500,
                "damageReceived%": 500,
                "combatUltGen%": 125,
                "projectileGravity%": 120,
                "enableInfiniteAmmo": true,
                "health%": 150,
                "ultGen%": 125,
                "passiveUltGen%": 125,
                "secondaryFireCooldown%": 250
            },
            "widowmaker": {
                "damageDealt%": 100,
                "ability2Cooldown%": 110,
                "damageReceived%": 500,
                "ammoClipSize%": 25,
                "combatUltGen%": 500,
                "ability1Cooldown%": 200,
                "projectileGravity%": 80,
                "ultGen%": 500,
                "ultDuration%": 300,
                "passiveUltGen%": 500,
                "enableSpawningWithUlt": true
            },
            "enabledHeroes": [
                "reaper"
            ],
            "general": {
                "damageDealt%": 120,
                "damageReceived%": 500,
                "healingReceived%": 120,
                "jumpVerticalSpeed%": 100,
                "projectileSpeed%": 115,
                "combatUltGen%": 140,
                "healingDealt%": 125,
                "movementSpeed%": 100,
                "ultGen%": 130,
                "passiveUltGen%": 130
            }
        }
    },
    "workshop": {
        "攻击波持续时间": 60,
        "攻击波间隔时间": 20,
        "激活持续时间": 8,
        "随机英雄池：支援": 5,
        "随机英雄池：重装": 5
    }
}

#Global variables

globalvar Bot_Respawn_Points
globalvar Brain_Points
globalvar Current_Round
globalvar Config_Total_Round
globalvar Config_Round_Attack_Time
globalvar Config_Round_Lead_Time
globalvar Debug
globalvar Under_Attack
globalvar Difficult
globalvar Round_Attack_Time
globalvar Round_Lead_Time
globalvar NumberOfZombies
globalvar Zombie_Heros
globalvar Tank_Heros
globalvar Damage_Heros
globalvar Support_Heros
globalvar ANTI_CRASH_ACTIVATE_PERCENT
globalvar ANTI_CRASH_HOLD_TIME
globalvar ANTI_CRASH_DEACTIVATE_PERCENT
globalvar Hero_BAN

#Player variables

playervar BotTarget
playervar TTK
playervar heros
playervar mov_speed_penalty
playervar zarya_barrier_shields
playervar sym_barrier_shields
playervar tracer_buff
playervar brig_repair_pack
playervar brig_rally_armor_id
playervar lucio_crossfade_dmg
playervar knockback_direction
playervar zen_transcendence
playervar scoped_shot_distance
playervar scoped_damage_base
playervar ow2_scoped_damage_falloff_scalar
playervar ow1_scoped_damage_falloff_scalar
playervar expected_scoped_damage

#Subroutine names

subroutine AITarget 1
subroutine AIMove 2
subroutine setThirdPerson 3
subroutine setPlayerHeros 4
subroutine knockBack 5

#Activated extensions

#!extension buffStatusEffects
#!extension debuffStatusEffects
#!extension buffAndDebuffSounds
#!extension energyExplosionEffects
#!extension spawnMoreDummyBots
#!extension kineticExplosionEffects
#!extension explosionSounds
#!extension playMoreEffects


#Only remove the following directive if the gamemode does not use tricks such as A+0, A*0, A or "", "am" == "**", etc which would otherwise be optimized out.
#!optimizeStrict

#!postCompileHook "postCompileHook.js"

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


rule "Disable Scoring, Intro hud, Arena Locations, Spawn Loc, Spawn detect":
    @Condition isGameInProgress() == true
    @Condition Current_Round >= 2

    wait(5)
    setMatchTime(900)


rule "Disable Scoring, Intro hud, Arena Locations, Spawn Loc, Spawn detect":
    @Condition isGameInProgress() == true
    @Condition Under_Attack == true
    @Condition Current_Round == Config_Total_Round

    wait(1)
    setMatchTime(Config_Round_Attack_Time + Config_Round_Lead_Time)


rule "Disable Scoring, Intro hud, Arena Locations, Spawn Loc, Spawn detect":
    getPlayers(Team.1).disableRespawn()
    disableGamemodeCompletion()
    #Arena locations
    if __getCurrentMap__() == Map.AYUTTHAYA:
        Bot_Respawn_Points = [vect(16, 1, 25), vect(-6.5, 5, 25), vect(34.52, 6, 38.1), vect(16, 6, 23)]
        Brain_Points = [vect(16, 1.19, 52), vect(24, 1, 56), vect(-6, 3, 54)]
    elif __getCurrentMap__() == Map.LIJIANG_NIGHT_MARKET:
        Bot_Respawn_Points = [vect(32, 0, -21.75), vect(42.35, 6, -46), vect(30, 6, -14.18), vect(40, 2, -41.8)]
        Brain_Points = [vect(88.5, 4.5, -25.5)]
    elif __getCurrentMap__() == Map.LIJIANG_CONTROL_CENTER:
        Bot_Respawn_Points = [vect(31.21, 267, 312), vect(20, 270, 347.29), vect(24, 267, 327.17)]
        Brain_Points = [vect(67.71, 267.45, 349.43)]
    elif __getCurrentMap__() == Map.LIJIANG_CONTROL_CENTER:
        Bot_Respawn_Points = [vect(31.21, 267, 312), vect(20, 270, 347.29), vect(24, 267, 327.17)]
        Brain_Points = [vect(67.71, 267.45, 349.43)]
    elif __getCurrentMap__() == Map.ILIOS_LIGHTHOUSE:
        Bot_Respawn_Points = [vect(355, -24.66, 1.66), vect(324, -24.7, -0.04), vect(332.12, -20.74, 11.47), vect(336.38, -16.26, 8.63)]
        Brain_Points = [vect(320, -23.97, 46.25)]
    elif __getCurrentMap__() == Map.ILIOS_RUINS:
        Bot_Respawn_Points = [vect(-28.86, 58.37, -156.1), vect(-18.58, 59.39, -143.9), vect(-22.15, 58.37, -170.63), vect(-26.53, 67.62, -179.83)]
        Brain_Points = [vect(-80.12, 63.04, -160.04)]
    elif __getCurrentMap__() == Map.ILIOS_WELL:
        Bot_Respawn_Points = [vect(-185.28, 5.03, -42.68), vect(-186.79, 3.78, -56.12), vect(-163.67, 4.86, -38.01)]
        Brain_Points = [vect(-148.32, -3.41, -93.48)]
    elif __getCurrentMap__() == Map.NEPAL_VILLAGE:
        Bot_Respawn_Points = [vect(-169.79, -95.24, -33.05), vect(-199.72, -97.33, -54.5), vect(-163.22, -89.21, -28.77)]
        Brain_Points = [vect(-157.45, -97.52, -80.77)]
    elif __getCurrentMap__() == Map.NEPAL_SHRINE:
        Bot_Respawn_Points = [vect(-47.22, 19, -48.04), vect(-23.7, 22, -57.43), vect(-56.61, 15, -61.61)]
        Brain_Points = [vect(-43.18, 16.38, -88.26)]
    elif __getCurrentMap__() == Map.NEPAL_SANCTUM:
        Bot_Respawn_Points = [vect(81.12, 131.88, -34.95), vect(66.36, 127.8, -42.32), vect(106.84, 141.85, -52.18)]
        Brain_Points = [vect(81.03, 130.03, -84.94)]
    else:
    createEffect(getPlayers(Team.2), Effect.SPHERE, Color.YELLOW, Bot_Respawn_Points[0], 0.3, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createEffect(getPlayers(Team.2), Effect.SPHERE, Color.YELLOW, Bot_Respawn_Points[1], 0.3, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createEffect(getPlayers(Team.2), Effect.SPHERE, Color.YELLOW, Bot_Respawn_Points[2], 0.3, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createEffect(getPlayers(Team.2), Effect.SPHERE, Color.YELLOW, Bot_Respawn_Points[3], 0.3, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createEffect(getPlayers(Team.2), Effect.LIGHT_SHAFT, Color.WHITE, Brain_Points[0], 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)


rule "Player Resurrect - Respawn at Brain Points":
    @Event playerDied
    @Team 2
    @Condition isGameInProgress() == true
    #@Condition Under_Attack != true
    @Condition eventPlayer.isAlive() != true
    #@Condition (Current_Round == 4 or Current_Round == 6 or Current_Round == 8 or Current_Round == 10) == true

    #waitUntil(Current_Round == 4 or Current_Round == 6 or Current_Round == 8 or Current_Round == 10, 999999986991104)
    eventPlayer.teleport(Brain_Points[0])
    waitUntil(not Under_Attack and ((Current_Round == 4 or Current_Round == 6 or Current_Round == 8 or Current_Round == 10) == true), 999999986991104)
    eventPlayer.resurrect()


rule "Hud text":
    hudSubheader(getAllPlayers(), "植物大战僵尸 PvE（BMAMW）", HudPosition.RIGHT, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    hudSubheader(getAllPlayers(), "选择植物并保护你的脑子（白色光柱）", HudPosition.RIGHT, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    hudSubheader(getAllPlayers(), "准备时间结束后将不能移动", HudPosition.RIGHT, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)


rule "Players - HUD - Show round":
    @Condition Current_Round < Config_Total_Round

    hudText(getPlayers(Team.2), null, "\n\r\n\r\n\r\n\r\n\r", "第 {0}/{1} 波".format(Current_Round, Config_Total_Round), HudPosition.TOP, -3, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    hudSubtext(getPlayers(Team.2), "准备时间 {0}s".format(ceil(Round_Lead_Time)) if Under_Attack == false else "当前波次 {0}s".format(ceil(Round_Attack_Time)), HudPosition.TOP, -2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)


rule "Players - Round Lead Time Start":
    @Condition (isAssemblingHeroes() or isGameInProgress()) == true
    #@Condition isGameInProgress() == true
    @Condition Current_Round < Config_Total_Round
    @Condition Under_Attack == false

    waitUntil(not isAssemblingHeroes() and isGameInProgress(), 999999986991104)
    getPlayers(Team.1).setStatusEffect(null, Status.INVINCIBLE, 999999986991104)
    chaseOverTime(Round_Lead_Time, 0, Config_Round_Lead_Time, ChaseTimeReeval.NONE)
    bigMessage(getAllPlayers(), "第 {0} 波即将开始".format(Current_Round + 1))


rule "Players - Round Lead Time End":
    @Condition isGameInProgress() == true
    @Condition Current_Round < Config_Total_Round
    @Condition Under_Attack == false

    waitUntil(Round_Lead_Time == 0, Config_Round_Lead_Time)
    destroyAllDummies()
    Under_Attack = true
    Current_Round++
    Round_Attack_Time = Config_Round_Attack_Time
    Round_Lead_Time = 0


rule "Players - Round Attack Start":
    @Condition isGameInProgress() == true
    @Condition Current_Round < Config_Total_Round
    @Condition Under_Attack == true

    getPlayers(Team.1).clearStatusEffect(Status.INVINCIBLE)
    bigMessage(getAllPlayers(), "第 {0} 波进攻".format(Current_Round))
    chaseOverTime(Round_Attack_Time, 0, Config_Round_Attack_Time, ChaseTimeReeval.NONE)


rule "Players - Round Attack End":
    @Condition isGameInProgress() == true
    @Condition Current_Round < Config_Total_Round
    @Condition Under_Attack == true

    waitUntil(Round_Attack_Time == 0, Config_Round_Attack_Time)
    waitUntil(getNumberOfLivingPlayers(Team.1) == (len(getLivingPlayers(Team.1).filter(lambda player: distance(player.getPosition(), getSpawnPoints(Team.1).getPosition()) <= 55))) or len(getLivingPlayers(Team.1).filter(lambda player: distance(player.getPosition(), Brain_Points[0].getPosition()) >= 45)), 999999986991104)
    Under_Attack = false
    Round_Lead_Time = Config_Round_Lead_Time


def setThirdPerson():
    @Name "[utilities/Player]: Set Third Person"

    eventPlayer.startCamera(updateEveryFrame(raycastHitPosition(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + worldVector(vect(1 * (min(-2.5 / 2.5, -0.75)), 0, 0), eventPlayer, Transform.ROTATION) + updateEveryFrame(eventPlayer.getFacingDirection() * -2.5), getAllPlayers(), eventPlayer, false)), updateEveryFrame(raycastHitPosition(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 200, getAllPlayers(), eventPlayer, false)), 60)


rule "Set Third Person":
    @Event eachPlayer
    @Team 2
    @Disabled

    setThirdPerson()


rule "[debug.opy]: player debug (Top Right)":
    @Event eachPlayer
    @Condition Debug == true

    hudSubheader(eventPlayer, "重生室位置 = {0}".format(getSpawnPoints(Team.1).getPosition()), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    hudSubheader(eventPlayer, "重生室 = {0}/{1}".format(getLivingPlayers(Team.1).filter(lambda player: distance(player.getPosition(), getSpawnPoints(Team.1).getPosition()) <= 25), len(getLivingPlayers(Team.1))), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    hudSubheader(eventPlayer, "距离 = {0}".format(distance(eventPlayer.getPosition(), getSpawnPoints(Team.1).getPosition())), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    #hudSubheader(eventPlayer, "正在使用终极技能 = {0}".format(eventPlayer.isUsingUltimate()), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    #hudSubheader(eventPlayer, "正在使用主要武器 = {0}".format(eventPlayer.isFiringPrimaryFire()), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    #hudSubheader(eventPlayer, "正在使用辅助武器 = {0}".format(eventPlayer.isFiringSecondaryFire()), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    #hudSubheader(eventPlayer, "主要武器 资源 = {0}".format(eventPlayer.getAbilityResource(Button.PRIMARY_FIRE)), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    #hudSubheader(eventPlayer, "辅助武器 冷却时间 = {0}".format(eventPlayer.getAbilityCooldown(Button.SECONDARY_FIRE)), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    #hudSubheader(eventPlayer, "辅助武器 充能 = {0}".format(eventPlayer.getAbilityCharge(Button.SECONDARY_FIRE)), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    #hudSubheader(eventPlayer, "辅助武器 资源 = {0}".format(eventPlayer.getAbilityResource(Button.SECONDARY_FIRE)), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    #hudSubheader(eventPlayer, "R 冷却时间 = {0}".format(eventPlayer.getAbilityCooldown(Button.RELOAD)), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    #hudSubheader(eventPlayer, "isUsingAbility1() = {}".format(eventPlayer.isUsingAbility1()), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    #hudSubheader(eventPlayer, "正在使用技能 1 = {0}".format(eventPlayer.isUsingAbility1()), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    #hudSubheader(eventPlayer, "技能 1 冷却时间 = {0}".format(eventPlayer.getAbilityCooldown(Button.ABILITY_1)), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    #hudSubheader(eventPlayer, "技能 1 充能数量 = {0}".format(eventPlayer.getAbilityCharge(Button.ABILITY_1)), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    #hudSubheader(eventPlayer, "isUsingAbility2() = {}".format(eventPlayer.isUsingAbility2()), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    #hudSubheader(eventPlayer, "正在使用技能 2 = {0}".format(eventPlayer.isUsingAbility2()), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    #hudSubheader(eventPlayer, "技能 2 冷却时间 = {0}".format(eventPlayer.getAbilityCooldown(Button.ABILITY_2)), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    #hudSubheader(eventPlayer, "技能 2 充能数量 = {0}".format(eventPlayer.getAbilityCharge(Button.ABILITY_2)), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    hudSubheader(eventPlayer, "当前位置 = {0}".format(eventPlayer.getPosition()), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    #hudSubheader(eventPlayer, "当前速度 = {0}".format(eventPlayer.getSpeed()), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    #hudSubheader(eventPlayer, "当前速率 = {0}".format(eventPlayer.getVelocity()), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)


rule "[ai]: Set Bot Name":
    @Event eachPlayer
    @Team 1

    if eventPlayer.getHero() == Hero.BRIGITTE:
        eventPlayer.startForcingName("摇旗僵尸")
    elif eventPlayer.getHero() == Hero.DVA:
        eventPlayer.startForcingName("机甲僵尸")
    elif eventPlayer.getHero() == Hero.JUNO:
        eventPlayer.startForcingName("蹦极僵尸")
    elif eventPlayer.getHero() == Hero.HAZARD:
        eventPlayer.startForcingName("尖刺僵尸")
    elif eventPlayer.getHero() == Hero.JUNKER_QUEEN:
        eventPlayer.startForcingName("女王僵尸")
    elif eventPlayer.getHero() == Hero.ORISA:
        eventPlayer.startForcingName("钢板僵尸")
    elif eventPlayer.getHero() == Hero.RAMATTRA:
        eventPlayer.startForcingName("铁桶僵尸")
    elif eventPlayer.getHero() == Hero.REINHARDT:
        eventPlayer.startForcingName("冲锋僵尸")
    elif eventPlayer.getHero() == Hero.ROADHOG:
        eventPlayer.startForcingName("猪肉僵尸")
    elif eventPlayer.getHero() == Hero.ZARYA:
        eventPlayer.startForcingName("泡泡僵尸")
    elif eventPlayer.getHero() == Hero.MAUGA:
        eventPlayer.startForcingName("冲锋僵尸")
    elif eventPlayer.getHero() == Hero.ASHE:
        eventPlayer.startForcingName("炸药僵尸")
    elif eventPlayer.getHero() == Hero.BASTION:
        eventPlayer.startForcingName("机械僵尸")
    elif eventPlayer.getHero() == Hero.CASSIDY:
        eventPlayer.startForcingName("翻滚僵尸")
    elif eventPlayer.getHero() == Hero.ECHO:
        eventPlayer.startForcingName("飞行僵尸")
    elif eventPlayer.getHero() == Hero.GENJI:
        eventPlayer.startForcingName("跳跳僵尸")
    elif eventPlayer.getHero() == Hero.FREJA:
        eventPlayer.startForcingName("飞天僵尸")
    elif eventPlayer.getHero() == Hero.HANZO:
        eventPlayer.startForcingName("跳跳僵尸")
    elif eventPlayer.getHero() == Hero.PHARAH:
        eventPlayer.startForcingName("气球僵尸")
    elif eventPlayer.getHero() == Hero.SOLDIER:
        eventPlayer.startForcingName("跑步僵尸")
    elif eventPlayer.getHero() == Hero.SOJOURN:
        eventPlayer.startForcingName("滑铲僵尸")
    elif eventPlayer.getHero() == Hero.SOMBRA:
        eventPlayer.startForcingName("隐身僵尸")
    elif eventPlayer.getHero() == Hero.SYMMETRA:
        eventPlayer.startForcingName("摄像头僵尸")
    elif eventPlayer.getHero() == Hero.TORBJORN:
        eventPlayer.startForcingName("矮人僵尸")
    elif eventPlayer.getHero() == Hero.VENTURE:
        eventPlayer.startForcingName("矿工僵尸")
    elif eventPlayer.getHero() == Hero.LUCIO:
        eventPlayer.startForcingName("音乐僵尸")
    elif eventPlayer.getHero() == Hero.MOIRA:
        eventPlayer.startForcingName("生化僵尸")
    elif eventPlayer.getHero() == Hero.ZENYATTA:
        eventPlayer.startForcingName("出家僵尸")
    elif eventPlayer.getHero() == Hero.WIDOWMAKER:
        eventPlayer.startForcingName("抓钩僵尸")
    elif eventPlayer.getHero() == Hero.REAPER:
        eventPlayer.startForcingName("活神")
    else:


def AITarget():
    @Name "//AI Target"

    if eventPlayer.BotTarget == null or eventPlayer.BotTarget.isDead():
        eventPlayer.TTK = 0
        eventPlayer.BotTarget = random.choice(getLivingPlayers(getOppositeTeam(eventPlayer.getTeam())).filter(lambda player: isInLoS(eventPlayer.getEyePosition(), player) and player.hasSpawned() and player.getPosition().y - eventPlayer.getPosition().y <= 5.5))
        chaseAtRate(eventPlayer.TTK, 6, 1)
    elif eventPlayer.TTK == 6:
        eventPlayer.TTK = 0
        eventPlayer.BotTarget = random.choice(getLivingPlayers(getOppositeTeam(eventPlayer.getTeam())).filter(lambda player: isInLoS(eventPlayer.getEyePosition(), player) and player.hasSpawned() and player.getPosition().y - eventPlayer.getPosition().y <= 5.5))
        chaseAtRate(eventPlayer.TTK, 6, 1)


def AIMove():
    @Name "//AI Move"

    if eventPlayer.BotTarget == null or distance(eventPlayer, Brain_Points[0].getPosition()) <= distance(eventPlayer, eventPlayer.BotTarget):
        eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), Brain_Points[0].getPosition()), 270)
        eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, Brain_Points[0].getPosition()), 1, Relativity.TO_WORLD)
        if eventPlayer.getHorizontalSpeed() <= 1 and distance(eventPlayer, Brain_Points[0].getPosition()) >= 15 and distance(eventPlayer, getClosestPlayer(eventPlayer, Team.1)) >= 15:
            #if eventPlayer.getSlot() != 2:
            kill(eventPlayer)
            #else:
            #eventPlayer.teleport(getClosestPlayer(eventPlayer, Team.2))
            #__end__()
    else:
        eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), eventPlayer.BotTarget.getEyePosition() - vect(0, 0.3, 0)), 270)
        eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, eventPlayer.BotTarget), 1, Relativity.TO_WORLD)


rule "//AI Move":
    @Event eachPlayer
    @Team 1
    @Condition eventPlayer.isAlive() == true
    #@Condition isGameInProgress() == true
    #@Condition eventPlayer.getSlot() > 2
    @Condition eventPlayer.isDummy() == true
    @Condition Under_Attack == true

    wait(eventPlayer.getSlot() * 0.016, Wait.ABORT_WHEN_FALSE)
    AITarget()
    AIMove()
    eventPlayer.forceButtonPress(Button.JUMP)
    eventPlayer.forceButtonPress(Button.MELEE)
    wait(0.8)
    wait(0.3, Wait.ABORT_WHEN_FALSE)
    if ruleCondition:
        loop()


rule "[ai]: Use Ability 1":
    @Event eachPlayer
    @Team 1
    @Condition eventPlayer.isAlive() == true
    @Condition isGameInProgress() == true
    @Condition eventPlayer.getHero() in [Hero.JUNO, Hero.ORISA, Hero.SOJOURN, Hero.HAZARD, Hero.DVA, Hero.MAUGA, Hero.JUNKER_QUEEN, Hero.WINSTON, Hero.REINHARDT, Hero.FREJA, Hero.CASSIDY, Hero.ECHO, Hero.REAPER] == true
    @Condition Under_Attack == true

    wait(0.1, Wait.ABORT_WHEN_FALSE)
    eventPlayer.forceButtonPress(Button.ABILITY_1)
    eventPlayer.forceButtonPress(Button.JUMP)
    wait(0.6)
    eventPlayer.startForcingButton(Button.JUMP)
    wait(1.6)
    eventPlayer.stopForcingButton(Button.JUMP)
    if ruleCondition:
        loop()


rule "[ai]: venture Use Ability 1":
    @Event eachPlayer
    @Team 1
    @Hero venture
    @Condition eventPlayer.isAlive() == true
    @Condition isGameInProgress() == true
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_1) == 0
    @Condition Under_Attack == true

    wait(0.1, Wait.ABORT_WHEN_FALSE)
    #AITarget()
    #AIMove()
    eventPlayer.forceButtonPress(Button.ABILITY_1)
    wait(3.6)
    eventPlayer.forceButtonPress(Button.JUMP)
    if ruleCondition:
        loop()


rule "[ai]: brig Use ult":
    @Event eachPlayer
    @Team 1
    @Hero brigitte
    @Condition eventPlayer.isAlive() == true
    @Condition isGameInProgress() == true
    @Condition eventPlayer.getUltCharge() == 100
    @Condition Under_Attack == true

    wait(0.1, Wait.ABORT_WHEN_FALSE)
    eventPlayer.forceButtonPress(Button.ULTIMATE)
    wait(15)
    if ruleCondition:
        loop()


rule "[ai]: 76 Use Ability 1":
    @Event eachPlayer
    @Team 1
    @Hero soldier
    @Condition eventPlayer.isAlive() == true
    @Condition isGameInProgress() == true
    @Condition eventPlayer.isUsingAbility1() != true
    @Condition eventPlayer.getUltCharge() == 100
    @Condition Under_Attack == true

    wait(0.1, Wait.ABORT_WHEN_FALSE)
    eventPlayer.forceButtonPress(Button.ABILITY_1)


rule "[ai]: ram Use Ability 1":
    @Event eachPlayer
    @Team 1
    @Hero ramattra
    @Condition eventPlayer.isAlive() == true
    @Condition isGameInProgress() == true
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_1) == 0
    @Condition eventPlayer.isUsingAbility1() != true
    @Condition Under_Attack == true

    wait(0.1, Wait.ABORT_WHEN_FALSE)
    eventPlayer.forceButtonPress(Button.ABILITY_1)
    eventPlayer.startForcingButton(Button.SECONDARY_FIRE)
    wait(4)
    eventPlayer.stopForcingButton(Button.SECONDARY_FIRE)
    if ruleCondition:
        loop()


rule "[ai]: Pharah Use Ability 1":
    @Event eachPlayer
    @Team 1
    @Hero pharah
    @Condition eventPlayer.isAlive() == true
    @Condition isGameInProgress() == true
    @Condition eventPlayer.isInAir() != true
    @Condition Under_Attack == true

    wait(0.1, Wait.ABORT_WHEN_FALSE)
    eventPlayer.forceButtonPress(Button.ABILITY_1)
    eventPlayer.startForcingButton(Button.JUMP)
    wait(4)
    eventPlayer.stopForcingButton(Button.JUMP)
    if ruleCondition:
        loop()


rule "[ai]: Sombra Use Ability 2":
    @Event eachPlayer
    @Team 1
    @Hero sombra
    @Condition eventPlayer.isAlive() == true
    @Condition isGameInProgress() == true
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_2) == 0
    @Condition Under_Attack == true

    wait(0.1, Wait.ABORT_WHEN_FALSE)
    eventPlayer.forceButtonPress(Button.ABILITY_2)
    waitUntil(eventPlayer.getAbilityCooldown(Button.ABILITY_2) == 0, 30)
    wait(4)
    if ruleCondition:
        loop()


rule "[ai]: Create AI Bot":
    @Condition getNumberOfPlayers(Team.1) < NumberOfZombies

    createDummy(Hero.BRIGITTE, Team.1, -1, Bot_Respawn_Points[0].getPosition(), Brain_Points[0])
    while getNumberOfPlayers(Team.1) < NumberOfZombies:
        wait(0.16)
        #createDummy(random.choice(Zombie_Heros.filter(lambda x: getNumberOfHeroes(x, Team.1) == 0)), Team.1, -1, Bot_Respawn_Points[0].getPosition())
        createDummy(Zombie_Heros.filter(lambda x: getNumberOfHeroes(x, Team.1) <= 3), Team.1, -1, random.choice(Bot_Respawn_Points), Brain_Points[0])
    getPlayers(Team.1).setMoveSpeed(90)


rule "[ai]: Remove AI Bot":
    @Event playerDied
    @Team 1
    @Condition Under_Attack == true
    @Condition eventPlayer.isDummy() == true

    wait(1 if Current_Round == Config_Total_Round else 2)
    eventPlayer.teleport(random.choice(Bot_Respawn_Points))
    #eventPlayer.teleport(getSpawnPoints(Team.1))
    #destroyDummy(eventPlayer.getTeam(), eventPlayer.getSlot())
    #eventPlayer.setRespawnTime(9999)
    wait(3 if Current_Round == Config_Total_Round else 6)
    #if Round_Attack_Time == 0:
    #        goto lbl_0
    eventPlayer.respawn()
    lbl_0:


rule "[Mode]: TP to point":
    @Event eachPlayer
    @Team 1
    @Condition Under_Attack == true
    @Condition distance(eventPlayer.getPosition(), getSpawnPoints(eventPlayer.getTeam()).getPosition()) <= 55
    @Condition Round_Attack_Time != 0
    @Condition eventPlayer.isDummy() == true

    eventPlayer.teleport(random.choice(Bot_Respawn_Points))
    #wait(5)
    #if ruleCondition:
    #        loop()


rule "Barrier - Eat Brain":
    @Event eachPlayer
    @Team 1
    @Condition Debug != true
    @Condition isGameInProgress() == true
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.isOnGround() == true
    @Condition (distance(eventPlayer, Brain_Points[0]) <= 1 or len(getLivingPlayers(Team.2)) == 0) == true

    if eventPlayer.isAlive() == false:
        return
    wait(0.3)
    declareTeamVictory(Team.1)


rule "Barrier - Win":
    @Event eachPlayer
    @Team 1
    @Condition Debug != true
    @Condition isGameInProgress() == true
    @Condition Current_Round == Config_Total_Round
    @Condition Round_Attack_Time == 0
    #@Condition eventPlayer.isAlive() == true
    #@Condition eventPlayer.isOnGround() == true
    @Condition (distance(eventPlayer, Brain_Points[0]) > 1 or len(getLivingPlayers(Team.2)) > 0) == true

    #bigMessage(getAllPlayers(), "脑袋尖尖的")
    wait(1.5)
    declareTeamVictory(Team.2)


rule "[Player]: Stop move when under attack":
    @Event eachPlayer
    @Team 1
    @Condition Debug != true
    @Condition Under_Attack != true

    eventPlayer.startForcingThrottle(0, 0.01, 0, 0.01, 0, 0.01)
    eventPlayer.setStatusEffect(null, Status.ROOTED, 999999986991104)
    waitUntil(Under_Attack, 999999986991104)
    eventPlayer.clearStatusEffect(Status.ROOTED)
    eventPlayer.stopForcingThrottle()


rule "[Player]: Stop move when under attack":
    @Event eachPlayer
    @Team 2
    @Condition Debug != true
    @Condition Under_Attack == true
    @Condition eventPlayer.getHero() != Hero.TORBJORN

    smallMessage(eventPlayer, "  无法移动，正在防御中")
    eventPlayer.startForcingThrottle(0, 0.01, 0, 0.01, 0, 0.01)
    #eventPlayer.setStatusEffect(null, Status.ROOTED, 999999986991104)
    waitUntil(not Under_Attack, 999999986991104)
    smallMessage(eventPlayer, "  准备阶段，可以移动")
    eventPlayer.clearStatusEffect(Status.ROOTED)
    eventPlayer.stopForcingThrottle()


rule "[Player]: ult reset":
    @Event eachPlayer
    @Team 2
    @Condition eventPlayer.isUsingUltimate() == true
    @Condition eventPlayer.getHero() in [Hero.DOOMFIST, Hero.BASTION, Hero.REAPER] == true

    eventPlayer.stopForcingThrottle()
    waitUntil(not eventPlayer.isUsingUltimate(), 10)
    eventPlayer.startForcingThrottle(0, 0.01, 0, 0.01, 0, 0.01)


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
