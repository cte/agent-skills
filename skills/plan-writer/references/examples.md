# Plan Writer Examples

Use these examples as patterns, not literal product requirements.

## Acceptance criteria and mapped gates

Weak:

```markdown
- Uploads work reliably.
- Test uploads.
```

Strong:

```markdown
### Acceptance criteria

- **A1:** Dropping one supported file creates exactly one attachment with the server-owned name and identifier.
- **A2:** An interrupted upload leaves no sendable phantom attachment and can be retried without restarting the app.

### Validation

- **A1 — Integration:** Upload a fixture through the frontend API and assert the returned descriptor is used in the outgoing message.
- **A1, A2 — End-to-end:** Exercise successful and interrupted uploads; assert one visible attachment after success, none after failure, and a successful retry.
```

## Active slice with progress updates

```markdown
## Slice 2 — Persisted reload parity

**Status:** In progress

### Prerequisites

- Slice 1 completed: live streaming contract is stable.

### Progress Updates

- 2026-07-18: Added persisted section identifiers and reload parsing. Focused type checks and parser tests pass. Remaining gate: full reload E2E.
- 2026-07-19: Reload E2E exposed a race that replaces the settled answer with a loading placeholder. Slice remains In progress; added deterministic reproduction. Revised Slice 3 to consume the settled-session event rather than polling.
- 2026-07-20: Fixed finalization ordering; parser and reload E2E pass. Remaining gate: retained-session hands-on smoke.
```

Progress updates state outcomes and the next gate. They do not list every edited file or shell command.

## Blocked slice

```markdown
**Status:** Blocked

### Progress Updates

- 2026-07-21: Packaging, signature verification, and local launch pass. External blocker: notarization requires an active Developer ID application certificate not available in this environment. Unblock condition: certificate installed and identity visible to `security find-identity`. Next action after unblock: run notarization, stapling, and Gatekeeper gates.

### Completion Record

Not completed. Local packaging evidence is partial progress, not proof of distributable readiness.
```

## Completed slice

```markdown
**Status:** Completed

### Progress Updates

- 2026-07-22: All A1–A4 gates pass; completion evidence recorded below.

### Completion Record

- Started: 2026-07-20. Completed: 2026-07-22.
- Branch/commit/PR: `feature/reload-parity`, commit `abc1234`, draft PR #42.
- Automated validation: parser tests 18/18; reload E2E 3/3; strict type check passed.
- Hands-on validation: reopened one retained local conversation after relaunch; the settled answer and citation actions remained intact with no console error. No private payload was retained.
- Deviation: replaced the planned polling approach with a settled-session event after the race documented in Progress Updates.
- Deferred: stress testing above 500 retained messages is recorded in the repository follow-up ledger; it is not required for this slice's bounded history contract.
```

## Revising a future slice after discovery

Record the discovery in the active slice and modify the future slice immediately:

```markdown
### Important Notes

- Revised 2026-07-19 after Slice 2: consume the settled-session event. Do not implement the originally planned polling loop; it can observe temporary backend placeholders.

### Prerequisites

- Slice 2 completed with the settled-session event contract and reload regression passing.
```

Do not leave the obsolete strategy in place merely because it appeared in the original plan.
