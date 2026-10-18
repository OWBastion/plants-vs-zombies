# Gameplay contract

Read when changing player movement, hero abilities, zombie AI, waves, or any new mechanic. These are mode invariants, not preferences.

## Planted players

Once planted, a player must not regain ordinary free movement unless a mechanic explicitly and temporarily permits it. Check every path that could move them: ability interactions, knockback, respawn, hero change, state reset, round transitions, teleport or position correction.

Mechanics that need sustained movement must be adapted to stationary play or rejected. Do not assume every hero ability works while immobilized.

## Zombies

Zombies are script-managed AI. Lifecycle: spawn, init, target acquisition, movement/path progression, attack, death/despawn/round cleanup.

- Standard zombies are melee-only unless the zombie type, mechanic, or difficulty rule explicitly enables ranged behavior. Never make them ranged to work around pathfinding, targeting, or balance.
- Do not assume pathfinding always reaches a planted player.
- When changing AI, check: target selection and loss, unreachable targets, path progression, melee range, attack cooldown, line of sight, crowding, player death/removal, zombie death mid-action, round termination, difficulty overrides.
- Special zombies and difficulty modifiers declare only their differences from the base AI; do not duplicate the full AI loop unless unavoidable.

## Overwatch adaptation

Borrow PvZ structure and pacing, but design around Overwatch heroes, real ability and weapon behavior, Workshop-supported actions, map geometry, and Workshop performance limits. Establish how a PvZ mechanic works in Overwatch before introducing it. A mechanic possible in the game is not necessarily exposed to Workshop.
