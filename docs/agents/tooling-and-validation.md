# Tooling, generated output, and validation

Read when compiling or finishing a change.

## Commands

`package.json` is the authority. Available (wright must be on `PATH`; the repo has no npm dependencies):

```sh
pnpm run compile                       # wright: src/main.opy -> main.compiled.ow (zh-CN, postCompileHook.js, then scripts/post-compile.js)
```

There is no test, lint, or format script; do not claim those ran.

## Source vs. generated output

- Edit OverPy source, never compiled or converted Workshop output. Do not infer source architecture from converted text.
- Do not commit `*.ow` or `*.compiled.ow`.
- Preserve `src/main.opy` settings, named variables, subroutine numbers, extensions, post-compile hook, and `#!include` order unless the task changes that contract.
- Rule order in the compiled output follows `#!include` order. Keep the relative order of rules unchanged, or Workshop execution semantics change.
- Compile uses `zh-CN`. The wright zh-CN word list and the game client differ slightly in some wording (for example `关闭` vs `禁用`). If a setting does not take effect after pasting into the game, fix it in `postCompileHook.js`.

## Compile pipeline

`pnpm run compile` runs wright, then `scripts/post-compile.js`. Each fix below is a workaround for an upstream bug. Delete the fix when the upstream issue is resolved.

| Step | Fix | Remove when |
| --- | --- | --- |
| `postCompileHook.js` (triggered by `#!postCompileHook` in `src/main.opy`; runs before setting-name localization, so it sees English setting names) | Output English keys for the team deathmatch general settings and the Roadhog breather setting | opy-rs#723 |
| same | Health pack respawn setting name differs from the client | workshop-rs#621 |
| same | Stale `黑客入侵冷却时间` after the Sombra rework becomes `在线修复冷却时间` (new name is a guess) | workshop-rs#617 |
| `scripts/post-compile.js` (runs on the final text) | Strip the `全局.` prefix wright adds to chase global-variable actions. The client accepts only the bare variable name | workshop-rs#620 |

`#!postCompileHook` cannot do the last fix: wright re-parses the hook output and adds the prefix again.

## Import

There is no decompile path. wright `convert` refuses this mode's game export (`unsupported-settings`), and the overpy workflow was removed. `src/` is the only source: edit `.opy` by hand.

## Validation

`pnpm run compile` is the only automated gate: it must succeed with no unresolved symbols or invalid actions.

Compilation cannot reproduce Workshop gameplay. Unless tested in-game, list the scenarios still needing in-game checks and do not claim gameplay was verified. Typical ones:

- Players remain planted; ordinary zombies stay melee-only.
- Zombies initialize, acquire and release targets correctly.
- Death and round cleanup remove temporary state; the mechanic resets between rounds/waves.
- Effects/entities are cleaned up; no stale handles after player departure or round end.
- No new unbounded loop or uncontrolled polling; new high-frequency logic has a justified interval.
