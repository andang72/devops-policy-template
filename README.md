[![release](https://img.shields.io/badge/release-v1.6.0-blue.svg)](https://github.com/andang72/devops-policy-template/releases)
[![repository](https://img.shields.io/badge/repository-GitHub-black.svg)](https://github.com/andang72/devops-policy-template)

# Enterprise DevOps Policy Template

AI-assisted 개발 정책, Git 협업 규칙, Issue/MR 템플릿, Codex agent 정의를 여러 프로젝트에 배포하기 위한 템플릿 저장소입니다.

- 현재 정책 버전: [POLICY_VERSION.md](./POLICY_VERSION.md)
- 변경 이력: [CHANGELOG.md](./CHANGELOG.md)
- AI 작업 기준: [AI_DEVELOPMENT_POLICY.md](./AI_DEVELOPMENT_POLICY.md)
- 기여 절차: [CONTRIBUTING.md](./CONTRIBUTING.md)

## 목적

- AI-assisted 변경의 책임, 검증, 기록 방식을 표준화한다.
- Issue → Branch → Commit → MR → Review → CI → Merge 흐름을 맞춘다.
- 대상 프로젝트에 복사 가능한 최소 정책 파일 세트를 제공한다.
- Codex가 짧은 규칙으로 issue, MR, commit 작업을 수행하게 한다.

## 배포 대상 구조

대상 프로젝트에 배포되는 핵심 파일은 다음과 같습니다.

```text
AGENTS.md
AI_DEVELOPMENT_POLICY.md
CONTRIBUTING.md
SKILL.md
POLICY_VERSION.md
.gitmessage-ai-assisted.txt
.gitlab/issue_templates/default.md
.gitlab/merge_request_templates/default.md
.codex/config.toml
.codex/agents/*.toml
.codex/agents/_archive/*.toml
docs/agents/*.md
skills/write-issue/SKILL.md
skills/write-mr/SKILL.md
skills/write-commit/SKILL.md
docs/dev/vscode-snippets-guide.md
.vscode/java.code-snippets
scripts/update-codex-subagents.sh
```

템플릿 저장소 전용 파일:

```text
README.md
CHANGELOG.md
scripts/install-policy.sh
scripts/update-policy.sh
```

## 파일 역할

| 경로 | 역할 |
| --- | --- |
| `AGENTS.md` | 에이전트가 먼저 읽는 짧은 실행 규칙 |
| `AI_DEVELOPMENT_POLICY.md` | AI-assisted 작업의 책임, 검증, 보안, 기록 기준 |
| `CONTRIBUTING.md` | 사람과 AI가 공유하는 Git 작업 절차 |
| `SKILL.md` | 이 템플릿 저장소를 정비할 때 적용하는 작업 방식 |
| `.gitlab/issue_templates/default.md` | 복사해서 바로 쓰는 Issue 양식 |
| `.gitlab/merge_request_templates/default.md` | 복사해서 바로 쓰는 MR 양식 |
| `.gitmessage-ai-assisted.txt` | AI-assisted commit 메시지 템플릿 |
| `.codex/agents/*.toml` | Active Codex core agent definitions |
| `.codex/agents/_archive/*.toml` | Archived legacy agent references |
| `docs/agents/*.md` | agent 선택 기준과 산출물 설명 |
| `skills/write-issue/SKILL.md` | Issue 작성 상세 규칙 |
| `skills/write-mr/SKILL.md` | MR 작성 상세 규칙 |
| `skills/write-commit/SKILL.md` | Commit 작성 상세 규칙 |
| `scripts/install-policy.sh` | 없는 정책 파일만 최초 설치 |
| `scripts/update-policy.sh` | 기존 정책 파일 백업 후 갱신 |
| `scripts/update-codex-subagents.sh` | 이미 설치된 upstream subagent 정의만 갱신 |
| `POLICY_VERSION.md` | 배포 정책 파일 세트의 버전 기준 |
| `CHANGELOG.md` | 이 템플릿 저장소의 변경 이력 |

## 빠른 적용

신규 프로젝트:

```bash
bash scripts/install-policy.sh /path/to/target-project
```

기존 프로젝트 업데이트:

```bash
bash scripts/update-policy.sh /path/to/target-project
```

대상 프로젝트에서 commit template 활성화:

```bash
cd /path/to/target-project
git config commit.template .gitmessage-ai-assisted.txt
```

구버전 정책 경로까지 정리해야 할 때만 사용:

```bash
bash scripts/update-policy.sh /path/to/target-project --prune-legacy
```

## 스크립트 동작 기준

- 경로를 생략하면 현재 작업 디렉터리를 대상으로 합니다.
- `install-policy.sh`는 대상 파일이 이미 있으면 덮어쓰지 않습니다.
- `update-policy.sh`는 대상 파일을 `.policy-backup-YYYYMMDD-HHMMSS/`에 백업한 뒤 덮어씁니다.
- `CHANGELOG.md`는 대상 프로젝트에 배포하지 않습니다.
- 템플릿 저장소 내부에서 실행해 source와 target이 같으면 건너뜁니다.
- `.gitignore`는 배포하지 않습니다. 대상 프로젝트의 ignore 정책은 별도로 관리합니다.

## Lightweight Codex Workflow

This repository uses a small core agent set. It is a policy template, not a general subagent catalog.

Active workflow:

- `spec`: use `issue-agent`
- `build`: use `backend-developer`
- `review`: use `code-reviewer`
- `secure`: use `security-auditor`
- `docs`: use `docs-agent`

Core rules:

- Use the main agent for simple work.
- Use subagents only when the task boundary is clear.
- Treat `.codex/agents/*.toml` as the active execution model.
- Treat `.codex/agents/_archive/*.toml` as legacy or optional references.
- Do not add a specialized agent unless repeated project work proves it is necessary.
- Keep `.codex/config.toml` as optional metadata. Do not enable `agents.dir`.

`skills/*/SKILL.md`는 저장소 로컬 작업 규칙 파일입니다.
Codex runtime skill 자동 등록을 의미하지 않습니다.
`AGENTS.md`는 작업 유형에 따라 해당 파일을 직접 읽도록 지시합니다.
사용자가 skill 이름을 직접 말하지 않아도 됩니다.

- Issue 작성/수정/생성: `skills/write-issue/SKILL.md`
- MR 작성/수정/생성: `skills/write-mr/SKILL.md`
- AI-assisted commit 작성: `skills/write-commit/SKILL.md`

## Optional GitLab Automation Environment

GitLab issue 또는 MR 자동화를 로컬에서 실행하는 경우 `.env.local`을 사용할 수 있습니다.

```env
GITLAB_TOKEN=
GITLAB_BASE_URL=
GITLAB_PROJECT_ID=
```

- `GITLAB_TOKEN`: GitLab API 호출용 personal/project access token
- `GITLAB_BASE_URL`: GitLab base URL, 예: `https://gitlab.example.com`
- `GITLAB_PROJECT_ID`: GitLab project numeric ID
- `.env.local`은 로컬 전용 파일이며 커밋하지 않습니다.
- 토큰 값은 프롬프트, 로그, 문서, commit, MR에 남기지 않습니다.
- 대상 프로젝트는 `.env.local`을 ignore 하도록 관리합니다.
- GitLab API 응답 전체 JSON을 출력하지 않습니다.
- Issue/MR 생성 결과는 `iid`, `web_url`, `state`처럼 필요한 필드만 출력합니다.
- 긴 Issue/MR 본문은 임시 파일로 작성하고 API 요청에는 파일 내용을 전달합니다.

## Subagent 정의 갱신

외부 upstream에서 가져온 active core agent 정의만 갱신해야 할 때 사용합니다.

```bash
bash scripts/update-codex-subagents.sh /path/to/target-project --dry-run
```

- 대상 프로젝트에 이미 설치된 top-level `.codex/agents/*.toml`만 basename 기준으로 검사합니다.
- `.codex/agents/_archive/*.toml`은 검사하지 않습니다.
- upstream에 없는 내부 agent는 건너뜁니다.
- 실제 갱신 시 기존 파일은 `.policy-backup-YYYYMMDD-HHMMSS/`에 백업합니다.
- 안정적인 운영이 필요하면 `--ref <branch-or-tag>`를 지정합니다.
- 사내 미러나 포크를 사용하면 `--repo <git-url>`을 지정합니다.

## 권장 작업 흐름

1. Issue를 템플릿으로 작성하고 `Type`, `Size`, `AI-Assisted`를 하나씩 선택합니다.
2. `feature/*`, `bugfix/*`, `hotfix/*`, `refactor/*` 중 하나로 작업 브랜치를 만듭니다.
3. 변경은 요청 범위 안에서 최소화하고 검증 명령을 남깁니다.
4. AI-assisted commit은 `.gitmessage-ai-assisted.txt` 형식을 사용합니다.
5. MR은 템플릿의 `Why`, `What`, `Validation`, checklist를 채운 뒤 human review를 받습니다.

## 코딩 작업 프롬프트 예시

대상 프로젝트에서 큰 기능을 추가하거나 기존 기능을 변경할 때는 목표, 영향 범위, 검증, 산출물을 함께 지정합니다.

```text
이 저장소의 AGENTS.md, AI_DEVELOPMENT_POLICY.md, CONTRIBUTING.md, SKILL.md를 기준으로 작업해줘.

목표:
- 주문 목록에 "처리 상태 + 기간 + 담당자" 복합 검색 기능을 추가해줘.
- 백엔드 API, DB 조회 조건, 프론트엔드 필터 UI, 테스트를 함께 반영해줘.
- 기존 주문 목록의 기본 조회 동작은 유지해줘.

범위:
- 관련 controller/service/repository/query, 프론트엔드 목록 화면, 타입 정의, 테스트만 수정해줘.
- 관련 없는 리팩터링, 포맷 변경, 설정 변경은 하지 마.
- API 응답 필드명과 기존 query parameter는 깨지지 않게 유지해줘.
- DB schema 변경이 필요하면 먼저 이유와 대안을 제시해줘.
- 여러 해석이 가능하면 수정 전에 선택지를 제시해줘.

작업 방식:
- 먼저 영향 파일, 호출 흐름, 데이터 흐름을 짧게 확인해줘.
- 작업 전 Issue 초안을 `skills/write-issue/SKILL.md` 기준으로 작성해줘.
- spec/build/review/secure/docs처럼 독립 검토 가능한 범위가 있으면 필요한 경우에만 core subagent를 사용해줘.
- subagent를 사용하면 위임 범위와 main author 검증 항목을 기록해줘.
- Issue/MR/commit 본문은 한국어로 작성해줘.
- 명령어, 경로, 코드 식별자, 로그, API 이름은 원문을 유지해줘.

검증:
- 변경 범위에 맞는 unit test, frontend test, build 또는 smoke test를 실행해줘.
- 정상 조회, 단일 필터, 복합 필터, 빈 결과, 기존 기본 조회 유지 케이스를 확인해줘.
- 실행할 수 없는 검증은 이유를 남겨줘.

산출물:
- 변경 요약
- 검증 명령과 결과
- Issue 초안
- MR에 붙일 Why / What / Validation / Risk / Rollback 초안
- `[ai-assisted] <type>(<scope>): <summary>` 형식의 commit 메시지 초안
```

작업이 단순하면 아래처럼 줄여서 요청할 수 있습니다.

```text
버그 원인을 확인하고 최소 범위로 수정해줘.
관련 없는 변경은 하지 말고, 검증 명령과 결과를 한국어로 정리해줘.
commit type/scope, 명령어, 파일 경로, 코드 식별자는 원문을 유지해줘.
```

## 템플릿 저장소 정비 원칙

- 새 문서보다 기존 문서 역할 정리를 우선합니다.
- 정책 문장은 짧고 선언적으로 씁니다.
- 대상 프로젝트에 배포할 필요가 없는 이력과 운영 메모는 `CHANGELOG.md`에만 둡니다.
- 사용자 프로젝트의 애플리케이션 코드, 비즈니스 기능, 런타임 설정은 추가하지 않습니다.
