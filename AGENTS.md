# Plants vs. Zombies: Agent Instructions

Overwatch Workshop PvE mode inspired by Plants vs. Zombies, authored in OverPy. Players are stationary plants; AI zombies are spawned and managed by Workshop logic.

This file holds the rules that always apply. Detailed rules live in `docs/agents/`; read the topic file when your task matches (see the index below). A nested `AGENTS.md`, if present, overrides this file for its directory.

## Boundary

- This repo owns the OverPy source in `src/`, the compile/import helpers, and the docs. Do not change other repositories or assume a server-side component unless the user expands the task.
- Compiled Workshop output (`*.ow`, `*.compiled.ow`) is generated and never committed. Edit source only.
- Priority when rules conflict: current task, nearest nested `AGENTS.md`, this file, existing repo conventions, general OverPy/Workshop conventions.
- `README.md` is the human repo map and import guide; `package.json` is the authority for commands; `src/main.opy` is the entry point whose settings, variables, subroutine numbers, extensions, hook, and `#!include` order are a contract.

## Invariants

- Planted players never regain free movement unless a mechanic explicitly and temporarily allows it.
- Standard zombies are melee-only unless a type, mechanic, or difficulty rule says otherwise.
- Every state value and persistent object (bot, effect, text, chase, camera, handle) has an owner and a cleanup path that survives round reset and player removal.
- Do not silently change public identifiers, array layouts, subroutine numbers, config semantics, or difficulty behavior.
- Array operations may return copies; verify before relying on in-place mutation.

## Index: read before editing

| Task | Read |
| --- | --- |
| Movement, heroes, zombie AI, waves, new mechanics | `docs/agents/gameplay.md` |
| Variables, arrays, subroutines, bots, effects, HUD, camera | `docs/agents/state-and-lifecycle.md` |
| Frequent rules, scans, hot paths | `docs/agents/performance.md` |
| Compile, import/decompile, generated output, validation | `docs/agents/tooling-and-validation.md` |

Source map (read the file plus its direct callers and consumers):

| Area | Files |
| --- | --- |
| Variables | `src/env/vars.opy`, declarations in `src/main.opy` |
| Mode, map, rounds, victory | `src/mode/{init,map,rounds,victory}.opy` |
| Zombie lifecycle and AI | `src/ai/{lifecycle,core,abilities}.opy` |
| Player movement, hero abilities | `src/player/movement.opy`, `src/heroes/abilities.opy` |
| HUD, debug, camera | `src/ui/`, `src/utilities/camera.opy` |

## Workflow

1. Confirm the outcome, branch/worktree, and `git status`; treat existing changes as the user's.
2. Read the relevant topic doc and the affected source with its callers; trace each value from producer to consumer and identify its owner and lifecycle.
3. Reuse existing helpers, variables, and rules before adding new ones.
4. Make the smallest coherent change: no unrelated rewrites, renames, reformatting, rebalancing, or speculative abstractions. If a broader refactor is truly needed, explain why first.
5. Follow surrounding style. Comments may be Chinese; identifiers follow the local convention. Comment intent or Workshop limits, not syntax.
6. Run `pnpm run compile`, review the full diff, and keep verified results separate from in-game checks not performed.

If an API, action, or OverPy feature is uncertain, check project usage or authoritative docs instead of inventing syntax. Call out the risk before expanding scope into movement, AI targeting, persistent objects, public identifiers, subroutine numbers, array layouts, or reset contracts.

## Git and reporting

Git rules follow the user's global instructions: stage only task-owned changes, run `git diff --check`, commit verified work, and do not push, amend, or rewrite history unless asked. Keep secrets, logs, and screenshots out of the repo.

Implementation reports state what changed and why, files modified, validation run, remaining in-game verification, and known risks. Analysis reports separate confirmed repository behavior, inferences, proposals, and Workshop limits needing validation.
