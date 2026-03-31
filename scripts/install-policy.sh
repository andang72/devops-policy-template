#!/usr/bin/env bash
set -euo pipefail

TARGET_DIR="${1:-}"

if [[ -z "${TARGET_DIR}" ]]; then
  echo "Usage: bash scripts/install-policy.sh /path/to/target-project"
  exit 1
fi

if [[ ! -d "${TARGET_DIR}" ]]; then
  echo "[ERROR] target directory does not exist: ${TARGET_DIR}"
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

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
  ".codex/agents/spring-boot-engineer.toml"
  ".codex/agents/vue-expert.toml"
  ".codex/agents/typescript-pro.toml"
  ".codex/agents/javascript-engineer.toml"
  ".codex/agents/sql-pro.toml"
  ".codex/agents/code-reviewer.toml"
  ".codex/agents/architect-reviewer.toml"
  ".codex/agents/security-auditor.toml"
  ".codex/agents/code-mapper.toml"
  ".codex/agents/system-designer.toml"
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
)

copy_if_missing() {
  local rel="$1"
  local src="${ROOT_DIR}/${rel}"
  local dst="${TARGET_DIR}/${rel}"

  if [[ ! -f "${src}" ]]; then
    echo "[WARN] source not found: ${src}"
    return 0
  fi

  mkdir -p "$(dirname "${dst}")"

  if [[ -e "${dst}" ]]; then
    echo "[SKIP] already exists: ${dst}"
  else
    cp "${src}" "${dst}"
    echo "[ADD] ${dst}"
  fi
}

for rel in "${FILES[@]}"; do
  copy_if_missing "${rel}"
done

echo
echo "Done."
echo "Next step:"
echo "  cd ${TARGET_DIR}"
echo "  git config commit.template .gitmessage-ai-assisted.txt"
