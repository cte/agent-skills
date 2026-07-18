---
name: plan-writer
description: Research, write, and maintain execution-ready engineering plans organized into scoped, dependency-ordered slices with prerequisites, explicit acceptance criteria, mapped validation gates, implementation progress updates, and evidence-based completion records. Use when asked to create, rewrite, execute, or maintain an implementation plan, execution ledger, phased roadmap, slice breakdown, milestone plan, rollout checklist, or definition-of-done document—especially when work must be reviewable, independently usable, and gated before the next slice begins.
---

# Plan Writer

Write plans that another engineer or agent can execute without rediscovering the architecture or inventing the definition of done. Treat a substantial plan as both a design record and an execution ledger.

## Operating contract

- Research before writing. Inspect repository instructions, current code, tests, adjacent plans, changelogs, follow-up ledgers, and relevant runtime state.
- Follow repository-specific planning rules over this skill. Required or forbidden sections, test conventions, file locations, and approval rules remain authoritative.
- Keep the plan at implementation-strategy altitude. Name relevant files, functions, contracts, and commands, but do not write implementation code in the plan.
- Separate facts, decisions, assumptions, and unresolved questions. Do not present an inference as established behavior.
- Never fabricate progress or evidence. New work starts as `Not started` or `Queued`; a Completion Record stays explicitly incomplete until its gates actually pass.
- Do not implement the planned work unless the user also asks for implementation.

## Workflow

### Choose the operating mode

- **Authoring mode:** Research the system, define scope and architecture, create dependency-ordered slices, and leave truthful initial statuses and empty execution records.
- **Execution mode:** Implement only when the user asks, work one eligible slice at a time, and update that slice's status, Progress Updates, validation results, and Completion Record as the work proceeds.

When asked to do both, finish authoring the plan before implementation. Keep the plan open as the execution source of truth rather than producing a separate status document.

### 1. Establish the planning contract

Read all applicable repository instruction files. Determine:

- the outcome and intended user;
- whether the plan is design-only or a living execution ledger;
- the required plan location and formatting rules;
- hard constraints, approvals, compatibility promises, and explicit non-goals;
- whether an existing plan should be amended instead of creating a competing source of truth.

Use reasonable assumptions for reversible details. Ask the user only when a missing decision materially changes scope, architecture, or external effects.

### 2. Build an evidence map

Trace the current system end to end before proposing slices:

- entrypoints and user-visible flows;
- process or service ownership;
- public contracts, persistence, migrations, and state boundaries;
- security, authentication, tenant, permission, and destructive-action boundaries;
- streaming, reload, failure, cancellation, and recovery behavior where relevant;
- existing automated and hands-on validation surfaces;
- related work already completed, deferred, or known to be broken.

Record file and symbol references that make important claims auditable. Prefer current source and tests over stale prose. Reconcile contradictions explicitly.

### 3. Define scope before architecture

Write the problem, target outcome, and explicit exclusions. For a large project, add a scope gate that admits work only when it is required to:

1. deliver the core user outcome;
2. prevent a credible security, correctness, isolation, or data-loss failure in that outcome; or
3. provide the minimum build, migration, installation, or operational support needed to evaluate it safely.

Anything else is deferred unless the user deliberately expands scope. Keep follow-ups in the repository's canonical follow-up mechanism when one exists.

### 4. Design the slice sequence

Create the smallest dependency-ordered slices that are independently reviewable and leave the system in a coherent state. A good slice:

- has one dominant outcome and risk profile;
- produces a usable or provable checkpoint;
- includes its own tests and validation rather than borrowing confidence from a future slice;
- makes prerequisites explicit;
- does not require later code to make its acceptance criteria true;
- remains small enough to review and, where applicable, ship independently.

Put foundations and risk spikes before broad feature work, vertical user value before polish, real-data quality validation after deterministic behavior, and integration/handoff readiness last. Do not create slices merely to make the list longer.

### 5. Write the plan

For a substantial slice-and-gate plan, use this global shape unless repository instructions require another:

1. Issues to Address
2. How We Will Work This Plan
3. Status Legend
4. Scope Gate
5. Important Notes
6. Architecture and Sequence
7. Ordered Slices
8. Public Interfaces and Types
9. Overall Test Strategy

For each slice, include:

