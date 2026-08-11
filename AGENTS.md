# Plants vs. Zombies: Agent Work Entry

This file is the repository-wide source of truth for coding-agent instructions.
Read it before changing source. A nested `AGENTS.md`, when present, applies to
its directory and takes precedence over this file for that scope.

## Repository boundary

- This repository owns an Overwatch Workshop PvE mode inspired by Plants vs. Zombies and authored with OverPy.
- Players act as stationary plants. AI-controlled zombies are spawned and managed by Workshop logic.
- The repository owns the OverPy source under `src/`, the local compile/import helpers, and the related documentation.
- Do not make changes in another repository or assume a server-side component exists unless the user explicitly expands the task.
- Compiled Workshop output is generated data, not source. `.ow` exports and `*.compiled.ow` outputs are not committed.

## Instruction priority

When instructions conflict, follow this order:

1. Explicit instructions in the current task.
2. The nearest directory-level `AGENTS.md`.
3. This root `AGENTS.md`.
4. Existing repository conventions.
5. General OverPy and Workshop conventions.

Do not override an explicit project rule merely because another design appears cleaner or more conventional.

## Rule organization

- This root file contains rules that apply to all source, tooling, and documentation work.
- Module-specific rules belong in a nested `AGENTS.md` for that module when they are needed; do not duplicate them here.
- `README.md` is the human-facing repository map and import/compile guide.
- `package.json` is the authority for available local commands. Do not document a test, lint, or format command unless it exists there or is otherwise verified in the repository.
- `src/main.opy` is the source entry point. Its settings, variable declarations, subroutine numbers, extensions, post-compile hook, and `#!include` order are part of the source contract.
- Until topic-specific rule documents exist, the detailed gameplay, state, lifecycle, and validation rules below remain authoritative.

## Current rule index

Before editing, start with the smallest relevant set of files:

| Task area | Read first | Preserve or verify |
| --- | --- | --- |
| Repository orientation and toolchain | `README.md`, `package.json`, `src/main.opy` | Source/generated boundaries and available commands |
| Global state, player state, and subroutines | `src/env/vars.opy`, declarations in `src/main.opy` | Variable ownership, raw indexes, subroutine numbers, and include order |
| Mode setup, map, waves, and victory | `src/mode/init.opy`, `src/mode/map.opy`, `src/mode/rounds.opy`, `src/mode/victory.opy` | Round transitions, spawn locations, win/loss conditions, and reset behavior |
| Zombie lifecycle and AI | `src/ai/lifecycle.opy`, `src/ai/core.opy`, `src/ai/abilities.opy` | Spawn/init, target acquisition, movement, melee behavior, death, and cleanup |
| Planted-player movement and hero mechanics | `src/player/movement.opy`, `src/heroes/abilities.opy` | Stationary-player invariant, temporary exceptions, respawn, and hero changes |
| HUD, debug display, and camera | `src/ui/`, `src/utilities/camera.opy` | Presentation reevaluation and camera/effect cleanup |
| Game export/import | `README.md`, `scripts/import.sh`, `scripts/fix-pvz2-decompiled.py`, `postCompileHook.js` | The import overwrite boundary, targeted workarounds, and `zh-CN` behavior |

Read direct callers and consumers as well as the file being changed. Do not infer source-level structure from compiled Workshop output.

## General workflow

1. Confirm the requested outcome, repository boundary, current branch/worktree, and working-tree status.
2. Read this file, any applicable nested `AGENTS.md`, the relevant README/tooling guidance, and the affected source with its direct callers.
3. Trace the change from producer to consumer to persisted or displayed state. Identify whether each value is global, per-player, per-zombie, or per-round, and which rule owns its lifecycle.
4. Search for an existing implementation before adding a helper, rule, variable, array, or parallel representation.
5. Identify source files versus generated outputs. Modify OverPy source rather than compiled Workshop output, and preserve the relative order of `#!include` directives unless the task explicitly changes rule ordering.
6. Implement the smallest coherent change. Preserve unrelated user changes, public identifiers, array layouts, subroutine numbers, configuration semantics, and difficulty behavior.
7. Run the strongest relevant local validation, review the complete diff, and report confirmed results separately from in-game checks that were not performed.

## Change scope

Prefer the smallest coherent change that solves the requested problem. Agents must not:

- rewrite unrelated rules;
- perform repository-wide renaming without necessity;
- reformat unrelated files;
- replace established systems with speculative abstractions;
- change difficulty behavior outside the requested scope;
- rebalance unrelated heroes or zombies;
- silently change public identifiers, array layouts, save formats, or configuration semantics.

When a broader refactor is genuinely required, explain why the requested change cannot be implemented safely within the current structure before expanding the scope.

