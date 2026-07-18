#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
codex_home="${CODEX_HOME:-$HOME/.codex}"
validator="$codex_home/skills/.system/skill-creator/scripts/quick_validate.py"

if [[ ! -f "$validator" ]]; then
  echo "Official skill validator not found: $validator" >&2
  exit 1
fi

found=0
for skill_dir in "$repo_root"/skills/*; do
  [[ -f "$skill_dir/SKILL.md" ]] || continue
  found=1
  echo "Validating $(basename "$skill_dir")"
  if command -v uv >/dev/null 2>&1; then
    uv run --with pyyaml python "$validator" "$skill_dir"
  elif command -v mise >/dev/null 2>&1; then
    mise exec -- uv run --with pyyaml python "$validator" "$skill_dir"
  elif python3 -c 'import yaml' >/dev/null 2>&1; then
    python3 "$validator" "$skill_dir"
  else
    echo "Validation requires uv, mise, or Python 3 with PyYAML." >&2
    exit 1
  fi
done

if [[ "$found" -eq 0 ]]; then
  echo "No skills found under $repo_root/skills." >&2
  exit 1
fi
