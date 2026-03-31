
[![Latest Release](https://gitlab.podosoftware.com/podosoftware/devops/devops-policy-template/-/badges/release.svg)](https://gitlab.podosoftware.com/podosoftware/devops/devops-policy-template/-/releases)
[![coverage report](https://gitlab.podosoftware.com/podosoftware/devops/devops-policy-template/badges/main/coverage.svg)](https://gitlab.podosoftware.com/podosoftware/devops/devops-policy-template/-/commits/main)
[![pipeline status](https://gitlab.podosoftware.com/podosoftware/devops/devops-policy-template/badges/main/pipeline.svg)](https://gitlab.podosoftware.com/podosoftware/devops/devops-policy-template/-/commits/main)

- 현재 정책 버전: [POLICY_VERSION.md](./POLICY_VERSION.md)

# Enterprise DevOps Policy Template

전사 개발 프로젝트에서 공통적으로 적용하는 **AI 기반 개발 정책, Git 협업 규칙, Issue/MR 템플릿, Commit 표준**을 관리하는 공통 정책 저장소입니다.

본 저장소는 신규 프로젝트 생성 시 기본 템플릿으로 사용되며, 기존 프로젝트에도 표준 정책 파일을 배포하는 기준 저장소 역할을 합니다.

---

## 목적

- AI 보조 개발의 품질, 추적 가능성, 책임 범위를 표준화
- Git 기반 협업 절차(Issue → Branch → Commit → MR → Review → CI/CD → Merge) 통일
- Issue / Merge Request / Commit 메시지 작성 규칙 표준화
- Validation 및 검증 기록 정착
- 조직 내 AI 활용 개발 문화를 일관되게 확산

---

## 포함 파일

```text
.
├── AGENTS.md
├── SKILL.md
├── POLICY_VERSION.md
├── README.md
├── AI_DEVELOPMENT_POLICY.md
├── CONTRIBUTING.md
├── CHANGELOG.md (template repo only)
├── .codex
│   ├── config.toml
│   └── agents
│       ├── issue-agent.toml
│       ├── docs-agent.toml
│       ├── backend-developer.toml
│       ├── spring-boot-engineer.toml
│       ├── vue-expert.toml
│       ├── typescript-pro.toml
│       ├── javascript-engineer.toml
│       ├── sql-pro.toml
│       ├── code-reviewer.toml
│       ├── architect-reviewer.toml
│       ├── security-auditor.toml
│       ├── code-mapper.toml
│       └── system-designer.toml
├── docs
│   ├── agents
│   │   ├── issue-agent.md
│   │   ├── docs-agent.md
│   │   ├── coding-agents.md
│   │   ├── review-agents.md
│   │   ├── frontend-agents.md
│   │   └── design-agents.md
│   └── dev
│       └── vscode-snippets-guide.md
├── .gitmessage-ai-assisted.txt
├── .vscode
│   └── java.code-snippets
├── .gitlab
│   ├── issue_templates
│   │   └── default.md
│   └── merge_request_templates
│       └── default.md
└── scripts
    ├── install-policy.sh
    └── update-policy.sh
```

---

## 프로젝트 적용 방법

### 1) 신규 프로젝트에 최초 설치

```bash
bash scripts/install-policy.sh /path/to/target-project
```

- 대상 프로젝트에 정책 파일이 없을 때만 복사합니다.
- 이미 존재하는 파일은 덮어쓰지 않고 `[SKIP]` 처리합니다.
- `CHANGELOG.md`는 템플릿 저장소 이력용이므로 대상 프로젝트에 배포하지 않습니다.
- 정책 버전 파일(`POLICY_VERSION.md`)은 함께 배포됩니다.

### 2) 기존 프로젝트 정책 업데이트

```bash
bash scripts/update-policy.sh /path/to/target-project
```

- 대상 프로젝트의 정책 파일을 최신 기준으로 덮어씁니다.
- 기존 파일은 대상 프로젝트 내부의 `.policy-backup-YYYYMMDD-HHMMSS/`에 자동 백업합니다.
- `CHANGELOG.md`는 업데이트 대상에서 제외됩니다.
- 정책 버전 파일(`POLICY_VERSION.md`)도 함께 업데이트됩니다.

구버전 정책 경로까지 정리해야 하는 경우에는 아래 옵션을 사용합니다.

```bash
bash scripts/update-policy.sh /path/to/target-project --prune-legacy
```

- `--prune-legacy`는 백업 후 더 이상 사용하지 않는 legacy 정책 경로만 삭제합니다.
- 일반 프로젝트 파일이나 임의 사용자 파일은 삭제하지 않습니다.

### 3) 적용 후 권장 설정

대상 프로젝트에서 AI 커밋 템플릿을 활성화합니다.

```bash
cd /path/to/target-project
git config commit.template .gitmessage-ai-assisted.txt
```

Codex subagent 실행 정의는 `.codex/agents/*.toml`에 둡니다.
`.codex/config.toml`은 선택적 프로젝트 메타데이터이며, 정책 강제의 기준은 아닙니다.

### 4) `v1.1.0`에서 `v1.4.0`으로 마이그레이션

`v1.4.0`은 기존 기본 workflow를 유지하면서 Codex-native subagent 구조를 선택적으로 추가하고, frontend/design agent 확장을 포함한 버전입니다.

기본 마이그레이션:

```bash
bash scripts/update-policy.sh /path/to/target-project
```

이 명령은 다음을 수행합니다.

- 기존 정책 파일을 백업합니다.
- 최신 정책 문서와 템플릿을 덮어씁니다.
- `.codex/config.toml`과 `.codex/agents/*.toml`을 추가합니다.
- `docs/agents/*.md` 운영 문서를 추가합니다.

Legacy 경로까지 함께 정리하려면:

```bash
bash scripts/update-policy.sh /path/to/target-project --prune-legacy
```

권장 순서:

1. 먼저 기본 업데이트를 수행합니다.
2. 변경 diff를 검토합니다.
3. 프로젝트에서 더 이상 사용하지 않는 legacy 정책 경로가 있을 때만 `--prune-legacy`를 사용합니다.

호환성 메모:

- 기존 main-agent only workflow는 계속 사용할 수 있습니다.
- subagent를 즉시 도입하지 않아도 정책 업그레이드는 가능합니다.
- Codex subagent는 선택적 확장 기능입니다.

---

## Codex Usage

### Default mode

subagent를 지정하지 않고 일반 프롬프트로 작업하면 기존과 동일하게 main agent가 동작합니다.

- `AI_DEVELOPMENT_POLICY.md`와 root `SKILL.md`를 기본으로 적용합니다.
- `.codex/agents/*.toml`은 명시적으로 선택한 경우에만 사용합니다.
- 작은 수정, 단일 단계 작업, 빠른 질의응답은 기본 모드 사용을 권장합니다.

### Role-specific mode

단계별 산출물이 분명한 경우 역할별 agent를 사용합니다.

- 내부 커스텀: `issue-agent`, `docs-agent`
- 외부 재사용: `backend-developer`, `spring-boot-engineer`, `vue-expert`, `typescript-pro`, `javascript-engineer`, `sql-pro`, `code-reviewer`, `architect-reviewer`, `security-auditor`, `code-mapper`, `system-designer`
- 설명 문서는 `docs/agents/*.md`에서 관리합니다.
- 역할별 agent는 프롬프트에서 이름을 명시적으로 지정해 사용하는 것을 전제로 합니다.

### Resolution order

Codex agent는 다음 순서로 규칙을 해석합니다.

1. `AI_DEVELOPMENT_POLICY.md`
2. `CONTRIBUTING.md`
3. root `SKILL.md`
4. `.codex/agents/*.toml`
5. `docs/agents/*.md`
6. `.codex/config.toml` (optional metadata only)

---

## Usage Examples

### 1) Analysis only

코드 변경 없이 원인 분석이나 이슈 초안이 필요할 때 사용합니다.

Prompt example:

```text
로그를 보고 로그인 실패 원인을 분석해줘.
코드 수정은 하지 말고, 필요하면 code-mapper로 영향도를 정리한 뒤 issue-agent로 이슈 초안까지 정리해줘.
```

Expected outputs:

- Findings summary
- Issue draft
- Validation marked as `analysis only (no code change)`

### 2) Feature development

기능 추가나 수정이 필요할 때 사용합니다.

Prompt example:

```text
사용자 목록 API에 상태 필터를 추가해줘.
spring-boot-engineer로 구현하고, docs-agent로 MR Why/What/Validation 초안도 준비해줘.
```

Expected outputs:

- Code changes in bounded scope
- Validation command/result
- MR summary draft

### 2-1) Vue / TypeScript feature development

Vue UI와 TypeScript 타입 정리가 함께 필요한 작업에 사용합니다.

Prompt example:

```text
Vue 화면의 상태 필터 UI를 추가해줘.
vue-expert로 화면 구현하고, typescript-pro로 타입 정리까지 검토해줘.
```

Expected outputs:

- Vue component or page changes
- TypeScript type updates
- Validation notes for the main author

### 3) Review only

변경사항을 병합 전에 점검할 때 사용합니다.

Prompt example:

```text
이 변경사항을 code-reviewer 방식으로 검토해줘.
버그, 회귀, 정책 누락 위주로 finding만 정리해줘.
```

Expected outputs:

- Severity-based findings
- Policy checklist result
- Required fixes before merge

### 4) Docs and MR summary

문서 갱신이나 MR 정리만 필요할 때 사용합니다.

Prompt example:

```text
이번 변경을 docs-agent 방식으로 정리해줘.
CHANGELOG와 MR Why/What/Validation, Deployment Notes 초안을 작성해줘.
```

Expected outputs:

- Documentation updates
- `CHANGELOG.md` entry
- MR summary draft

### Agent mapping

- `issue-agent`: internal custom agent for repository issue template completion
- `docs-agent`: internal custom agent for changelog and MR summary drafting
- `backend-developer`, `spring-boot-engineer`, `vue-expert`, `typescript-pro`, `javascript-engineer`, `sql-pro`: imported or adapted external coding agents
- `code-reviewer`, `architect-reviewer`, `security-auditor`: imported or adapted external review agents
- `code-mapper`, `system-designer`: imported or adapted analysis and design agents

### Review readiness note

`code-reviewer`와 다른 review agent 정의는 `.codex/agents/*.toml`에 포함되어 있습니다.
다만 실제 사용은 Codex 런타임에서 agent 이름을 프롬프트에 명시적으로 지정하는 방식을 전제로 합니다.