The import workflow is exceptional: `pnpm run decompile /path/to/export.ow` ultimately writes `src/main.opy` and produces a single-file result that must be split back into modules. Check the working tree before using it and do not overwrite existing source accidentally.

## Core gameplay contract

These behaviors are mode invariants, not optional implementation preferences.

### Planted players

Once planted, a player must not regain ordinary free movement unless a mechanic explicitly and temporarily permits it.

Changes must not accidentally allow movement through:

- ability interactions;
- knockback handling;
- respawn handling;
- hero changes;
- state reset;
- round transitions;
- teleportation or position-correction logic.

Mechanics that inherently require sustained movement must be adapted to stationary gameplay or rejected as incompatible.

### Zombie control

Zombies are script-managed AI entities. Their lifecycle generally includes:

1. spawn;
2. initialization;
3. target acquisition;
4. movement or path progression;
5. attack behavior;
6. death, despawn, or round cleanup.

Standard zombies must remain melee-only unless the relevant zombie type, mechanic, or difficulty rule explicitly enables ranged behavior.

Do not convert ordinary zombies to ranged attackers as a workaround for pathfinding, targeting, or balance problems.

When modifying zombie AI, evaluate target selection and loss, unreachable targets, path progression, melee range, attack cooldown, line of sight where relevant, crowding, player death/removal, zombie death during an action, round termination, and special difficulty overrides. Special zombies should declare only their differences from standard behavior where the current architecture supports that approach.

Difficulty modifiers should extend or configure the base AI rather than duplicate the full AI loop unless duplication is unavoidable.

### Overwatch adaptation

The mode may borrow defensive structure and pacing from PvZ, but mechanics must be designed around:

- Overwatch heroes;
- actual hero abilities and weapon behavior;
- Workshop-supported actions;
- map geometry;
- Workshop performance limits.

Do not introduce a literal PvZ mechanic without first establishing how it functions in Overwatch gameplay.

## State ownership

Every state value must have an identifiable owner and lifecycle. Before adding or changing state, determine:

- whether it is global or entity-specific;
- when it is initialized;
- which rule is authoritative;
- which rules may mutate it;
- when it becomes invalid;
- how it is reset;
- whether an external entity or effect handle must be destroyed.

Avoid multiple competing representations of the same gameplay state. Where practical, keep these categories conceptually separate:

- authoritative gameplay state;
- player state;
- zombie state;
- wave and spawning state;
- external entity or effect handles;
- temporary calculation state;
- UI and visual presentation state.

The repository's existing representation takes precedence over introducing a new architecture.

## Arrays and indexing

Workshop and OverPy arrays are performance-sensitive and may use copy-style operations.

Agents must:

- verify array-operation semantics before relying on in-place mutation;
- assign the returned array when an operation produces a new array;
- preserve parallel-array alignment;
- update all related arrays when deleting or inserting values;
- avoid repeated array rebuilding inside high-frequency rules;
- document new raw numeric indexes when no named abstraction exists;
- reuse existing index constants, aliases, enums, or helper functions where available.

Do not infer that raw indexes in compiled or converted Workshop code prove that the original source lacked aliases or structured representations.

## Entity and effect lifecycle

Persistent Workshop objects require explicit lifecycle management. This includes, where applicable:

- dummy bots;
- effects;
- in-world text;
- HUD text;
- chase operations;
- camera state;
- status effects;
- damage-over-time or healing-over-time effects;
- references stored in variables or arrays.

For every persistent object:

1. Store its handle if later cleanup is required.
2. Destroy or stop it when its owning state ends.
3. Clear the stored reference.
4. Make cleanup safe when called more than once where feasible.
5. Ensure round reset and player removal cannot leave stale state.

Do not add pooling before lifecycle correctness has been established. Reused objects must have all relevant state reset before returning to active use. Use short-lived effects for presentation that does not require later mutation or gameplay readback.

## Performance

Workshop performance is a gameplay constraint, not a later optimization concern.

Avoid:

- unnecessary per-frame rules;
- repeated global scans of every player and zombie;
- reconstructing large arrays in hot paths;
- repeatedly creating and destroying persistent effects;
- expensive calculations whose inputs have not changed;
- multiple rules independently calculating the same authoritative result;
- visual reevaluation that is not visible or useful to players.

Prefer:

- event-driven updates;
- cached derived values when invalidation is clear;
- staggered or batched processing;
- early exits;
- filtering before expensive calculations;
- explicit update intervals appropriate to the mechanic.

Do not reduce gameplay correctness merely to remove a small theoretical cost. Optimize measured or structurally obvious hot paths first.

