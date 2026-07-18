# Shared Skills Repository Guidance

This repository is the canonical source for shared Codex skills. Make changes under `skills/`; do not treat copies under `~/.codex/skills` as the source of truth.

## Skill structure

- Use lowercase, hyphenated directory names matching the skill's frontmatter `name`.
- Every skill requires `SKILL.md` with only `name` and `description` in YAML frontmatter.
- Keep `SKILL.md` focused and under 500 lines. Put detailed examples and domain references one level deep under `references/`.
- Use `assets/` only for templates or artifacts intended to be reused in produced output.
- Use `scripts/` only for deterministic helpers; execute representative paths before committing them.
- Keep `agents/openai.yaml` aligned with the skill. Its `default_prompt` must mention `$<skill-name>`.
- Do not add per-skill README, changelog, installation guide, or other auxiliary documentation.
- Do not include secrets, credentials, private payloads, machine-specific auth state, or generated caches.

## Workflow

1. Read the complete target `SKILL.md` and any directly required references before editing.
2. Prefer updating an existing skill over creating a competing skill with overlapping triggers.
3. Keep triggering language specific enough that the skill loads for the intended tasks without capturing unrelated requests.
4. Preserve progressive disclosure: metadata first, concise workflow second, detailed resources only as needed.
5. Run `./scripts/validate-skills.sh` after every material skill change.
6. Forward-test complex workflow changes on a realistic task when the current environment and authorization allow it.
