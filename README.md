# Shared Codex Skills

Canonical source for reusable Codex skills shared across projects.

## Layout

```text
skills/
  <skill-name>/
    SKILL.md
    agents/openai.yaml
    assets/       # optional output templates or reusable artifacts
    references/   # optional instructions loaded only when needed
    scripts/      # optional deterministic helpers
scripts/
  install-skill.sh
  validate-skills.sh
```

## Included skills

- `plan-writer` — research, write, execute, and maintain slice-and-gate engineering plans.

## Validate

```bash
./scripts/validate-skills.sh
```

The validator uses the official `skill-creator` validator from the local Codex installation and supplies PyYAML through `uv` when necessary.
The repository pins `uv` through `mise`; the script also supports `uv` directly or Python 3 with PyYAML already installed.

## Install a skill locally

```bash
./scripts/install-skill.sh plan-writer
```

Installation creates a symlink under `${CODEX_HOME:-~/.codex}/skills`, so edits in this repository are immediately available to Codex. The installer refuses to overwrite an existing file, directory, or unrelated symlink; move the existing installation aside before linking it.

## Add a skill

1. Create `skills/<lowercase-hyphen-name>/SKILL.md` with only `name` and `description` in its YAML frontmatter.
2. Add `agents/openai.yaml` and only the resources the skill needs.
3. Keep core instructions concise and move detailed examples or reference material into `references/`.
4. Run `./scripts/validate-skills.sh` before committing.
