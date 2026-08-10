# AGENTS.md

## 1. Purpose

This repository contains an Overwatch Workshop PvE mode authored with OverPy.

The mode is structurally inspired by Plants vs. Zombies:

* Players act as stationary plants.
* After a player is planted, normal player-controlled movement is disabled.
* Players defend their position using hero attacks, abilities, and terrain.
* AI-controlled zombies are spawned and managed by Workshop logic.
* Standard zombies use melee attacks by default.
* Ranged attacks are reserved for explicitly designed zombie types, mechanics, or difficulty modifiers.

This document defines repository-wide rules for coding agents. More specific `AGENTS.md` files may extend these rules for individual directories.

---

## 2. Instruction Priority

When instructions conflict, follow this order:

1. Explicit instructions in the current task.
2. The nearest directory-level `AGENTS.md`.
3. This root `AGENTS.md`.
4. Existing repository conventions.
5. General OverPy and Workshop conventions.

Do not override an explicit project rule merely because another design appears cleaner or more conventional.

---

## 3. Core Gameplay Invariants

The following behavior is considered part of the mode's core contract.

### 3.1 Planted players

Once planted, a player must not regain ordinary free movement unless a mechanic explicitly and temporarily permits it.

Changes must not accidentally allow movement through:

* ability interactions;
* knockback handling;
* respawn handling;
* hero changes;
* state reset;
* round transitions;
* teleportation or position correction logic.

Mechanics that inherently require sustained movement must be adapted to stationary gameplay or rejected as incompatible.

### 3.2 Zombie control

Zombies are script-managed AI entities. Their lifecycle generally includes:

1. spawn;
2. initialization;
3. target acquisition;
4. movement or path progression;
5. attack behavior;
6. death, despawn, or round cleanup.

Standard zombies must remain melee-only unless the relevant zombie type or difficulty rule explicitly enables ranged behavior.

Do not convert ordinary zombies to ranged attackers as a workaround for pathfinding, targeting, or balance problems.

### 3.3 Overwatch adaptation

The project may borrow the defensive structure and pacing of PvZ, but mechanics must be designed around:

* Overwatch heroes;
* actual hero abilities and weapon behavior;
* Workshop-supported actions;
* map geometry;
* Workshop performance limits.

Do not introduce a literal PvZ mechanic without first establishing how it functions in Overwatch gameplay.

---

## 4. Repository Discovery

Before modifying code:

1. Read this file and any nested `AGENTS.md`.
2. Inspect the relevant source files and their direct callers.
3. Identify which files are source files and which are generated outputs.
4. Find the existing compile, lint, formatting, and validation commands.
5. Search for existing implementations before creating new helpers or systems.
6. Determine whether the affected values are global, per-player, per-zombie, or per-round.

Do not assume directory names, build commands, variable conventions, or generated-file policies that are not present in the repository.

Unless the repository explicitly says otherwise, modify the OverPy source rather than compiled Workshop output.

---

## 5. Change Scope

Prefer the smallest coherent change that solves the requested problem.

Agents must not:

* rewrite unrelated rules;
* perform repository-wide renaming without necessity;
* reformat unrelated files;
* replace established systems with speculative abstractions;
* change difficulty behavior outside the requested scope;
* rebalance unrelated heroes or zombies;
* silently change public identifiers, array layouts, save formats, or configuration semantics.

When a broader refactor is genuinely required, explain why the requested change cannot be implemented safely within the current structure.

---

## 6. State Ownership

Every state value should have an identifiable owner and lifecycle.

When adding or changing state, determine:

* whether it is global or entity-specific;
* when it is initialized;
* which rule is authoritative;
* which rules may mutate it;
* when it becomes invalid;
* how it is reset;
* whether an external entity or effect handle must be destroyed.

Avoid creating multiple competing representations of the same gameplay state.

Where practical, keep these categories conceptually separate:

* authoritative gameplay state;
* player state;
* zombie state;
* wave and spawning state;
* external entity or effect handles;
* temporary calculation state;
* UI and visual presentation state.

The repository's existing representation takes precedence over introducing a new architecture.

---

## 7. Arrays and Indexing

Workshop and OverPy arrays are performance-sensitive and may use copy-style operations.

Agents must:

* verify the semantics of an array operation before relying on in-place mutation;
* assign the returned array when using operations that produce a new array;
* preserve parallel-array alignment;
* avoid deleting or inserting values in one related array without updating the others;
* avoid repeated array rebuilding inside high-frequency rules;
* document new raw numeric indexes when no named abstraction exists;
* reuse existing index constants, aliases, enums, or helper functions where available.

Do not infer that raw indexes in compiled or converted Workshop code prove that the original source lacked aliases or structured representations.

---

## 8. Entity and Effect Lifecycle

Persistent Workshop objects require explicit lifecycle management.

This includes, where applicable:

