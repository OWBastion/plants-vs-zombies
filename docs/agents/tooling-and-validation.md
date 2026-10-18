# Tooling, generated output, and validation

Read when compiling, importing, or finishing a change.

## Commands

`package.json` is the authority. Available:

```sh
pnpm run compile                       # src/main.opy -> main.compiled.ow (zh-CN, postCompileHook.js)
pnpm run decompile /path/to/export.ow  # import a game export into src/main.opy
```

There is no test, lint, or format script; do not claim those ran.

## Source vs. generated output

- Edit OverPy source, never compiled or converted Workshop output. Do not infer source architecture from converted text.
- Do not commit `*.ow` or `*.compiled.ow`.
- Preserve `src/main.opy` settings, named variables, subroutine numbers, extensions, post-compile hook, and `#!include` order unless the task changes that contract.
- `decompile` overwrites `src/main.opy` with a single file that must be re-split into modules. Check the working tree first; use it only when the user intends to replace and re-split source. See `README.md`, `scripts/import.sh`, `scripts/fix-pvz2-decompiled.py`.

## Validation

`pnpm run compile` is the only automated gate: it must succeed with no unresolved symbols or invalid actions.

Compilation cannot reproduce Workshop gameplay. Unless tested in-game, list the scenarios still needing in-game checks and do not claim gameplay was verified. Typical ones:

- Players remain planted; ordinary zombies stay melee-only.
- Zombies initialize, acquire and release targets correctly.
- Death and round cleanup remove temporary state; the mechanic resets between rounds/waves.
- Effects/entities are cleaned up; no stale handles after player departure or round end.
- No new unbounded loop or uncontrolled polling; new high-frequency logic has a justified interval.