## Source, generated output, and code style

- Treat generated Workshop code as output unless the repository explicitly changes that policy.
- Do not directly edit generated output as the primary implementation.
- Do not infer source-level architecture from converted Workshop text, or treat missing names, modules, enums, comments, or aliases in converted code as evidence that they never existed.
- Do not commit `*.ow` or `*.compiled.ow`; use the normal compile/import workflow when generated output must be refreshed locally.
- Preserve `src/main.opy` settings, named variables, subroutine numbers, extensions, post-compile hook, and module include order unless the task requires a contract change.
- Follow the surrounding source style: use descriptive identifiers, keep rules focused, extract repeated nontrivial expressions when that improves correctness, preserve domain terminology, and comment intent or Workshop-specific limitations rather than restating syntax.
- Avoid abstractions used only once unless they enforce an important invariant.
- Comments and documentation may be written in Chinese; identifiers should follow the dominant naming convention of the surrounding code.

## Validation and gameplay verification

The current package exposes these commands:

```sh
# Compile the OverPy source to ignored Workshop output.
pnpm run compile

# Import a game-exported .ow file back into src/main.opy.
pnpm run decompile /path/to/export.ow
```

`pnpm run compile` is the current automated compilation gate. It compiles `src/main.opy` with `zh-CN`, writes `main.compiled.ow`, and applies `postCompileHook.js`. The package currently has no separate test, lint, or format script; do not claim those checks were run.

After source changes, verify at minimum:

### Compilation

- OverPy compilation succeeds.
- No unresolved symbols or invalid actions are introduced.
- Generated Workshop output remains within relevant limits where such checks exist.

### Gameplay behavior

- players remain planted;
- ordinary zombies retain melee-only behavior;
- special ranged behavior is limited to intended cases;
- spawned zombies initialize correctly;
- targets are acquired and released correctly;
- death and round cleanup remove temporary state;
- the changed mechanic resets correctly between rounds or waves.

### Lifecycle and performance

- persistent effects and entities are cleaned up;
- handles do not remain in active collections after destruction;
- player departure and round termination do not leave stale references;
- cleanup does not destroy unrelated objects;
- no new unbounded loop or uncontrolled polling is introduced;
- new high-frequency logic has a justified execution interval;
- array rebuilding and global scans are not added unnecessarily.

Automated compilation cannot reproduce Workshop gameplay. Unless an actual in-game test was performed, state the movement, AI, lifecycle, round-reset, and map-geometry scenarios that still require in-game verification. Do not claim gameplay has been verified in Overwatch based only on compilation or static inspection.

## Git and delivery

- Inspect `git status` before editing and treat pre-existing or concurrent changes as user-owned.
- Respect the current branch and worktree. Do not move, overwrite, or revert user changes to create a cleaner workspace.
- Stage only files or hunks owned by the current task. Before committing, inspect the staged diff and run `git diff --check`.
- For implementation tasks, commit verified task-owned changes by default unless the user asks for inspection only, a draft, or no commit. Use a concise descriptive message and verify the stored commit message after committing.
- Do not push, amend, rewrite history, merge, publish, or modify remote state unless the user explicitly requests it.
- Do not use destructive Git commands or permanent deletion to resolve unrelated workspace dirt.

## Safety baseline and prohibited assumptions

- Keep credentials, tokens, authorization files, private identifiers, screenshots, runtime logs, and secrets out of tracked files, documentation, commits, and tool output.
- Do not delete data or overwrite source without clear task scope. The decompile/import helper is a known exception only when the user intends to replace and re-split the source.
- Do not assume all hero abilities work while a player is immobilized.
- Do not assume AI pathfinding will always reach a planted player.
- Do not assume dummy bots automatically clean themselves up.
- Do not assume array mutations are always in place.
- Do not assume persistent effects disappear when a rule stops evaluating.
- Do not assume Workshop-generated code preserves original source abstractions.
- Do not assume a mechanic possible in Overwatch gameplay is necessarily exposed to Workshop.
- Do not accept a visually attractive mechanic regardless of runtime cost.

When an API, action, event, hero property, or OverPy feature is uncertain, inspect project usage or authoritative documentation rather than inventing syntax. If a requested change touches movement, AI targeting, persistent entities/effects, public identifiers, subroutine numbers, array layouts, or reset contracts, call out the risk before expanding the scope.

## Reporting changes

The final response for an implementation task should include:

- what changed and why;
- important implementation decisions;
- files modified;
- validation performed;
- remaining in-game verification;
- known risks or limitations.

For analysis-only tasks, distinguish clearly between confirmed behavior from the repository, likely behavior inferred from code, proposed changes, and Workshop limitations that still require validation.
