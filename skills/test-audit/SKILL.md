---
name: test-audit
description: "Review, improve, or prune tests based on the observable contracts and credible regressions they protect. Use for test authoring, focused audits, or subsystem coverage consolidation."
---

# Test audit

Adapted from OpenClaw's test-audit workflow; retain [LICENSE](LICENSE).
Optimize confidence and maintainability, not deletion count. LLM evaluation
rubrics belong to an evaluation workflow rather than this software-test audit.

## Authoring gate

Before adding a test, identify:

1. The observable behavior or independent contract it protects.
2. A credible regression that would make it fail.
3. Why existing tests do not already catch that failure.
4. The documented local or CI gate that will actually run it.

Control dependencies at their boundary. Do not create production exports, flags,
or wrappers solely to assert private implementation. Prefer extending a focused
case table over replaying the same behavior through many layers. A second layer
needs a distinct transport, lifecycle, integration, or security risk.

For a regression, demonstrate failure on the original behavior for the intended
reason and success after the fix when feasible. An unrelated import, environment,
database, or network error is not evidence the target guard worked.

## Audit gate

Read each candidate test completely, its production owner and callers, relevant
history, overlapping tests, and gate selection before deciding. Suspect patterns:

- assertion-free probes, copied expected values, or self-comparisons;
- private call-shape assertions duplicated by stronger boundary tests;
- source-text, CSS, or incidental DOM assertions unrelated to a real contract;
- mocks that implement the behavior supposedly under test;
- negative tests passing due to the wrong guard or an unreachable path;
- permanent skips, obsolete product paths, or test-only production seams;
- repeated fixtures or whole suites that add no distinct failure detection.

These are investigation signals, not automatic deletion rules. Retain independent
checks for public schemas, persistence, migrations, authorization, tenant isolation,
approval, conformance, configuration, and CI routing. Static or slow tests can be
valuable; determine what failure they catch. A retained baseline failure may be a
product bug, not an obsolete assertion.

Record for every proposed deletion: exact test, detectable failure, gate, non-test
callers, retained proof or obsolete contract, history, affected support code,
and focused validation. Missing evidence means defer it.

## Apply a coherent batch

Move still-valid coverage to its owner before deleting weaker duplicates. Remove
unused fixtures and test-only seams together; preserve unrelated user edits.
Use isolated dependency fixtures where the repo provides them before attributing
failures to changed code. Follow the local toolchain and gate names rather than
assuming any repository layout.

Run owner and sibling tests, relevant formatting/types/lint, and executable
contract checks for removed static assertions. Confirm moved files still run in
CI and adjust existing non-growth baselines only when their rules permit it.
Do not replace uncertain deletion candidates with equally redundant tests.

For whole-subsystem campaigns read [references/campaign.md](references/campaign.md).
Report removed categories, remaining proof, false positives retained, real product
bugs, actual validation, and test/support versus production changes. Commit,
push, or open a PR only within the user's authorized scope.
