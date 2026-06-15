#!/usr/bin/env bash
set -euo pipefail

if [ -n "${CLAWHUB_TOKEN:-}" ]; then
    # executed from in ci
    npx -y clawhub login --token "$CLAWHUB_TOKEN"
fi

for skill_dir in skills/*/; do
  skill_name=$(basename "$skill_dir")
  skill_file="${skill_dir}SKILL.md"

  if [ ! -f "$skill_file" ]; then
    echo "Skipping ${skill_name}: no SKILL.md found"
    continue
  fi

  # Parse version from frontmatter
  version=$(awk '/^---$/{c++; next} c==1 && /^[[:space:]]*version:/{gsub(/[" ]/, "", $2); print $2; exit}' "$skill_file")

  if [ -z "$version" ] || [ "$version" = "0.0.0" ]; then
    echo "Skipping ${skill_name}: no version or version is 0.0.0"
    continue
  fi

  echo "Publishing ${skill_name} v${version}"
  npx -y clawhub publish "$PWD/${skill_dir}" --version "$version" || true

  if [ -n "${CLAWHUB_TOKEN:-}" ]; then
      # executed from in ci
      continue
  fi

  # rate limits: 5 skills per hour / 20 skills per day
  sleep 3600
done
