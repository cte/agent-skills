---
name: thermo-nuclear-code-quality-review
description: "Perform an unusually strict maintainability and correctness review of a scoped diff. Use when explicitly asked for a thermo-nuclear review, deep quality audit, or harsh structural review."
---

# Strict code quality review

Look for changes that remove concepts and failure paths, not merely rearrange
files. A working happy path does not justify a design that obscures ownership,
errors, or persisted state. Review does not authorize implementation changes.

## Establish coverage

Record the intended base, head, dirty paths, and exact reviewed boundary. Resolve
the integration branch from user intent, PR metadata, or repository policy;
never assume a branch name. Judge introduced or worsened issues, not the entire
repository. Read applicable instructions and the contracts the changed code owns.

Reconcile prior findings as fixed, open, deferred, or not substantiated with
current evidence. Do not attribute a prior review miss across different revisions.
Inspect nearby variants of a fix instead of extrapolating from one regression test.

## Trace failure paths

For changed persistence, dispatch, retries, or streams, follow real callees through
reads, writes, commit/rollback, checkpoint movement, delivery, and recovery:

- Can a callee roll back earlier work without the caller realizing it?
- Does a catch cover commit failures and earlier reads, or only the writer?
- Can error-to-empty conversion advance a cursor or erase accumulated results?
- Are retries idempotent after partial success, duplicate delivery, or cancellation?
- Can nominally deduplicated writes still amplify sequences, storage, or index work?
- Do stored identifiers, errors, logs, and model context cross caller boundaries?
- Do metrics prove the claimed interval, completeness, or state transition?

For each suspected issue establish a reachable trigger and consequence. Use an
isolated focused reproduction when it materially resolves uncertainty; do not
invent blockers simply to fill the checklist.

## Challenge structural complexity

Look for a coherent simplification that deletes branches, wrappers, duplicate
state, or an unnecessary layer. Prefer canonical owners and typed boundaries.
Flag:

- feature-specific checks scattered through shared code;
- booleans and optional values that hide an unmodeled state machine;
- wrappers, identity helpers, or generic frameworks that add indirection;
- duplicate facts, policies, query assembly, or component behavior;
- casts and silent fallbacks that hide invalid boundary assumptions;
- modules that mix orchestration, persistence, policy, and presentation;
- non-atomic related updates, or sequential independent work that adds real
  latency or failure complexity without a reason.

Growth past roughly 1,000 lines is a review signal, not proof of a bug. Explain
which responsibilities should separate and why. Do not demand arbitrary splitting,
parallelism, or abstraction just to meet a stylistic preference. A good remedy
reduces the concepts a reader must hold and preserves the requested behavior.

## Report

Order concrete security, data-loss, correctness, and availability issues before
maintainability findings. Give file/line, triggering condition, impact, evidence,
and the smallest coherent remedy. Keep severity proportional to reachability and
impact; distinguish blockers from optional improvements. Prefer a few grounded
findings over a long list of cosmetic nits.

Finish with coverage, validation limits, and disposition of previous findings.
Zero blockers does not mean every possible improvement is done. If used in a
convergence workflow, apply that workflow's priorities and fix-eligibility gates
without hiding findings that fall outside its allowed fixes.
