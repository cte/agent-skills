# Shared Agent Skills

Canonical source for reusable skills shared across AI coding agents. Skill payloads follow the open [Agent Skills specification](https://agentskills.io/specification), while small optional adapters provide agent-specific installation and presentation behavior.

## Compatibility

| Agent | Personal skill directory | Explicit invocation | Optional adapter |
| --- | --- | --- | --- |
| Codex | `~/.codex/skills` | `$plan-writer` | `agents/openai.yaml` |
| Claude Code | `~/.claude/skills` | `/plan-writer` | None required |

Both agents consume the same `SKILL.md`, `references/`, `assets/`, and `scripts/`. Claude Code ignores the optional Codex presentation metadata.

## Layout

```text
skills/
  <skill-name>/
    SKILL.md
    agents/openai.yaml  # optional Codex presentation adapter
    assets/             # optional output templates or reusable artifacts
    references/         # optional instructions loaded only when needed
    scripts/            # optional deterministic helpers
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

Validation uses the open standard's pinned `skills-ref` reference implementation through `uv`. It does not depend on Codex or Claude Code being installed.

## Install a skill locally

Install for both supported agents:

```bash
./scripts/install-skill.sh plan-writer all
```

Or install for only one:

```bash
./scripts/install-skill.sh plan-writer codex
./scripts/install-skill.sh plan-writer claude
```

The target defaults to `all` when omitted. Installation creates symlinks in each agent's personal skill directory, so edits in this repository are available immediately. Claude Code symlink discovery requires version 2.1.203 or newer. The installer preflights every target and refuses to overwrite an existing file, directory, or unrelated symlink.

For isolated tests or custom layouts, override `CODEX_SKILLS_DIR` or `CLAUDE_SKILLS_DIR`. `CODEX_HOME` remains supported when `CODEX_SKILLS_DIR` is unset.

## Add a skill

1. Create `skills/<lowercase-hyphen-name>/SKILL.md` with the standard `name` and `description` frontmatter.
2. Keep the skill instructions and supporting resources agent-neutral.
3. Add agent-specific metadata only as an optional adapter, such as `agents/openai.yaml` for Codex.
4. Keep core instructions concise and move detailed examples or reference material into `references/`.
5. Run `./scripts/validate-skills.sh` before committing.

See [CONTRIBUTING.md](CONTRIBUTING.md) for repository conventions. Claude Code users can also review its official [skills documentation](https://code.claude.com/docs/en/slash-commands).
