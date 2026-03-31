# Changelog

## 2026-03-23

### 변경됨
- Add subagent workflow extension to AGENTS required workflow
- Add subagent delegation principles and main author accountability to AI development policy
- Clarify subagent recording and integration responsibility in contributing guide
- Extend Issue/MR templates with subagent usage tracking fields and checklist item
- Add role-specific `agents/*/SKILL.md` template structure and Codex config baseline
- Replace role-specific `agents/*/SKILL.md` execution structure with Codex-native `.codex/agents/*.toml`
- Add `docs/agents/*.md` guidance files for human-readable agent usage
- Add README guidance for default mode, role-specific mode, and prompt examples
- Add README migration guidance from `v1.1.0` to `v1.3.0`
- Update install and update scripts to distribute Codex config and agent skills
- Implement `update-policy.sh --prune-legacy` for legacy policy path cleanup after backup
- Clarify `.codex/config.toml` as optional metadata and `.codex/agents/*.toml` as the Codex execution definition path
- Bump policy version to include subagent workflow policy support
- Add `vue-expert`, `typescript-pro`, `javascript-engineer`, and `system-designer` Codex agents
- Add frontend/design agent guidance docs and distribute them through install/update scripts

### 검증
- Reviewed cross-document terminology consistency for subagent/main author roles
- Verified templates capture delegation scope, ownership, and post-integration validation
- Verified install/update script distribution paths for newly added frontend/design agents

## 2026-03-20

### 변경됨
- Align MR template with required Why/What/Validation/checklist fields
- Clarify README role and mandatory MR template/human review rules in contributing guide
- Bump policy version to reflect policy/template rule changes

### 검증
- Reviewed document diffs for policy consistency

## 2026-03-18

### 변경됨
- Initial policy template baseline files

### 검증
- Initial baseline created
