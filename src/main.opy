settings {
    "main": {
        "description": "植物大战僵尸 PvE 代码: BMAMW \n\nKook频道：kook.vip/EEC9UH\n\n企鹅坐牢群：445152554\n\n最后更新| v26.1125.1",
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
        "tdm": {
            "enabledMaps": [
                "iliosRuins",
                "iliosLighthouse",
                "nepalShrine",
                "nepalSanctum",
                "nepalVillage",
                "lijiangNightMarket",
                "lijiangControlCenter",
                "lijiangGarden",
                "hollywood",
                "hollywoodHalloween",
                "blackForestWinter",
                "oasisCityCenter",
                "eichenwalde",
                "templeOfAnubis"
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
                "enableAbility2": false,
                "ability1Cooldown%": 500,
                "ability1Kb%": 0,
                "health%": 230,
                "movementGravity%": 90,
                "ultGen%": 25,
                "secondaryFireRechargeRate%": 500,
                "secondaryFireMaximumTime%": 500
            },
            "illari": {
                "enablePrimaryFire": false,
                "enableInfiniteAmmo": true,
                "health%": 230,
                "enableUlt": false
            },
            "hanzo": {
                "ability3Cooldown%": 275,
                "ability3Distance%": 85,
                "enablePrimaryFire": false,
                "damageReceived%": 105,
                "enableAbility2": false,
                "health%": 175,
                "enableUlt": false,
                "enableAbility1": false
            },
            "cassidy": {
                "enablePrimaryFire": false,
                "ability1Cooldown%": 200,
                "health%": 230,
                "enableUlt": false,
                "enableSecondaryFire": false,
                "ability2Cooldown%": 125
            },
            "lucio": {
                "enablePrimaryFire": false,
                "jumpVerticalSpeed%": 90,
                "health%": 230,
                "movementSpeed%": 50,
                "enableSecondaryFire": false,
                "ultGen%": 500
            },
            "bastion": {
                "enablePrimaryFire": false,
                "jumpVerticalSpeed%": 150,
                "health%": 250,
                "movementSpeed%": 50,
                "ultDuration%": 25
            },
            "soldier": {
                "enablePrimaryFire": false,
                "healingDealt%": 150,
                "health%": 160,
                "ability2Cooldown%": 67,
                "movementSpeed%": 50,
                "enableUlt": false,
                "enableSecondaryFire": false
            },
            "mercy": {
                "weaponsEnabled": "staff",
                "health%": 150,
                "movementSpeed%": 55,
                "enableUlt": false,
                "ability2Cooldown%": 120
            },
            "orisa": {
                "enablePrimaryFire": false,
                "ability1Cooldown%": 100,
                "enableAbility2": true,
                "health%": 115,
                "movementSpeed%": 50,
                "enableSecondaryFire": false
            },
            "ana": {
                "enablePrimaryFire": false,
                "damageDealt%": 130,
                "combatUltGen%": 130,
                "healingDealt%": 175,
                "health%": 175,
                "ability2Cooldown%": 180,
                "movementSpeed%": 50,
                "ultGen%": 130,
                "passiveUltGen%": 140,
                "ability1Cooldown%": 190
            },
            "baptiste": {
                "enablePrimaryFire": false,
                "ability1Cooldown%": 300,
                "healingDealt%": 175,
                "health%": 250,
                "movementSpeed%": 50,
                "ultGen%": 140,
                "ability2Cooldown%": 240
            },
            "brigitte": {
                "secondaryFireRechargeRate%": 75,
                "combatUltGen%": 110,
                "enableAbility1": false,
                "health%": 230,
                "movementSpeed%": 50,
                "ultGen%": 110,
                "passiveUltGen%": 110,
                "shieldBashCooldown%": 400,
                "shieldBashKb%": 25,
                "enableSpawningWithUlt": true
            },
            "torbjorn": {
                "weaponsEnabled": "hammer",
                "jumpVerticalSpeed%": 150,
                "ammoClipSize%": 50,
                "combatUltGen%": 0,
                "projectileGravity%": 400,
                "ability2Cooldown%": 35,
                "ability2Duration%": 25,
                "health%": 325,
                "movementSpeed%": 50,
                "ultGen%": 10,
                "ultDuration%": 25,
                "passiveUltGen%": 0,
                "enableSecondaryFire": false,
                "enableAbility1": false
            },
            "ramattra": {
                "health%": 115,
                "enablePrimaryFire": false,
                "enableAbility2": false,
                "ability1Cooldown%": 0,
                "enableUlt": false
            },
            "venture": {
                "health%": 115,
                "enablePrimaryFire": false,
                "enableUlt": false,
                "ability1Cooldown%": 50,
                "ability1Duration%": 300
            },
            "doomfist": {
                "enablePrimaryFire": false,
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
                "health%": 115,
                "enablePrimaryFire": false,
                "damageDealt%": 227,
                "jumpVerticalSpeed%": 150,
                "enableSecondaryFire": false,
                "ability2Cooldown%": 20
            },
            "zarya": {
                "enablePrimaryFire": false,
                "jumpVerticalSpeed%": 125,
                "projectileSpeed%": 125,
                "ability2Cooldown%": 75,
                "health%": 230,
                "movementSpeed%": 50,
                "ability1Cooldown%": 75,
                "enableUlt": false,
                "enableSecondaryFire": false
            },
            "reaper": {
                "enablePrimaryFire": false,
                "ability2Cooldown%": 140,
                "healingDealt%": 35,
                "health%": 230,
                "movementSpeed%": 50,
                "enableUlt": false
            },
            "mauga": {
                "health%": 115,
                "damageDealt%": 227,
                "enablePrimaryFire": false,
                "enableSecondaryFire": false,
                "enableUlt": false,
                "ability1Kb%": 0
            },
            "pharah": {
                "enablePrimaryFire": false,
                "damageDealt%": 227,
                "damageReceived%": 105,
                "jumpVerticalSpeed%": 80,
                "enablePassiveUnlimitedFuel": true,
                "primaryFireKb%": 75,
                "health%": 115,
                "movementSpeed%": 50,
                "enableUlt": false,
                "enableAbility2": false,
                "ability2Kb%": 25
            },
            "junkerQueen": {
                "enablePrimaryFire": false,
                "ability1Cooldown%": 67,
                "health%": 230,
                "movementSpeed%": 50,
                "secondaryFireKb%": 0,
                "锯齿利刃（格雷西）": "关闭"
            },
            "winston": {
                "health%": 115,
                "enablePrimaryFire": false,
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
                "damageDealt%": 227,
                "damageReceived%": 95,
                "combatUltGen%": 180,
                "health%": 230,
                "movementSpeed%": 50,
                "ultGen%": 180,
                "ultDuration%": 175,
                "passiveUltGen%": 180,
                "enableSecondaryFire": false,
                "ability2Cooldown%": 100
            },
            "junkrat": {
                "enablePrimaryFire": false,
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
                "combatUltGen%": 300,
                "projectileGravity%": 200,
                "health%": 500,
                "movementSpeed%": 50,
                "ultGen%": 300,
                "passiveUltGen%": 300,
                "enableSpawningWithUlt": true,
                "ability2Cooldown%": 125
            },
            "lifeweaver": {
                "weaponsEnabled": "healingBlossom",
                "enableAbility2": false
            },
            "wreckingBall": {
                "enablePrimaryFire": false,
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
                "health%": 175,
                "movementSpeed%": 50,
                "enableSecondaryFire": false,
                "enableSpawningWithUlt": true,
                "ultGen%": 500
            },
            "symmetra": {
                "enablePrimaryFire": false,
                "enableAbility2": false,
                "damageDealt%": 170,
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
                "damageReceived%": 100,
                "health%": 160,
                "movementSpeed%": 50,
                "充能射击": "关闭"
            },
            "mei": {
                "enablePrimaryFire": false,
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
                "ability1Cooldown%": 300,
                "ability2MaxDamage%": 10,
                "ability2Cooldown%": 225,
                "ability2MaxHealing%": 150,
                "primaryFireRechargeRate%": 125,
                "health%": 230,
                "ultDuration%": 25,
                "enableUlt": false,
                "enableSecondaryFire": false
            },
            "reinhardt": {
                "ability1Cooldown%": 175,
                "ability1Kb%": 15,
                "secondaryFireRechargeRate%": 75,
                "enableAbility2": false,
                "health%": 55,
                "movementSpeed%": 50,
                "enableUlt": false
            },
            "sigma": {
                "enablePrimaryFire": false,
                "ability1Cooldown%": 200,
                "secondaryFireCooldown%": 300,
                "projectileSpeed%": 50,
                "health%": 145,
                "movementSpeed%": 50,
                "enableUlt": false,
                "ability2Cooldown%": 200
            },
            "roadhog": {
                "enablePrimaryFire": false,
                "healingReceived%": 85,
                "health%": 300,
                "movementSpeed%": 50,
                "enableUlt": false,
                "enableAbility1": false
            },
            "kiriko": {
                "enablePrimaryFire": false,
                "health%": 230
            },
            "hazard": {
                "enablePrimaryFire": false,
                "enableAbility2": false,
                "尖刺护体移动速度惩罚": "150%",
                "尖刺护体资源消耗": "0%",
                "health%": 175,
                "enableUlt": false
            },
            "sombra": {
                "enablePrimaryFire": false,
                "ability2Cooldown%": 400,
                "projectileGravity%": 500,
                "health%": 115,
                "enableUlt": false,
                "secondaryFireCooldown%": 250
            },
            "widowmaker": {
                "enablePrimaryFire": false,
                "ability2Cooldown%": 140,
                "ability1Cooldown%": 200,
                "projectileGravity%": 80,
                "health%": 160,
                "movementSpeed%": 50,
                "ultDuration%": 300,
                "enableSpawningWithUlt": true
            },
            "echo": {
                "health%": 115
            },
            "freja": {
                "health%": 115
            },
            "general": {
                "damageDealt%": 180,
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
                "callMechKb%": 125,
                "ability2Cooldown%": 28,
                "ability1Cooldown%": 350,
                "ability1Kb%": 125,
                "movementGravity%": 60,
                "selfDestructKb%": 125
            },
            "illari": {
                "damageDealt%": 120,
                "solarEnergyMax%": 500,
                "solarEnergyRecharge%": 500,
                "projectileSpeed%": 100,
                "enableInfiniteAmmo": false,
                "ability2Cooldown%": 50
            },
            "hanzo": {
                "ability3Cooldown%": 275,
                "ability3Distance%": 85,
                "damageDealt%": 90,
                "ability1Cooldown%": 0
            },
            "cassidy": {
                "damageDealt%": 95,
                "ability1Cooldown%": 250,
            },
            "lucio": {
                "damageDealt%": 125,
                "projectileSpeed%": 200,
                "enableInfiniteAmmo": false,
                "enableSpawningWithUlt": true,
                "secondaryFireKb%": 150
            },
            "echo": {
                "ability2Cooldown%": 75,
                "secondaryFireCooldown%": 67
            },
            "bastion": {
                "damageDealt%": 90,
                "jumpVerticalSpeed%": 230,
                "enableInfiniteAmmo": false,
                "ultDuration%": 75
            },
            "soldier": {
                "damageDealt%": 95,
                "ability2Cooldown%": 67,
                "ultDuration%": 200,
                "enableSpawningWithUlt": true
            },
            "mercy": {
                "damageDealt%": 95,
                "enableInfiniteAmmo": false,
                "ability2Cooldown%": 8
            },
            "orisa": {
                "projectileSpeed%": 130,
                "ability1Cooldown%": 150,
                "enableInfiniteAmmo": false,
                "secondaryFireCooldown%": 50
            },
            "ana": {
                "damageDealt%": 110,
                "ability2Cooldown%": 150,
                "ability1Cooldown%": 72
            },
            "baptiste": {
                "damageDealt%": 110,
                "enableInfiniteAmmo": false,
                "healingDealt%": 50,
            },
            "brigitte": {
                "damageDealt%": 170,
                "damageReceived%": 90,
                "secondaryFireRechargeRate%": 200,
                "secondaryFireCooldown%": 100,
                "ability1Kb%": 125,
                "shieldBashKb%": 300,
                "enableSpawningWithUlt": true
            },
            "freja": {
                "ability2Cooldown%": 80,
                "secondaryFireCooldown%": 75
            },
            "torbjorn": {
                "damageDealt%": 100,
                "weaponsEnabled": "hammer",
                "ammoClipSize%": 50,
                "projectileGravity%": 200,
                "ability2Cooldown%": 40,
                "ability2Duration%": 200,
                "movementSpeed%": 75,
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
                "enableInfiniteAmmo": false,
                "secondaryFireCooldown%": 120,
                "secondaryFireKb%": 120,
                "ultDuration%": 50,
                "ability2Cooldown%": 124
            },
            "juno": {
                "damageDealt%": 130,
                "enableInfiniteAmmo": false,
                "secondaryFireCooldown%": 120,
                "ability2Cooldown%": 20
            },
            "zarya": {
                "damageDealt%": 120,
                "damageReceived%": 90,
                "jumpVerticalSpeed%": 125,
                "projectileSpeed%": 130,
                "ability2Cooldown%": 89,
                "enableInfiniteAmmo": false,
                "ability1Cooldown%": 73,
            },
            "reaper": {
                "damageDealt%": 120,
                "damageReceived%": 90,
                "ability1Cooldown%": 95,
                "enableInfiniteAmmo": false,
                "ability2Cooldown%": 125,
                "healingDealt%": 105,
                "movementSpeed%": 75,
            },
            "mauga": {
                "ability2Cooldown%": 50,
                "primaryFireIgniteDamage": 166,
                "primaryFireIgniteDuration": 150,
                "enableAbility1": false
            },
            "pharah": {
                "damageDealt%": 95,
                "passiveRechargeRate%": 15,
                "passiveMaxTime%": 60,
                "enableAbility1": false,
                "enableInfiniteAmmo": false,
                "primaryFireKb%": 75,
                "ability2Cooldown%": 200
            },
            "junkerQueen": {
                "damageDealt%": 125,
                "damageReceived%": 90,
                "ability1Cooldown%": 67,
                "secondaryFireKb%": 0
            },
            "winston": {
                "damageDealt%": 130,
                "ultKb%": 125,
                "ability1Cooldown%": 110,
                "ability1Kb%": 125,
                "jumpVerticalSpeed%": 110,
                "ability2Cooldown%": 75,
                "enableInfiniteAmmo": false,
            },
            "genji": {
                "damageReceived%": 100,
                "projectileSpeed%": 225,
                "ability1Cooldown%": 150,
                "enableInfiniteAmmo": false,
                "ultDuration%": 134,
                "ability2Cooldown%": 50
            },
            "junkrat": {
                "damageDealt%": 90,
                "projectileSpeed%": 125,
                "ability2Cooldown%": 200,
                "enableInfiniteAmmo": false,
                "primaryFireKb%": 75,
                "movementGravity%": 110,
                "ultDuration%": 50,
                "ability1Cooldown%": 300,
                "ability1Kb%": 55
            },
            "tracer": {
                "damageDealt%": 95,
                "enableInfiniteAmmo": false,
                "ability2Cooldown%": 275,
                "ability1Cooldown%": 450
            },
            "lifeweaver": {
                "ability1Cooldown%": 200,
                "enableInfiniteAmmo": false,
                "ability2Cooldown%": 50,
                "primaryFireRange%": 200,
                "secondaryFireCooldown%": 20
            },
            "wreckingBall": {
                "damageDealt%": 135,
                "secondaryFireCooldown%": 50,
                "ability1Kb%": 150,
                "enableInfiniteAmmo": false,
                "ability3Cooldown%": 30,
                "enableSpawningWithUlt": true
            },
            "zenyatta": {
                "damageReceived%": 90,
                "projectileSpeed%": 200,
                "enableInfiniteAmmo": false,
            },
            "symmetra": {
                "ability2Cooldown%": 275,
                "damageDealt%": 80,
                "ability1Cooldown%": 260,
                "jumpVerticalSpeed%": 150,
                "enableInfiniteAmmo": false,
                "movementGravity%": 75,
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
                "projectileGravity%": 110,
                "enableInfiniteAmmo": false,
                "ultFreezeRate%": 120,
                "ultFreezeMinimum%": 40,
            },
            "ashe": {
                "damageDealt%": 90,
                "ability1EnemyKb%": 150,
                "ability2Cooldown%": 50,
                "ability2FuseTime%": 1,
                "enableInfiniteAmmo": false,
                "ability1Cooldown%": 80,
            },
            "moira": {
                "damageDealt%": 120,
                "damageReceived%": 90,
                "jumpVerticalSpeed%": 110,
                "ability1Cooldown%": 225,
                "ability2Cooldown%": 75,
                "ability2MaxHealing%": 200,
                "primaryFireRechargeRate%": 500,
            },
            "reinhardt": {
                "damageDealt%": 130,
                "ability1Cooldown%": 144,
                "ability1Kb%": 250,
                "damageReceived%": 90,
                "secondaryFireRechargeRate%": 150,
                "secondaryFireCooldown%": 0,
                "projectileSpeed%": 150,
                "primaryFireKb%": 250,
                "ability2Cooldown%": 72,
            },
            "sigma": {
                "damageDealt%": 130,
                "ability1Cooldown%": 0,
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
                "enableInfiniteAmmo": false,
                "healingDealt%": 50,
                "ability1Cooldown%": 55,
                "ultKb%": 125
            },
            "kiriko": {
                "ability1Distance%": 300,
                "damageDealt%": 115,
                "projectileSpeed%": 115,
                "无需装弹": "开启",
                "healingDealt%": 160,
                "ability2Cooldown%": 53
            },
            "hazard": {
                "damageReceived%": 90,
                "尖刺墙生命值": "400%",
                "尖刺护体资源恢复": "200%",
                "尖刺护体资源消耗": "50%",
                "ability1Cooldown%": 134
            },
            "sombra": {
                "damageDealt%": 95,
                "ability2Cooldown%": 500,
                "projectileGravity%": 120,
                "enableInfiniteAmmo": false,
                "secondaryFireCooldown%": 250
            },
            "widowmaker": {
                "damageDealt%": 100,
                "ability2Cooldown%": 110,
                "ammoClipSize%": 25,
                "ability1Cooldown%": 200,
                "projectileGravity%": 80,
                "ultDuration%": 300,
                "enableSpawningWithUlt": true
            },
            "shion": {
                "movementSpeed%": 75,
                "ability2Duration%": 500
            },
            "enabledHeroes": [
                "reaper"
            ],
            "general": {
                "damageDealt%": 120,
                "damageReceived%": 110,
                "healingReceived%": 120,
                "jumpVerticalSpeed%": 100,
                "projectileSpeed%": 115,
                "healingDealt%": 125,
                "movementSpeed%": 100,
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

# 颜色/贴图标签(<fg...>, <TX...>)需要它; 编译器会生成一条开局规则, 临时生成并移除一个机器人以取得未转义的 "<"。
#!setupTags
#!include "env/vars.opy"

subroutine AITarget 1
subroutine AIMove 2
subroutine setThirdPerson 3
subroutine applyAllowedHeroes 4
subroutine knockBack 5
subroutine refreshTarget 6
subroutine stuckCheck 7

# 扩展点数按"禁用的玩家栏位"计算(每格 4 点), 数量有限, 所以把对玩法影响最大的
# 生成更多机器人(2 点)放第一位, 避免点数不够时被其它视觉扩展挤掉。
#!extension spawnMoreDummyBots
#!extension buffStatusEffects
#!extension debuffStatusEffects
#!extension buffAndDebuffSounds
#!extension energyExplosionEffects
#!extension kineticExplosionEffects
#!extension explosionSounds
#!extension playMoreEffects


#Only remove the following directive if the gamemode does not use tricks such as A+0, A*0, A or "", "am" == "**", etc which would otherwise be optimized out.
#!optimizeStrict

#!postCompileHook "../postCompileHook.js"

#!include "mode/init.opy"
#!include "mode/difficulty.opy"
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
# 生命池子程序先于 progression 引入, 科技文件与生命周期流程都能直接调用。
#!include "player/feska/tech/shield.opy"
#!include "player/feska/unique.opy"
#!include "player/feska/pools.opy"
#!include "player/progression.opy"
