# 植物大战僵尸 PvE

Overwatch Workshop PvE 模式（植物大战僵尸），使用 [OverPy](https://github.com/Zezombye/overpy) 编写。队伍 1 为 AI 僵尸（dummy bot），队伍 2 为玩家（植物）。

## 目录结构

- `src/main.opy` — 入口：settings、变量 include、按依赖顺序的模块 include。
- `src/env/vars.opy` — 全局/玩家变量声明。
- `src/mode/` — 模式初始化（`init`）、地图与出生点（`map`）、波次计时（`rounds`）、胜负条件（`victory`）。
- `src/ai/` — 目标选取与移动（`core`）、生成/移除/重生（`lifecycle`）、技能施放（`abilities`）。
- `src/heroes/abilities.opy` — 植物各英雄能力。
- `src/player/movement.opy` — 玩家移动限制。
- `src/ui/` — HUD（`hud`）与调试显示（`debug`）。
- `src/utilities/camera.opy` — 第三人称相机。
- `postCompileHook.js`、`scripts/` — 编译与导入的后处理，详见 [`docs/agents/tooling-and-validation.md`](docs/agents/tooling-and-validation.md)。
- `docs/agents/` — 面向 agent 的分主题规则，入口见 [`AGENTS.md`](AGENTS.md)。

`.ow`（游戏导出/编译产物）不入库。

## 工作流

```sh
# 编译：src/main.opy -> main.compiled.ow（gitignored，直接粘贴进游戏）
pnpm run compile

# 导入：把游戏里新导出的 .ow 反编译回 src/main.opy
# pnpm 不要带 `--`；用 npm 时才需要 `npm run decompile -- <file>`
pnpm run decompile /path/to/export.ow
```

反编译产出是单文件，会覆盖 `src/main.opy`，导入后需按 `#!include` 顺序重新拆分模块。除非需要与游戏往返同步，否则不推荐反复导入。

模块边界与 `#!include` 顺序即编译产物中的规则顺序。改动时保持规则相对顺序不变，以免改变 Workshop 执行语义。