- **Status** — `Not started`, `Queued`, `In progress`, `Completed`, or `Blocked`.
- **Prerequisites** — earlier slices, decisions, migrations, credentials, or external conditions that form the entry gate; write `None` when the slice can start independently.
- **Issues to Address** — the gap this slice closes.
- **Important Notes** — researched constraints and non-obvious decisions.
- **Implementation strategy** — high-level changes, ownership, and sequence.
- **Acceptance criteria** — binary, observable outcomes; avoid vague words such as “works,” “robust,” or “polished” without defining what observation proves them.
- **Validation** — exact automated, hands-on, security, migration, packaging, or operational evidence mapped to the criteria.
- **Progress Updates** — concise dated implementation notes recording meaningful changes, checks and outcomes, discoveries, blockers, deviations, and the next unresolved gate. Leave `No implementation progress yet.` in authoring mode.
- **Completion Record** — actual date, branch/commit/PR, commands and results, hands-on evidence, deviations, gotchas, and deferred follow-ups. For unfinished work, write `Not completed; populate only after all required gates pass.`

Use [assets/slice-and-gate-plan-template.md](assets/slice-and-gate-plan-template.md) as a starting structure when creating a new plan. Adapt it; do not preserve irrelevant headings or placeholders.

Read [references/examples.md](references/examples.md) when writing or updating a substantial plan, or whenever a criterion, gate, progress update, blocked state, or Completion Record would benefit from a concrete model.

### 6. Design real gates

Keep acceptance and validation distinct:

- Acceptance asks: **What must be true?**
- Validation asks: **What evidence will establish that it is true?**

Map every material criterion to at least one proportionate check. Include failure and recovery paths when they can affect persisted state or user trust. Use the cheapest reliable layer first:

- pure/unit tests for state machines, parsers, schemas, and policy;
- integration tests for service and persistence boundaries;
- end-to-end tests for cross-process or frontend/backend behavior;
- hands-on validation for native UI, accessibility, third-party auth, OS permissions, visual quality, or real retained data;
- build, packaging, migration, security, or deployment checks when the slice changes those surfaces.

Do not make broad suites ritual requirements when focused evidence is sufficient. If a broad check is intentionally omitted, require the Completion Record to state why and what covered the risk instead.

For substantial plans, label criteria `A1`, `A2`, and so on, then label validation entries with the criteria they establish. A gate may cover several criteria, and a high-risk criterion may require several gates. Never leave a material criterion without evidence or list a check whose proven outcome is unclear.

### 7. Audit the finished plan

Before delivering, verify:

- every stated issue is owned by a slice or explicitly excluded;
- every slice has a concrete outcome, prerequisites, criteria, and evidence;
- every material acceptance criterion maps to at least one validation gate;
- slice order follows dependencies and no criterion depends on unplanned future work;
- public contract, migration, compatibility, security, cancellation, and recovery consequences are addressed where applicable;
- statuses are truthful and at most one slice is `In progress` in a living ledger;
- completion records do not contain predicted commands or invented results;
- deferrals are explicit rather than hidden acceptance criteria;
- no timelines, estimates, rollback sections, or implementation code were added when repository rules forbid them;
- the plan is concise enough to maintain but detailed enough to execute.

## Maintaining an execution ledger

When implementation progresses:

1. Mark exactly one eligible slice `In progress` and record its start context.
2. Append a dated Progress Update after each meaningful checkpoint, failed gate, blocker, scope discovery, or material decision. State what changed, what evidence ran, its outcome, and the next unresolved gate; do not log every trivial command.
3. Update affected future slices in the same change when a discovery invalidates their assumptions, prerequisites, strategy, or gates. Reference that revision from the active slice's Progress Updates.
4. Leave a slice open when a required gate is skipped or failing. Record partial success without turning it into completion evidence.
5. Mark `Blocked` only for a concrete external prerequisite. Record completed preparatory work, the exact unblock condition, and the next action after unblocking.
6. Mark `Completed` only after every required criterion and validation gate passes. Append a final Progress Update and fill the Completion Record in the same change set with actual, sanitized evidence.

Keep progress updates chronological and preserve the original intent. Let the Completion Record summarize the finished slice without deleting the implementation history. Record deviations and discoveries instead of silently rewriting history after completion.
