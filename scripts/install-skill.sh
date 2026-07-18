#!/usr/bin/env bash
set -euo pipefail

if [[ "$#" -ne 1 ]]; then
  echo "Usage: $0 <skill-name>" >&2
  exit 2
fi

skill_name="$1"
if [[ ! "$skill_name" =~ ^[a-z0-9]+(-[a-z0-9]+)*$ ]]; then
  echo "Skill name must use lowercase letters, digits, and single hyphens." >&2
  exit 2
fi

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source_dir="$repo_root/skills/$skill_name"
codex_home="${CODEX_HOME:-$HOME/.codex}"
target_dir="$codex_home/skills/$skill_name"

if [[ ! -f "$source_dir/SKILL.md" ]]; then
  echo "Skill not found: $source_dir" >&2
  exit 1
fi

mkdir -p "$codex_home/skills"

if [[ -L "$target_dir" && "$(readlink "$target_dir")" == "$source_dir" ]]; then
  echo "$skill_name is already linked from this repository."
  exit 0
fi

if [[ -e "$target_dir" || -L "$target_dir" ]]; then
  echo "Refusing to overwrite existing path: $target_dir" >&2
  echo "Move the existing installation aside, then run this command again." >&2
  exit 1
fi

ln -s "$source_dir" "$target_dir"
echo "Installed $skill_name -> $target_dir"
