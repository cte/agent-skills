---
name: agent-friction
description: "Audit recurring agent workflow mistakes and turn observed evidence into narrow repository instructions or skill improvements. Use when asked to reduce repeated retries, confusion, or user corrections."
---

# Agent friction

Improve the next run by documenting a demonstrated failure pattern, not by adding
a broad checklist of things that might go wrong.

1. Establish the requested scope: a repository, one instruction file, one skill,
   or a bounded set of logs supplied or authorized for review.
2. Gather concrete evidence: repeated command failures, wrong checkout assumptions,
   user corrections, misunderstood workflow constraints, or stale runtime paths.
   Search narrowly and redact secrets; do not mine unrelated personal sessions.
3. Cluster by root cause rather than error wording. Distinguish a one-off outage
   from a workflow rule another agent can act on.
4. Propose the smallest instruction that prevents recurrence:

   > When <specific symptom>, check <specific evidence> before <costly next step>.

5. Put the rule with its durable owner. Repository-wide invariants belong in the
   local instruction file; task-specific details belong in a skill or focused
   guide. Update existing guidance rather than creating a competing source.
6. Edit only within the requested scope. Updating persistent personal memory
   requires an explicit user request; repository cleanup is not that request.
7. Validate referenced commands and paths, re-read for contradictions, and remove
   obsolete wording rather than accumulating exceptions.

For each change report the repeated symptom, supporting evidence, proposed or
applied wording, and scope. Toolchain names and process managers are local facts
to discover, not defaults to transplant from another repository.
