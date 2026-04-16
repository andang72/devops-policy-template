#!/usr/bin/env bash
set -euo pipefail

TARGET_DIR="$(pwd)"
PRUNE_LEGACY=false

for arg in "$@"; do
  case "${arg}" in
    --prune-legacy)
      PRUNE_LEGACY=true
      ;;
    -*)
      echo "Usage: bash scripts/update-policy.sh [/path/to/target-project] [--prune-legacy]"
      exit 1
      ;;
    *)
      if [[ "${TARGET_DIR}" != "$(pwd)" ]]; then
        echo "Usage: bash scripts/update-policy.sh [/path/to/target-project] [--prune-legacy]"
        exit 1
      fi
      TARGET_DIR="${arg}"
      ;;
  esac
done

if [[ ! -d "${TARGET_DIR}" ]]; then
  echo "[ERROR] target directory does not exist: ${TARGET_DIR}"
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
BACKUP_DIR="${TARGET_DIR}/.policy-backup-$(date +%Y%m%d-%H%M%S)"

FILES=(
  "POLICY_VERSION.md"
  "AGENTS.md"
  "AI_DEVELOPMENT_POLICY.md"
  "CONTRIBUTING.md"
  "SKILL.md"
  ".codex/config.toml"
  ".codex/agents/issue-agent.toml"
  ".codex/agents/docs-agent.toml"
  ".codex/agents/backend-developer.toml"
  ".codex/agents/code-reviewer.toml"
  ".codex/agents/security-auditor.toml"
  ".codex/agents/_archive/architect-reviewer.toml"
  ".codex/agents/_archive/code-mapper.toml"
  ".codex/agents/_archive/javascript-engineer.toml"
  ".codex/agents/_archive/react-specialist.toml"
  ".codex/agents/_archive/spring-boot-engineer.toml"
  ".codex/agents/_archive/sql-pro.toml"
  ".codex/agents/_archive/system-designer.toml"
  ".codex/agents/_archive/typescript-pro.toml"
  ".codex/agents/_archive/vue-expert.toml"
  "skills/write-issue/SKILL.md"
  "skills/write-mr/SKILL.md"
  "skills/write-commit/SKILL.md"
  ".gitmessage-ai-assisted.txt"
  ".gitlab/issue_templates/default.md"
  ".gitlab/merge_request_templates/default.md"
  "docs/agents/issue-agent.md"
  "docs/agents/docs-agent.md"
  "docs/agents/coding-agents.md"
  "docs/agents/review-agents.md"
  "docs/agents/frontend-agents.md"
  "docs/agents/design-agents.md"
  ".vscode/java.code-snippets"
  "docs/dev/vscode-snippets-guide.md"
  "scripts/update-codex-subagents.sh"
)

LEGACY_FILES=(
  "agents/issue-agent/SKILL.md"
  "agents/coding-agent/SKILL.md"
  "agents/review-agent/SKILL.md"
  "agents/docs-agent/SKILL.md"
)

ARCHIVED_ACTIVE_AGENT_FILES=(
  ".codex/agents/architect-reviewer.toml"
  ".codex/agents/code-mapper.toml"
  ".codex/agents/javascript-engineer.toml"
  ".codex/agents/react-specialist.toml"
  ".codex/agents/spring-boot-engineer.toml"
  ".codex/agents/sql-pro.toml"
  ".codex/agents/system-designer.toml"
  ".codex/agents/typescript-pro.toml"
  ".codex/agents/vue-expert.toml"
)

mkdir -p "${BACKUP_DIR}"

backup_and_copy() {
  local rel="$1"
  local src="${ROOT_DIR}/${rel}"
  local dst="${TARGET_DIR}/${rel}"

  if [[ ! -f "${src}" ]]; then
    echo "[WARN] source not found: ${src}"
    return 0
  fi

  if [[ "${src}" == "${dst}" ]]; then
    echo "[SKIP] source equals target: ${dst}"
    return 0
  fi

  mkdir -p "$(dirname "${dst}")"

  if [[ -e "${dst}" ]]; then
    mkdir -p "$(dirname "${BACKUP_DIR}/${rel}")"
    cp "${dst}" "${BACKUP_DIR}/${rel}"
    echo "[BACKUP] ${dst}"
  fi

  cp "${src}" "${dst}"
  echo "[UPDATE] ${dst}"
}

prune_legacy_file() {
  local rel="$1"
  local dst="${TARGET_DIR}/${rel}"

  if [[ -e "${dst}" ]]; then
    mkdir -p "$(dirname "${BACKUP_DIR}/${rel}")"
    cp "${dst}" "${BACKUP_DIR}/${rel}"
    rm -f "${dst}"
    echo "[PRUNE] ${dst}"
  else
    echo "[PRUNE-SKIP] not found: ${dst}"
  fi
}

for rel in "${FILES[@]}"; do
  backup_and_copy "${rel}"
done

for rel in "${ARCHIVED_ACTIVE_AGENT_FILES[@]}"; do
  prune_legacy_file "${rel}"
done

if [[ "${PRUNE_LEGACY}" == "true" ]]; then
  for rel in "${LEGACY_FILES[@]}"; do
    prune_legacy_file "${rel}"
  done
fi

echo
echo "Done."
echo "Backup saved to: ${BACKUP_DIR}"
if [[ "${PRUNE_LEGACY}" == "true" ]]; then
  echo "Legacy paths were pruned after backup."
fi
echo "Please review changes before commit."
