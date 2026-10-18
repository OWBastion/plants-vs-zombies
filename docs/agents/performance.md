# Performance

Read when adding or changing rules that run frequently (per-frame, periodic, or scanning players/zombies). Workshop performance is a gameplay constraint.

Avoid: unnecessary per-frame rules; repeated global scans of all players and zombies; rebuilding large arrays in hot paths; repeatedly creating/destroying persistent effects; recomputing unchanged inputs; several rules computing the same result; visuals nobody sees.

Prefer: event-driven updates; cached values with clear invalidation; staggered or batched work; early exits; filtering before expensive calculation; explicit update intervals suited to the mechanic.

Do not sacrifice correctness for a small theoretical saving; optimize measured or structurally obvious hot paths first.
