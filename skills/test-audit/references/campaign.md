# Subsystem test-pruning campaign

Use the authoring, retention, and evidence gates in [the skill](../SKILL.md).

1. **Baseline:** pin a revision, inventory every owned suite and its CI gate, and
   record pass/fail state plus test/support line counts. Separate pre-existing
   failures from regressions; use isolated dependencies where possible.
2. **Ownership lanes:** group tests by production responsibility rather than path
   prefix. Include shared-boundary, integration, end-to-end, and manual checks.
3. **Read-only ledger:** mark each declaration retain, repair, consolidate, or
   delete with its contract and evidence. Parameter rows may need different marks.
4. **Keeper plan:** identify the strongest retained owner for each contract and
   move missing assertions there before retiring duplicate layers. Re-examine
   test-only exports and wrappers unlocked by the change.
5. **Cutover:** edit one coherent lane at a time; serialize shared fixture changes,
   update CI routing, and run each lane's keepers. Preserve other people's work.
6. **Preservation review:** compare deleted coverage against the keepers. Use a
   separate reviewer when available and authorized; otherwise disclose a self-review.
   For uncertain coverage, apply a targeted temporary mutation in a disposable
   checkout and verify the keeper fails for the intended reason. Restore only the
   mutation and rerun; never reset a dirty shared worktree to perform this check.
7. **Defects:** repair in-scope product bugs at their owner with control/candidate
   proof, or report them separately. Do not delete a test to hide a retained bug.
8. **Reconcile:** if the base changes, follow the repository's normal integration
   policy and ensure newly added contracts still have a keeper. Rerun affected
   suites and distinguish prior evidence from evidence on the final revision.

Report kept contracts, retired layers, coverage gaps, actual validation, baseline
and final counts, product changes, and publication state. Line reduction alone
is not success.
