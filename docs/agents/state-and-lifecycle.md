# State, arrays, and lifecycle

Read when adding or changing a variable, array, subroutine, dummy bot, effect, HUD/in-world text, chase, camera, or status effect.

## State ownership

Before adding or changing state, determine: global or entity-specific; where it is initialized; which rule is authoritative and which may mutate it; when it becomes invalid; how it is reset; whether an external handle must be destroyed.

Do not keep competing representations of the same state. Keep these categories separate: authoritative gameplay, player, zombie, wave/spawn, external handles, temporary calculation, UI presentation. Existing representation wins over a new architecture. Variable declarations live in `src/main.opy` and `src/env/vars.opy`.

## Arrays and indexing

- Verify whether an array operation mutates in place or returns a copy; assign the result when it returns one.
- Keep parallel arrays aligned; update all of them on insert/delete.
- Reuse existing index constants, aliases, enums, or helpers; document any new raw index that has no named abstraction.
- Avoid rebuilding arrays in hot paths.
- Raw indexes in compiled or converted output do not prove the source lacked aliases.

## Persistent objects

Applies to dummy bots, effects, in-world/HUD text, chase operations, camera state, status effects, DoT/HoT, and handles held in variables or arrays. Do not assume they clean themselves up or vanish when a rule stops evaluating.

1. Store the handle if later cleanup is needed.
2. Destroy or stop it when its owning state ends.
3. Clear the stored reference.
4. Make cleanup safe to call twice where feasible.
5. Ensure round reset and player removal leave no stale state.

No pooling before lifecycle correctness is established; reused objects must be fully reset. Use short-lived effects for presentation that needs no later mutation or readback.
