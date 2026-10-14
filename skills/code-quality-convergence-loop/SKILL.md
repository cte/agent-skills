---
name: code-quality-convergence-loop
description: "Run a bounded review, fix, validate, and re-review loop until in-scope correctness and maintainability blockers are resolved. Use for explicitly requested quality convergence or autonomous cleanup."
---

# Code quality convergence loop

Aim for zero in-scope blockers, not zero imaginable improvements. Record the user
objective, review scope, authorized publication actions, and a reasonable iteration
budget before starting. Invoking a review/fix loop alone does not authorize pushing,
merging, force-pushing, or changing shared runtime state.

## Fix the boundary

Read repository instructions, inspect branch/upstream and all dirty paths, and
resolve the intended base from the request, existing PR, or repository policy.
Record the merge-base SHA once. Keep it fixed across review passes; include
committed changes and the agreed staged, unstaged, and untracked files. Preserve
unrelated user work. Do not create commits directly on protected branches.

Use the available `thermo-nuclear-code-quality-review` skill for strict review.
If it is unavailable, use its core criteria: reachable correctness failures,
canonical ownership, unnecessary branching, duplicated sources of truth, and
abstractions that increase rather than reduce complexity. Do not claim an
independent review unless a separate reviewer actually ran.

## Track and fix

Maintain one deduplicated ledger with location, impact, trigger, remedy, status,
and last review pass:

- P0: severe correctness, security, data-loss, or availability blocker.
- P1: concrete correctness or maintainability blocker introduced or worsened by
  the scoped changes.
- P2/P3: useful but non-blocking improvements.

Fix verified P0/P1 findings with the smallest coherent owner-boundary change.
Minor fixes qualify only when local and low-risk, removing duplication, correcting
an existing shared component's use, or splitting a materially overgrown component
without changing behavior. Defer speculative redesign and unrelated polish.

Each turn:

1. Review the whole fixed boundary afresh and reconcile previous findings.
2. Report counts and the focused fixes before editing.
3. Add a regression check when behavior changes and the risk warrants it, then
   implement the remedy. If the fix creates another blocker, reconsider its
   design rather than adding wrappers around it.
4. Run the relevant local tests, typing, lint, and repository gates. A failing
   required check keeps that turn incomplete.
5. Commit and push only if authorized, using explicit paths and normal pushes.
   Preserve unrelated work. A rejected push calls for inspecting divergence,
   not force-pushing or automatically rewriting history.
6. Report actual validation and checkpoint state, then review again.

## Completion and stopping

Convergence requires a fresh pass with zero P0/P1, no remaining eligible minor
fixes, and passing required checks. If publication was requested, verify the
commits reached the intended remote too. Deferred minor findings remain visible.
Passing tests alone is not review convergence.

Stop with a concrete blocker when a product decision, new permission, or unsafe
scope expansion is required. If the same finding survives two attempted remedies,
reassess the root cause; after three unsuccessful passes without meaningful
progress, report the impasse instead of looping indefinitely. Honor a smaller
user budget. Report scope, passes, final counts, fixes, deferred issues, evidence,
and local/remote state separately.
