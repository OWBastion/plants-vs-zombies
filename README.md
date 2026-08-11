# 植物大战僵尸 PvE

Overwatch Workshop PvE 模式（植物大战僵尸），使用 [OverPy](https://github.com/Zezombye/overpy) 编写。

## 目录结构

- `src/main.opy` — 入口（队伍 1 为 AI 僵尸（dummy bot），队伍 2 为玩家（植物））。包含 settings、变量/环境 include 与按依赖顺序的模块 include。
- `src/env/vars.opy` — 全局/玩家变量声明。
- `src/mode/` — 模式初始化（`init.opy`）、地图与出生点（`map.opy`）、波次计时（`rounds.opy`）、胜负条件（`victory.opy`）。
- `src/ai/` — AI 核心（目标选取/移动，`core.opy`）、生成/移除/重生（`lifecycle.opy`）、技能施放（`abilities.opy`）。
- `src/heroes/abilities.opy` — 玩家（植物）各英雄能力规则。
- `src/player/movement.opy` — 玩家移动限制。
- `src/ui/` — HUD 与调试显示（`hud.opy`、`debug.opy`）。
- `src/utilities/camera.opy` — 第三人称相机。
- `postCompileHook.js` — 编译后处理：overpy 9.7.9 的 zh-CN 数据里 chase 函数的 "None" 枚举是过期的「全部禁用」，当前游戏客户端导出/接受的是「无」，此处仅在该枚举处替换回「无」。
- `scripts/fix-pvz2-decompiled.py` — 反编译后处理：overpy 过旧 include/exclude 列表会静默丢弃 3 条队伍 2 设置（毛加「终极技能持续时间无限」、索杰恩「终极技能持续时间 150%」、雾子「无需装弹」），此处以中文字面量键恢复，并追加 `#!postCompileHook` 指令。
- `package.json` / `pnpm-lock.yaml` / `.gitignore` — 工具链。

`.ow`（游戏导出/编译产物）不入库。

## 工作流

```sh
# 编译：src/main.opy -> main.compiled.ow（gitignored，直接粘贴进游戏）
pnpm run compile

# 导入：把游戏里新导出的 .ow 反编译回 src/main.opy
# 注意: pnpm 会原样保留 `--`, 不要带; 用 npm 时才需要 `npm run decompile -- <file>`
pnpm run decompile /path/to/export.ow
```

导入时反编译会先对输入做定点预处理（`无` → `全部禁用`，仅 chase 枚举处），再用
`scripts/fix-pvz2-decompiled.py` 恢复被 overpy 丢弃的设置。若导出的模式内容发生变化导致脚本锚点失配，脚本会显式报错，届时按报错信息更新锚点即可。

> 注意：反编译产出是单文件，导入会覆盖 `src/main.opy`，模块拆分需在导入后按
> `#!include` 顺序重新组织；除非需要与游戏往返同步，否则不推荐反复导入。

## 说明

- 反编译/编译均使用 `zh-CN`（源文件为简体中文导出）。
- overpy 自带的 zh-CN 词表与客户端版本之间存在少量措辞漂移（如部分开关用「关闭」而客户端导出「禁用」），语义等价；若游戏内粘贴遇到个别设置不生效，可扩展 `postCompileHook.js` 逐设置修正。
- 模块边界与 `#!include` 顺序即编译产物中的规则顺序，改动时应保持规则相对顺序不变，以免改变 Workshop 执行语义。
