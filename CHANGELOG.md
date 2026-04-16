# Changelog

## 2026-04-16

### 변경됨
- Simplify active Codex agents to the core `spec/build/review/secure/docs` workflow
- Archive overlapping specialized agents under `.codex/agents/_archive/`
- Update install/update scripts to distribute archived agents as references and remove legacy active specialized agents from targets
- Clarify that archived agents are not active execution choices
- Clarify that `addyosmani/agent-skills` is a reference source only, not a framework to copy
- Bump policy version to `v1.6.0`
- Reflect base project `v1.5.1` policy structure in this GitHub downstream repository
- Add task-specific `skills/write-issue`, `skills/write-mr`, and `skills/write-commit` rule files
- Simplify Issue, MR, and AI-assisted commit templates for copy-ready use
- Update `.codex/config.toml` to keep `agents.dir` disabled for Codex desktop app compatibility
- Align Codex agent definitions and subagent updater script with the base project while preserving GitHub repository identity
- Add `.env.local` and `.omx/` to ignored local-only paths

### 검증
- Planned merge strategy against `/Users/donghyuck.son/git/devopts/devops-policy-template`
- Preserved this repository's GitHub-facing README identity instead of copying GitLab badges
- Ran `git diff --check`
- Ran `bash -n scripts/install-policy.sh`
- Ran `bash -n scripts/update-policy.sh`
- Ran `bash -n scripts/update-codex-subagents.sh`
- Ran `bash scripts/install-policy.sh`
- Ran `bash scripts/update-policy.sh --prune-legacy`
- Ran `bash scripts/update-codex-subagents.sh --dry-run`

## 2026-04-01

### 변경됨
- Add missing `.gitlab/issue_templates/default.md` and `.gitlab/merge_request_templates/default.md` to the repository
- Add missing `.codex/config.toml` and `.codex/agents/*.toml` Codex execution definitions to the repository
- Add missing `.gitmessage-ai-assisted.txt` AI-assisted commit template to the repository
- Add `.codex/agents/react-specialist.toml` and document React-focused subagent usage
- Add `scripts/update-codex-subagents.sh` to update only already-installed upstream Codex subagent files with backup support
- Include `react-specialist.toml` and `update-codex-subagents.sh` in policy install/update distribution scripts
- Ignore generated `.policy-backup-*` directories so backup artifacts are not staged by default
- Allow install/update helper scripts to default to the current working directory when the target path is omitted
- Skip self-copy cases when install/update scripts are run inside the template repository itself
- Make `update-codex-subagents.sh` compatible with macOS default Bash by replacing `mapfile`
- Clarify in `README.md` that some role-specific Codex agents are imported/adapted with reference to `VoltAgent/awesome-codex-subagents`
- Bump policy version to reflect the added distributed policy/template files

### 검증
- Reviewed new `.gitlab` templates against issue/MR policy requirements
- Reviewed new `.codex` metadata and agent definitions for policy-order alignment
- Reviewed `react-specialist` documentation coverage in README and frontend agent guide
- Reviewed the new subagent update script flow for installed-only matching, backup creation, and dry-run behavior
- Reviewed omitted-path behavior for install/update helper scripts
- Verified self-target execution no longer fails on identical source/target paths
- Reviewed Bash 3 compatibility for the subagent updater
- Reviewed README wording to avoid implying runtime installation from an external repository

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
