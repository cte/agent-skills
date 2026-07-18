# Shared Skills Repository Guidance

This repository is the canonical source for shared, agent-neutral skills. Make changes under `skills/`; do not treat installed copies under an agent's personal configuration directory as the source of truth.

## Skill structure

- Follow the open Agent Skills specification.
- Use lowercase, hyphenated directory names matching the skill's frontmatter `name`.
- Every skill requires `SKILL.md` with `name` and `description` in YAML frontmatter.
- Keep the portable skill payload agent-neutral: do not require a particular agent, invocation syntax, proprietary tool, or personal configuration path in `SKILL.md`, `references/`, `assets/`, or skill scripts.
- Keep `SKILL.md` focused and under 500 lines. Put detailed examples and domain references one level deep under `references/`.
- Use `assets/` only for templates or artifacts intended to be reused in produced output.
- Use skill-level `scripts/` only for deterministic helpers; execute representative paths before committing them.
- Put optional agent-specific presentation metadata only in the path expected by that agent. For Codex, keep `agents/openai.yaml` aligned with the skill and ensure its `default_prompt` mentions `$<skill-name>`.
- Do not add per-skill README, changelog, installation guide, or other auxiliary documentation.
- Do not include secrets, credentials, private payloads, machine-specific auth state, or generated caches.

## Workflow

1. Read the complete target `SKILL.md` and any directly required references before editing.
2. Prefer updating an existing skill over creating a competing skill with overlapping triggers.
3. Keep triggering language specific enough that the skill loads for the intended tasks without capturing unrelated requests.
4. Preserve progressive disclosure: metadata first, concise workflow second, detailed resources only as needed.
5. Run `./scripts/validate-skills.sh` after every material skill change.
6. Test installation for each affected agent adapter.
7. Forward-test complex workflow changes on a realistic task when the current environment and authorization allow it.
