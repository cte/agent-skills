# <Project or Feature> Plan

## Issues to Address

Describe the target user outcome, the current gaps, and what engineering-complete means.

Explicitly exclude:

- <non-goal>
- <non-goal>

## How We Will Work This Plan

This document is <a design plan / a living execution ledger>. Work through dependency-ordered slices. Keep at most one slice `In progress`. Do not mark a slice complete until all required acceptance criteria and validation gates pass.

For every slice:

1. Record status and prerequisites before implementation.
2. Keep the change reviewable and independently coherent.
3. Run cheap checks continuously and full slice validation before completion.
4. Use hands-on validation only where automated evidence is insufficient.
5. Append concise dated Progress Updates at meaningful checkpoints.
6. Update the Completion Record with actual, sanitized evidence.
7. Revise future slices when discoveries invalidate their assumptions.

## Status Legend

- `Not started`: implementation has not begun.
- `Queued`: preparatory work may exist, but the slice is not active.
- `In progress`: active implementation or validation.
- `Completed`: all acceptance criteria and required validation passed; Completion Record populated.
- `Blocked`: an external prerequisite prevents progress; exact blocker recorded.

## Scope Gate

Work belongs in this plan only when it:

1. is necessary for <core outcome>;
2. prevents a credible security, correctness, isolation, or data-loss failure in that outcome; or
3. provides the minimum delivery or operational support needed to evaluate it safely.

Material scope expansion requires <decision owner or approval path>.

## Important Notes

1. <Current-system fact with file or contract reference.>
2. <Load-bearing constraint or invariant.>
3. <Compatibility, security, data, or operational boundary.>
4. <Known dependency, existing work, or explicit deferral.>

## Architecture and Sequence

Describe current ownership boundaries, target ownership, data flow, and why the slice order follows the dependency graph. Use a compact table or diagram only when it materially improves clarity.

## Slice 0 — <Foundation, Reconnaissance, or Risk Spike>

**Status:** Not started

### Prerequisites

- None.

### Issues to Address

State the single dominant gap and why it must be resolved before later slices.

### Important Notes

- <Researched constraint.>
- <Invariant or decision.>

### Implementation strategy

- <High-level change with relevant files, modules, or contracts.>
- <State/process ownership.>
- <Failure, compatibility, or migration handling.>

### Acceptance criteria

- **A1:** <Binary user-visible or system outcome.>
- **A2:** <Failure/security/recovery outcome.>
- **A3:** <No-regression or compatibility outcome.>

### Validation

- **A1, A3 — Automated:** <focused commands/tests and what they prove>.
- **A1, A2 — Integration/E2E:** <cross-boundary workflow and expected result>.
- **A1 — Hands-on/operational:** <only evidence automation cannot establish>.

### Progress Updates

No implementation progress yet.

### Completion Record

Not completed; populate only after all required gates pass.

When completed, record:

- Started/completed dates and branch/commit/PR.
- Commands and exact summarized results.
- Hands-on evidence and sanitized artifact references.
- Material implementation details and deviations.
- Gotchas, discovered constraints, and explicitly deferred follow-ups.

## Slice 1 — <First Independently Usable Vertical Outcome>

**Status:** Queued

### Prerequisites

- Slice 0 completed.
- <Required decision, migration, credential, or external condition.>

### Issues to Address

<Gap closed by this slice.>

### Important Notes

- <Constraint.>

### Implementation strategy

- <High-level changes.>

### Acceptance criteria

- **A1:** <Observable outcome.>

### Validation

- **A1 — <layer>:** <Evidence and the outcome it proves.>

### Progress Updates

No implementation progress yet.

### Completion Record

Not completed; populate only after all required gates pass.

<!-- Repeat slices only when each has a distinct independently provable outcome. -->

## Public Interfaces and Types

List new or changed APIs, schemas, events, persistence contracts, feature flags, CLI surfaces, and compatibility promises. State explicitly when no public interface is needed.

## Overall Test Strategy

- Unit/pure logic: <scope>.
- Integration: <service, persistence, or migration boundaries>.
- End-to-end: <critical user journeys>.
- Security/permissions: <auth, tenant, destructive action, secrets>.
- Hands-on/visual/native: <what automated tests cannot prove>.
- Build/package/deploy: <when applicable>.

Define final acceptance as the state reached when every slice is `Completed`, all required evidence is recorded, and no unresolved critical correctness, security, isolation, or data-loss issue remains in scope.
