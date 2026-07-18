#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
skills_ref_version="0.1.1"

validate_skill() {
  local skill_dir="$1"

  if command -v uv >/dev/null 2>&1; then
    uv tool run --from "skills-ref==$skills_ref_version" agentskills validate "$skill_dir"
  elif command -v mise >/dev/null 2>&1; then
    mise exec -- uv tool run --from "skills-ref==$skills_ref_version" agentskills validate "$skill_dir"
  else
    echo "Validation requires uv or mise with the repository toolchain installed." >&2
    exit 1
  fi
}

found=0
for skill_dir in "$repo_root"/skills/*; do
  [[ -f "$skill_dir/SKILL.md" ]] || continue
  found=1
  echo "Validating $(basename "$skill_dir")"
  validate_skill "$skill_dir"
done

if [[ "$found" -eq 0 ]]; then
  echo "No skills found under $repo_root/skills." >&2
  exit 1
fi
