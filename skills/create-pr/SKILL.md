---
name: create-pr
description: "Create or update a pull request for the intended feature branch. Use when asked to open, submit, or update a PR, including preparing commits and an accurate description."
---

# Create a pull request

Adapted from Intercom's PR workflow; retain [LICENSE](LICENSE).

## Establish context

Read repository instructions and the requested outcome. Reuse intent and prior
authorization from the conversation. Ask only when a missing decision materially
changes scope; a clear implementation request already supplies useful intent.
An explicit request to hold off on publishing overrides older authorization.

Identify repository/forge, visibility, current branch, dirty paths, remote,
existing PR, and intended base. Use an available authenticated forge tool or CLI;
do not assume a particular provider. The branch upstream is a push destination,
not necessarily the PR base. Prefer the explicit base, then an existing PR's
base, then repository integration policy. Resolve unknown visibility before
publishing potentially private content.

## Prepare the actual diff

- Review the complete diff against the base, including pending files intended for
  this PR. Reconcile it with the task. Leave unrelated changes untouched; clarify
  unexpected changes that would otherwise enter the PR.
- Follow local documentation, changelog, migration, and validation requirements.
  Use existing evidence for an unchanged diff; do not invent additional gates.
- If a new branch is needed, create a descriptive feature branch. Do not rename
  an already-published branch without a reason and authorization.
- Stage explicit paths, make coherent commits, and push normally to the intended
  remote when included in the user's PR request. Do not force-push or merge.
- For public repositories, inspect titles, bodies, commit messages, and the full
  diff for internal URLs, identifiers, credentials, and private data. Resolve
  unexpected disclosures before publishing; a private repo is not a secret store.

## Write for the reviewer

Lead with the concrete problem and resulting behavior. Explain why the change is
needed using the task and verified facts, not invented business motivation. Keep
implementation details to those needed to judge the tradeoff. Follow the repo's
PR template; otherwise use a short problem/change paragraph and actual validation
results with material limits. Git already supplies the changed-file list.

Link relevant issues and approved plans when they exist. Do not invent a plan or
publish local filesystem paths. Scale the description to the diff and rewrite it
when scope changes.

Use a structured body argument or a temporary body file so Markdown newlines and
literal shell characters survive. Avoid interpolating untrusted text into shell
commands. Update the existing PR for the branch rather than creating a duplicate.

## Verify and hand off

Read back the PR URL, base, head, draft/open state, and check status. If the client
supports attaching PR artifacts, attach it there. Report the URL and distinguish
local validation from hosted CI; creating a PR does not mean it is merged or
its deployment is complete.
