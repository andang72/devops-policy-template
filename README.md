[![release](https://img.shields.io/badge/release-v1.6.0-blue.svg)](https://github.com/andang72/devops-policy-template/releases)
[![repository](https://img.shields.io/badge/repository-GitHub-black.svg)](https://github.com/andang72/devops-policy-template)

# Enterprise DevOps Policy Template

AI-assisted 개발 규칙, GitLab Issue/MR 템플릿, commit 형식, 최소 AI workflow를 배포하는 정책 저장소입니다.

- 버전: [POLICY_VERSION.md](./POLICY_VERSION.md)
- AI 규칙: [AI_DEVELOPMENT_POLICY.md](./AI_DEVELOPMENT_POLICY.md)
- Git 흐름: [CONTRIBUTING.md](./CONTRIBUTING.md)
- 변경 이력: [CHANGELOG.md](./CHANGELOG.md)

## 제공 내용

- 대상 프로젝트에 복사 가능한 정책 파일 세트.
- 작은 AI workflow: `spec -> build -> review`.
- Issue, MR, commit, validation, AI usage 기록 기준.
- 일반 skill: `spec`, `build`, `review`, `write-issue`, `write-mr`, `write-commit`.
- Codex subagent: active 5개만 유지하고 specialist agent는 archive에 보관.

## 설치 / 업데이트

```bash
# 없는 정책 파일만 설치
bash scripts/install-policy.sh /path/to/target-project

# 기존 정책 파일 백업 후 업데이트
bash scripts/update-policy.sh /path/to/target-project

# 필요할 때만 legacy 경로 정리
bash scripts/update-policy.sh /path/to/target-project --prune-legacy

# 대상 프로젝트에서 AI-assisted commit template 활성화
cd /path/to/target-project
git config commit.template .gitmessage-ai-assisted.txt
```

대상 경로를 생략하면 현재 작업 디렉터리를 사용합니다.
`CHANGELOG.md`는 템플릿 저장소 전용이며 대상 프로젝트에 배포하지 않습니다.

## 최소 AI Workflow

이 저장소는 `addyosmani/agent-skills`에서 최소 `spec/build/review` lifecycle 아이디어만 참고합니다.
해당 저장소의 `agents/`, `hooks/`, command model, directory structure는 복사하지 않습니다.

| 단계 | 기준 |
| --- | --- |
| `spec` | 범위, 제약, acceptance criteria 정리 |
| `build` | 작은 단위 구현 |
| `review` | 정확성, 위험, 정책 준수 검토 |
| `secure` | 인증, 권한, 토큰, 개인정보 영향 검토 |
| `docs` | 정책, README, changelog, MR 설명 정리 |

규칙:

- `skills/*/SKILL.md`는 AI 실행 보조 규칙입니다.
- 특정 도구 전용 구조를 새로 만들지 않습니다.
- Issue, commit, MR은 관련 `write-*` skill과 템플릿을 함께 사용합니다.

## Codex Subagent

Codex subagent는 선택 기능입니다.
정책 자체와 `skills/*/SKILL.md`는 Codex 전용이 아닙니다.

| 단계 | Active subagent |
| --- | --- |
| `spec` | `issue-agent` |
| `build` | `backend-developer` |
| `review` | `code-reviewer` |
| `secure` | `security-auditor` |
| `docs` | `docs-agent` |

- Top-level `.codex/agents/*.toml`만 active set입니다.
- `.codex/agents/_archive/*.toml`은 legacy reference입니다.
- `.codex/config.toml`에서 `agents.dir`를 활성화하지 않습니다.

## AI에게 요청할 때

Issue, commit, PR/MR 산출물은 아래처럼 관련 skill을 명시해 요청하는 것을 권장합니다.
이렇게 하면 템플릿을 무시한 자유 형식 출력을 줄일 수 있습니다.

```text
skills/write-issue/SKILL.md를 읽고 .gitlab/issue_templates/default.md 기준으로 GitLab Issue 초안을 작성해줘.
```

```text
skills/write-commit/SKILL.md를 읽고 .gitmessage-ai-assisted.txt 기준으로 AI-assisted commit message를 작성해줘.
```

```text
skills/write-mr/SKILL.md를 읽고 .gitlab/merge_request_templates/default.md 기준으로 GitLab MR 초안을 작성해줘.
```

구현 작업도 필요한 단계만 명시합니다.

```text
skills/spec/SKILL.md를 읽고 scope, constraints, acceptance criteria, ambiguity를 먼저 정리해줘.
구현 전 skills/build/SKILL.md를 읽어줘.
최종 검토 전 skills/review/SKILL.md를 읽어줘.
```

## 배포 파일

```text
POLICY_VERSION.md
AGENTS.md
AI_DEVELOPMENT_POLICY.md
CONTRIBUTING.md
SKILL.md
.codex/config.toml
.codex/agents/issue-agent.toml
.codex/agents/docs-agent.toml
.codex/agents/backend-developer.toml
.codex/agents/code-reviewer.toml
.codex/agents/security-auditor.toml
.codex/agents/_archive/architect-reviewer.toml
.codex/agents/_archive/code-mapper.toml
.codex/agents/_archive/javascript-engineer.toml
.codex/agents/_archive/react-specialist.toml
.codex/agents/_archive/spring-boot-engineer.toml
.codex/agents/_archive/sql-pro.toml
.codex/agents/_archive/system-designer.toml
.codex/agents/_archive/typescript-pro.toml
.codex/agents/_archive/vue-expert.toml
skills/write-issue/SKILL.md
skills/write-mr/SKILL.md
skills/write-commit/SKILL.md
skills/spec/SKILL.md
skills/build/SKILL.md
skills/review/SKILL.md
.gitmessage-ai-assisted.txt
.gitlab/issue_templates/default.md
.gitlab/merge_request_templates/default.md
docs/agents/issue-agent.md
docs/agents/docs-agent.md
docs/agents/coding-agents.md
docs/agents/review-agents.md
docs/agents/frontend-agents.md
docs/agents/design-agents.md
.vscode/java.code-snippets
docs/dev/vscode-snippets-guide.md
scripts/update-codex-subagents.sh
```

템플릿 저장소 전용: `README.md`, `CHANGELOG.md`, `scripts/install-policy.sh`, `scripts/update-policy.sh`.

## 선택적 GitLab Automation

로컬 자동화는 `.env.local`의 `GITLAB_TOKEN`, `GITLAB_BASE_URL`, `GITLAB_PROJECT_ID`를 사용할 수 있습니다.
`.env.local`은 커밋하지 않습니다.
토큰은 prompt, log, commit, MR body에 출력하지 않습니다.
결과는 `iid`, `web_url`, `state`처럼 필요한 필드만 남깁니다.

## Codex Subagent 업데이트

외부 upstream에서 가져온 active Codex subagent 정의만 갱신할 때 사용합니다.
일반 skill이나 정책 파일은 이 스크립트의 대상이 아닙니다.

```bash
bash scripts/update-codex-subagents.sh /path/to/target-project --dry-run
```

Active top-level `.codex/agents/*.toml`만 검사합니다.
`_archive`는 무시하고, upstream에 없는 internal agent는 건너뜁니다.
변경 전 파일은 백업합니다.

## 유지보수 규칙

이 저장소는 policy-first로 유지합니다.
새 파일 추가보다 기존 파일 수정을 우선합니다.
Application code, project-specific runtime behavior, 두 번째 AI framework를 추가하지 않습니다.
