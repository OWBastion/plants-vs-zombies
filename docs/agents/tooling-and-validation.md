# Tooling, generated output, and validation

Read when compiling, importing, or finishing a change.

## Commands

`package.json` is the authority. Available:

```sh
pnpm run compile                       # wright: src/main.opy -> main.compiled.ow (zh-CN, postCompileHook.js, then scripts/post-compile.js)
pnpm run decompile /path/to/export.ow  # import a game export into src/main.opy
```

There is no test, lint, or format script; do not claim those ran.

## Source vs. generated output

- Edit OverPy source, never compiled or converted Workshop output. Do not infer source architecture from converted text.
- Do not commit `*.ow` or `*.compiled.ow`.
- Preserve `src/main.opy` settings, named variables, subroutine numbers, extensions, post-compile hook, and `#!include` order unless the task changes that contract.
- Rule order in the compiled output follows `#!include` order. Keep the relative order of rules unchanged, or Workshop execution semantics change.
- Compile and decompile both use `zh-CN`. The overpy zh-CN word list and the game client differ slightly in some wording (for example `关闭` vs `禁用`). If a setting does not take effect after pasting into the game, fix it in `postCompileHook.js`.

## Compile pipeline

`pnpm run compile` runs wright, then `scripts/post-compile.js`. Each fix below is a workaround for an upstream bug. Delete the fix when the upstream issue is resolved.

| Step | Fix | Remove when |
| --- | --- | --- |
| `postCompileHook.js` (triggered by `#!postCompileHook` in `src/main.opy`; runs before setting-name localization, so it sees English setting names) | Output English keys for the team deathmatch general settings and the Roadhog breather setting | opy-rs#723 |
| same | Health pack respawn setting name differs from the client | workshop-rs#621 |
| same | Stale `黑客入侵冷却时间` after the Sombra rework becomes `在线修复冷却时间` (new name is a guess) | workshop-rs#617 |
| `scripts/post-compile.js` (runs on the final text) | Strip the `全局.` prefix wright adds to chase global-variable actions. The client accepts only the bare variable name | workshop-rs#620 |

`#!postCompileHook` cannot do the last fix: wright re-parses the hook output and adds the prefix again.

## Decompile / import

`pnpm run decompile` overwrites `src/main.opy` with a single file that must be re-split into modules. Check the working tree first. Use it only when the user intends to replace and re-split source.

`scripts/import.sh` does three things:

1. Replace `无` with `全部禁用` in chase enum arguments only.
2. Decompile with overpy.
3. Run `scripts/fix-pvz2-decompiled.py`. It restores three team 2 settings that the old overpy include/exclude list drops silently: Mauga `终极技能持续时间无限`, Sojourn `终极技能持续时间 150%`, Kiriko `无需装弹`. It also appends `#!postCompileHook`.

If an export changes and the script anchors no longer match, the script fails with an explicit error. Update the anchors from the message.

## Validation

`pnpm run compile` is the only automated gate: it must succeed with no unresolved symbols or invalid actions.

Compilation cannot reproduce Workshop gameplay. Unless tested in-game, list the scenarios still needing in-game checks and do not claim gameplay was verified. Typical ones:

- Players remain planted; ordinary zombies stay melee-only.
- Zombies initialize, acquire and release targets correctly.
- Death and round cleanup remove temporary state; the mechanic resets between rounds/waves.
- Effects/entities are cleaned up; no stale handles after player departure or round end.
- No new unbounded loop or uncontrolled polling; new high-frequency logic has a justified interval.
