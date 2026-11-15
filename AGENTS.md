# Plants vs. Zombies: Agent Instructions

Overwatch Workshop PvE mode inspired by Plants vs. Zombies, authored in OverPy. Players are stationary plants. Workshop logic spawns and manages the AI zombies.

This file holds only the rules that always apply. Load a topic doc from the index when the task matches it. A nested `AGENTS.md` overrides this file for its directory.

## Boundary

- This repo owns the OverPy source in `src/`, the compile/import helpers, and the docs. Do not change other repositories. Do not assume a server-side component.
- Compiled output (`*.ow`, `*.compiled.ow`) is generated and never committed. Edit source only.
- `package.json` is the authority for commands. `README.md` holds the directory map and the human workflow.
- `src/main.opy` is a contract: settings, variables, subroutine numbers, extensions, the post-compile hook, and `#!include` order.
- Conflict priority: current task, nearest `AGENTS.md`, this file, repo conventions, general OverPy/Workshop conventions.

## Invariants

- Planted players never regain free movement unless a mechanic explicitly and temporarily allows it.
- Standard zombies are melee-only unless a type, mechanic, or difficulty rule says otherwise.
- Every state value and persistent object (bot, effect, text, chase, camera, handle) has an owner and a cleanup path. The path must survive round reset and player removal.
- Do not silently change public identifiers, array layouts, subroutine numbers, config semantics, or difficulty behavior.
- An array operation may return a copy. Verify before you rely on in-place mutation.

## Read before editing

| Task | Read |
| --- | --- |
| Find a file or module | `README.md` (directory map) |
| Movement, heroes, zombie AI, waves, new mechanics | `docs/agents/gameplay.md` |
| Variables, arrays, subroutines, bots, effects, HUD, camera | `docs/agents/state-and-lifecycle.md` |
| Frequent rules, scans, hot paths | `docs/agents/performance.md` |
| Compile, decompile/import, post-compile fixes, validation | `docs/agents/tooling-and-validation.md` |

## Workflow

1. Check `git status`. Treat existing changes as the user's.
2. Read the topic doc and the affected source with its callers. Trace each value from producer to consumer. Identify its owner and lifecycle.
3. Reuse existing helpers, variables, and rules before you add new ones.
4. Make the smallest coherent change. Do not add unrelated rewrites, renames, reformatting, rebalancing, or speculative abstractions. Explain first if a broader refactor is needed.
5. Follow the surrounding style. Comments may be Chinese. Comment intent or Workshop limits, not syntax.
6. Run `pnpm run compile`. Review the full diff. Report in-game checks you did not perform.

If an API, action, or OverPy feature is uncertain, check project usage or authoritative docs. Do not invent syntax. Call out the risk before you expand scope into movement, AI targeting, persistent objects, public identifiers, subroutine numbers, array layouts, or reset contracts.

## Reporting

- Implementation: what changed and why, files, validation run, remaining in-game checks, known risks.
- Analysis: separate confirmed repo behavior, inferences, proposals, and Workshop limits that need validation.
