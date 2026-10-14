---
name: branch-sweep
description: "Inspect and clean merged local branches and stale worktrees while preserving unmerged work. Use for requested Git branch or worktree cleanup; remote deletion is outside the default scope."
---

# Branch and worktree cleanup

Start with a report. Deletion requires the user's requested cleanup scope; do not
ask again when deletion of the identified class is already explicitly authorized.

## Inventory and classify

- Read repository rules and identify the primary checkout, current branch, linked
  worktrees, protected branches, remotes, and intended integration branches.
  Do not assume the integration branch is named `main`.
- Record full branch tip SHAs and worktree paths. Inspect staged, unstaged,
  untracked, ignored-but-needed files, submodules, and nested repositories.
- If remote state matters, fetch the intended remote when permitted and record
  its observed SHAs. A missing upstream is not proof of merge.
- An ancestor check against the intended integration tip proves ordinary merge
  containment. For squash merges, inspect patch equivalence and the complete
  branch diff; lack of ancestry alone does not prove unmerged work.
- A merged PR proves only the PR's merged head was included. If the branch has
  later commits, evaluate those separately. Never classify the current branch
  tip as disposable merely because an older PR merged.
- Closed, unmerged PRs are abandoned work, not merged work. Keep them unless the
  user explicitly includes abandoned work and its recovery has been preserved.
  Unavailable or ambiguous forge metadata means keep and report uncertainty.

## Remove within scope

1. Protect the primary checkout, current session worktree, active worktrees, and
   repository-designated branches. Skip dirty worktrees and work that another
   session is using. Do not use a shared stash as a cleanup shortcut.
2. Write a recovery manifest outside the candidate worktrees with branch names,
   full tip SHAs, and paths. Before deleting unmerged or abandoned work, retain
   actual objects in a verified Git bundle or backup refs; a SHA alone is not a
   durable backup after garbage collection.
3. Recheck branch tips, containment, worktree occupancy, and cleanliness immediately
   before deletion. A changed tip invalidates the earlier classification.
4. Remove eligible linked worktrees through `git worktree remove`, then branches
   through normal Git deletion. A refused operation is a reason to inspect and
   report; never fall back automatically to force removal or recursive deletion.
5. Re-inventory and report what was removed, retained, uncertain, and recoverable.

Do not remove remote branches, prune arbitrary directories, or discard submodule
work under an ordinary local cleanup request. If the environment has a managed
worktree archive with recoverable snapshots, prefer it for its own worktrees.
