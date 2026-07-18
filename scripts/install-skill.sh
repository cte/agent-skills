#!/usr/bin/env bash
set -euo pipefail

if [[ "$#" -lt 1 || "$#" -gt 2 ]]; then
  echo "Usage: $0 <skill-name> [codex|claude|all]" >&2
  exit 2
fi

skill_name="$1"
agent="${2:-all}"

if [[ ! "$skill_name" =~ ^[a-z0-9]+(-[a-z0-9]+)*$ ]]; then
  echo "Skill name must use lowercase letters, digits, and single hyphens." >&2
  exit 2
fi

case "$agent" in
  codex|claude|all) ;;
  *)
    echo "Agent must be one of: codex, claude, all." >&2
    exit 2
    ;;
esac

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source_dir="$repo_root/skills/$skill_name"
codex_skills_dir="${CODEX_SKILLS_DIR:-${CODEX_HOME:-$HOME/.codex}/skills}"
claude_skills_dir="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"

if [[ ! -f "$source_dir/SKILL.md" ]]; then
  echo "Skill not found: $source_dir" >&2
  exit 1
fi

target_roots=()
target_agents=()

if [[ "$agent" == "codex" || "$agent" == "all" ]]; then
  target_roots+=("$codex_skills_dir")
  target_agents+=("Codex")
fi

if [[ "$agent" == "claude" || "$agent" == "all" ]]; then
  target_roots+=("$claude_skills_dir")
  target_agents+=("Claude Code")
fi

# Preflight every destination before creating anything so an `all` install does
# not leave one agent installed when another target conflicts.
for index in "${!target_roots[@]}"; do
  target_dir="${target_roots[$index]}/$skill_name"

  if [[ -L "$target_dir" && "$(readlink "$target_dir")" == "$source_dir" ]]; then
    continue
  fi

  if [[ -e "$target_dir" || -L "$target_dir" ]]; then
    echo "Refusing to overwrite existing ${target_agents[$index]} path: $target_dir" >&2
    echo "Move the existing installation aside, then run this command again." >&2
    exit 1
  fi
done

for index in "${!target_roots[@]}"; do
  target_root="${target_roots[$index]}"
  target_dir="$target_root/$skill_name"
  mkdir -p "$target_root"

  if [[ -L "$target_dir" && "$(readlink "$target_dir")" == "$source_dir" ]]; then
    echo "$skill_name is already linked for ${target_agents[$index]}."
    continue
  fi

  ln -s "$source_dir" "$target_dir"
  echo "Installed $skill_name for ${target_agents[$index]} -> $target_dir"
done
