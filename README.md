# 植物大战僵尸 PvE

Overwatch Workshop PvE 模式（植物大战僵尸），使用 [OverPy](https://github.com/Zezombye/overpy) 编写。队伍 1 为 AI 僵尸（dummy bot），队伍 2 为玩家（植物）。

## 目录结构

- `src/main.opy` — 入口：settings、变量 include、按依赖顺序的模块 include。
- `src/env/vars.opy` — 全局/玩家变量声明。
- `src/mode/` — 模式初始化（`init`）、地图与出生点（`map`）、波次计时（`rounds`）、胜负条件（`victory`）。
- `src/ai/` — 目标选取与移动（`core`）、生成/移除/重生（`lifecycle`）、技能施放（`abilities`）。
- `src/heroes/abilities.opy` — 植物各英雄能力。
- `src/player/movement.opy` — 玩家移动限制。
- `src/player/progression.opy` — 费斯卡科技与属性强化：共享子程序、选牌流程、目录组装。
- `src/player/feska/tech/*.opy` — 每项科技一个文件：目录行宏 `FESKA_ROW_*` 与该科技的规则。
- `src/ui/` — HUD（`hud`）与调试显示（`debug`）。
- `src/utilities/camera.opy` — 第三人称相机。
- `postCompileHook.js`、`scripts/post-compile.js` — 编译后处理，详见 [`docs/agents/tooling-and-validation.md`](docs/agents/tooling-and-validation.md)。
- `docs/agents/` — 面向 agent 的分主题规则，入口见 [`AGENTS.md`](AGENTS.md)。

`.ow`（游戏导出/编译产物）不入库。

## 工作流

```sh
# 编译（需要 wright）：src/main.opy -> main.compiled.ow（gitignored，直接粘贴进游戏）
pnpm run compile
```

模块边界与 `#!include` 顺序即编译产物中的规则顺序。改动时保持规则相对顺序不变，以免改变 Workshop 执行语义。