* dummy bots;
* effects;
* in-world text;
* HUD text;
* chase operations;
* camera state;
* status effects;
* damage-over-time or healing-over-time effects;
* references stored in variables or arrays.

For every persistent object:

1. store its handle if later cleanup is required;
2. destroy or stop it when its owning state ends;
3. clear the stored reference;
4. make cleanup safe when called more than once where feasible;
5. ensure round reset and player removal cannot leave stale state.

Do not add pooling before lifecycle correctness has been established. Reused objects must have all relevant state reset before returning to active use.

Use short-lived effects for presentation that does not require later mutation or gameplay readback.

---

## 9. AI Behaviour Changes

When modifying zombie AI, evaluate at least:

* target selection;
* target loss;
* unreachable targets;
* path progression;
* melee range;
* attack cooldown;
* line of sight where relevant;
* crowding and multiple zombies sharing a target;
* player death or removal;
* zombie death during an action;
* round and wave termination;
* special difficulty overrides.

Difficulty modifiers should extend or configure the base AI rather than duplicate the full AI loop unless duplication is unavoidable.

Special zombies should declare only their differences from standard zombies where the current architecture supports that approach.

---

## 10. Performance

Workshop performance is a gameplay constraint, not a later optimization concern.

Avoid:

* unnecessary per-frame rules;
* repeated global scans of every player and zombie;
* reconstructing large arrays in hot paths;
* repeatedly creating and destroying persistent effects;
* expensive calculations whose inputs have not changed;
* multiple rules independently calculating the same authoritative result;
* visual reevaluation that is not visible or useful to players.

Prefer:

* event-driven updates;
* cached derived values when invalidation is clear;
* staggered or batched processing;
* early exits;
* filtering before expensive calculations;
* explicit update intervals appropriate to the mechanic.

Do not reduce gameplay correctness merely to remove a small theoretical cost. Optimize measured or structurally obvious hot paths first.

---

## 11. Code Style

Follow the existing repository style.

Unless the repository establishes a different convention:

* use descriptive identifiers;
* keep gameplay rules focused on one responsibility;
* extract repeated nontrivial expressions when doing so improves correctness;
* comment intent and Workshop-specific limitations rather than restating syntax;
* preserve domain terminology used elsewhere in the project;
* avoid introducing abstractions used only once unless they enforce an important invariant.

Comments and documentation may be written in Chinese. Identifiers should follow the dominant language and naming convention of the surrounding code.

---

## 12. Generated and Converted Code

Treat generated Workshop code as an output unless the repository explicitly uses it as a source.

Do not:

* directly edit generated output as the primary implementation;
* infer source-level architecture from converted Workshop text;
* treat missing names, modules, enums, comments, or aliases in converted code as evidence they never existed;
* commit regenerated output unless repository policy requires it.

When generated files must be updated, use the project's normal generation or compilation process.

---

## 13. Validation

After making a change, run the strongest validation available in the repository.

At minimum, verify:

### Compilation

* OverPy compilation succeeds.
* No unresolved symbols or invalid actions are introduced.
* Generated Workshop code remains within relevant limits where such checks exist.

### Gameplay behaviour

* players remain planted;
* ordinary zombies retain melee-only behavior;
* special ranged behavior is limited to intended cases;
* spawned zombies initialize correctly;
* targets are acquired and released correctly;
* death and round cleanup remove temporary state;
* the changed mechanic resets correctly between rounds or waves.

### Lifecycle

* persistent effects and entities are cleaned up;
* handles do not remain in active collections after destruction;
* player departure and round termination do not leave stale references;
* cleanup does not destroy unrelated objects.

### Performance

* no new unbounded loop or uncontrolled polling is introduced;
* new high-frequency logic has a justified execution interval;
* array rebuilding and global scans are not added unnecessarily.

When automated testing cannot reproduce Workshop gameplay, state which scenarios still require in-game verification.

---

## 14. Reporting Changes

The final response for an implementation task should include:

* what changed;
* why the change was made;
* important implementation decisions;
* files modified;
* validation performed;
* remaining in-game verification;
* known risks or limitations.

Do not claim that gameplay has been verified in Overwatch unless an actual in-game test was performed.

For analysis-only tasks, distinguish clearly between:

* confirmed behavior from the repository;
* likely behavior inferred from code;
* proposed changes;
* Workshop limitations that still require validation.

---

## 15. Prohibited Assumptions

Agents must not assume that:

* all hero abilities work while the player is immobilized;
* AI pathfinding will always reach a planted player;
* dummy bots automatically clean themselves up;
* array mutations are always in place;
* persistent effects disappear when a rule stops evaluating;
* Workshop-generated code preserves original source abstractions;
* a mechanic possible in Overwatch gameplay is necessarily exposed to Workshop;
* a visually attractive mechanic is acceptable regardless of runtime cost.

When an API, action, event, hero property, or OverPy feature is uncertain, inspect project usage or authoritative documentation rather than inventing syntax.
