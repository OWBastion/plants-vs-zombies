#!/usr/bin/env python3
"""反编译后的针对性修复（overpy 9.7.9 数据缺陷，不修改 overpy 本体）。

适用场景: 植物大战僵尸模式的游戏导出（.ow）反编译输出;锚点针对当前 main.opy
的内容编写,若导出内容变化导致锚点失配,脚本会显式报错,需按报错更新锚点。

修复内容（均为队伍2/植物侧的设置,overpy 过旧 include/exclude 列表导致反编译静默丢弃）:
- 毛加「终极技能持续时间无限」(enableInfiniteUlt include 缺 mauga)
- 索杰恩「终极技能持续时间 150%」(ultDuration% include 缺 sojourn)
- 雾子「无需装弹」(enableInfiniteAmmo exclude 误含 kiriko)
以中文字面量键写入,编译端会原样保留。
另追加 #!postCompileHook 指令:编译时把 chase 枚举「全部禁用」改回游戏导出的「无」。

用法: python3 fix-pvz2-decompiled.py <反编译输出> <修复后输出>
"""
import sys


def replace_once(text: str, old: str, new: str, label: str) -> str:
    count = text.count(old)
    if count != 1:
        sys.exit(f"anchor 不唯一或不存在 ({label}): 找到 {count} 处, 期望 1 处。"
                 f"若 pvz2.ow 内容已变化,请手工更新本脚本。")
    return text.replace(old, new)


def main() -> None:
    if len(sys.argv) != 3:
        sys.exit("用法: python3 fix-pvz2-decompiled.py <输入> <输出>")
    src, dst = sys.argv[1], sys.argv[2]
    text = open(src, encoding="utf-8").read()

    # 1. 队伍2 毛加: enableInfiniteUlt include 列表缺 mauga
    text = replace_once(
        text,
        '"mauga": {\n'
        '                "damageReceived%": 400,\n'
        '                "ammoClipSize%": 200,\n'
        '                "ability2Cooldown%": 50,\n'
        '                "primaryFireIgniteDamage": 166,\n'
        '                "primaryFireIgniteDuration": 150,\n'
        '                "health%": 50,\n'
        '                "enableAbility1": false\n'
        '            },',
        '"mauga": {\n'
        '                "damageReceived%": 400,\n'
        '                "ammoClipSize%": 200,\n'
        '                "ability2Cooldown%": 50,\n'
        '                "primaryFireIgniteDamage": 166,\n'
        '                "primaryFireIgniteDuration": 150,\n'
        '                "health%": 50,\n'
        '                "终极技能持续时间无限": "开启",\n'
        '                "enableAbility1": false\n'
        '            },',
        "队伍2 毛加 终极技能持续时间无限",
    )

    # 2. 队伍2 索杰恩: ultDuration% include 列表缺 sojourn
    text = replace_once(
        text,
        '"sojourn": {\n'
        '                "充能速度 充能射击": "125%",\n'
        '                "ability2Cooldown%": 54\n'
        '            },',
        '"sojourn": {\n'
        '                "充能速度 充能射击": "125%",\n'
        '                "终极技能持续时间": "150%",\n'
        '                "ability2Cooldown%": 54\n'
        '            },',
        "队伍2 索杰恩 终极技能持续时间",
    )

    # 3. 队伍2 雾子: enableInfiniteAmmo exclude 列表误含 kiriko
    text = replace_once(
        text,
        '"kiriko": {\n'
        '                "ability1Distance%": 300,\n'
        '                "damageDealt%": 115,\n'
        '                "projectileSpeed%": 115,\n'
        '                "healingDealt%": 160,\n'
        '                "ultGen%": 185,\n'
        '                "ability2Cooldown%": 53\n'
        '            },',
        '"kiriko": {\n'
        '                "ability1Distance%": 300,\n'
        '                "damageDealt%": 115,\n'
        '                "projectileSpeed%": 115,\n'
        '                "无需装弹": "开启",\n'
        '                "healingDealt%": 160,\n'
        '                "ultGen%": 185,\n'
        '                "ability2Cooldown%": 53\n'
        '            },',
        "队伍2 雾子 无需装弹",
    )

    # 4. 追加 postCompileHook 指令
    text = replace_once(
        text,
        "#!optimizeStrict\n",
        "#!optimizeStrict\n\n#!postCompileHook \"postCompileHook.js\"\n",
        "postCompileHook 指令",
    )

    # 清理行尾空白与末尾空行,保持 git diff --check 干净
    lines = [line.rstrip() for line in text.split("\n")]
    while lines and lines[-1] == "":
        lines.pop()
    open(dst, "w", encoding="utf-8", newline="\n").write("\n".join(lines) + "\n")


if __name__ == "__main__":
    main()
