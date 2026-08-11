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

#!include "env/vars.opy"

#Subroutine names

subroutine AITarget 1
subroutine AIMove 2
subroutine setThirdPerson 3
subroutine setPlayerHeros 4
subroutine knockBack 5
subroutine refreshTarget 6
subroutine stuckCheck 7

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

#!postCompileHook "../postCompileHook.js"

#!include "mode/init.opy"
#!include "mode/map.opy"
#!include "ui/hud.opy"
#!include "mode/rounds.opy"
#!include "utilities/camera.opy"
#!include "ui/debug.opy"
#!include "ai/core.opy"
#!include "ai/abilities.opy"
#!include "ai/lifecycle.opy"
#!include "mode/victory.opy"
#!include "player/movement.opy"
#!include "heroes/abilities.opy"
