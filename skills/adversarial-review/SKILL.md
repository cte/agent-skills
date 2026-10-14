---
name: adversarial-review
description: "Obtain and verify an independent second-opinion review of a branch or pull request. Use when the user explicitly requests an adversarial or separate-agent review."
---

# Independent adversarial review

The value is a separate reviewer with direct access to the actual diff. Use an
available independent reviewer or agent only when delegation is supported and
authorized. If no independent execution is available, disclose that limitation;
do not relabel your own second pass as independent.

## Prepare an immutable target

Identify the repository, current branch, PR head/base if relevant, merge-base SHA,
and intended uncommitted paths. Confirm the code on disk matches that target;
use a clean isolated checkout if needed. Record status and content hashes for
dirty/untracked files so edits within an already-dirty path cannot go unnoticed.

Keep prompts, logs, and reports in a fresh temporary directory outside the target
worktree. Give the reviewer:

- the task's relevant contracts and repository instructions;
- exact base/head SHAs and the staged, unstaged, and untracked scope;
- the requirement to flag only introduced or worsened issues, tracing reachable
  paths and distinguishing bugs from speculation;
- strict read-only scope: no edits, fixers, staging, commits, service restarts, or
  external writes;
- a report format with verdict, severity, file/line, trigger, impact, and remedy.

Use enforceable read-only access when available. Do not disable a reviewer's
sandbox or approval controls merely to avoid a prompt. A post-run status check
cannot substitute for containment. Avoid sharing your suspected findings before
the review when that would bias the second opinion.

The optional `thermo-nuclear-code-quality-review` skill supplies a strict rubric
when available; otherwise ask for correctness, security, ownership, and complexity
review directly. No particular agent product or CLI is required.

## Execute and verify

Run with a bounded time/spend budget and inspect progress without busy polling.
Stop on authentication failure, unavailable tools, or a stalled review; preserve
its logs. Treat partial or absent reports as incomplete, not clean.

Compare the original status and file hashes afterward. If anything changed,
report the unexpected mutation and preserve recovery evidence; do not silently
reset another process's changes.

Read the completed report and verify every cited location and claim. Retain
unverified findings with an uncertainty label. Relay the reviewer's severity and
substance separately from your own agreement or disagreement. Report target SHAs,
coverage limits, and any required checks the reviewer did not run. Do not auto-fix
unless the user also requested implementation or a review/fix loop.
