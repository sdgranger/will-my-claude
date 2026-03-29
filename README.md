# will-my-claude

Claude Code를 더 잘 활용하기 위한 스킬, 설정 모음입니다.

---

## skills/cmux

[cmux](https://cmux.com) 터미널에서 Claude Code를 사용할 때 자동으로 활용되는 스킬입니다.

Claude Code가 cmux 환경을 감지하면 (`CMUX_WORKSPACE_ID` 환경변수) 아래 기능을 **알아서** 사용합니다:

- 빌드/테스트를 별도 패인에서 실행하고 결과 확인
- 내장 브라우저로 로컬 웹 UI 검사 및 자동화 (snapshot, fill, click)
- 사이드바에 빌드 상태/프로그레스 표시
- 장시간 작업 완료 시 알림 전송
- 여러 프로젝트를 별도 워크스페이스에서 병렬 관리

### 설치

스킬 파일을 복사하면 됩니다:

```bash
git clone https://github.com/sdgranger/will-my-claude.git
mkdir -p ~/.claude/skills/cmux/references
cp will-my-claude/skills/cmux/SKILL.md ~/.claude/skills/cmux/
cp will-my-claude/skills/cmux/references/* ~/.claude/skills/cmux/references/
```

Claude Code를 재시작하면 바로 적용됩니다.

### 파일 구조

```
skills/cmux/
├── SKILL.md                    # 핵심 스킬 — 행동 가이드 + 커맨드 요약
└── references/
    ├── browser-api.md          # 브라우저 자동화 전체 레퍼런스
    ├── cli-reference.md        # CLI 전체 명령어
    ├── hooks-integration.md    # Claude Code 훅 연동 방법
    └── socket-api.md           # 소켓 API + Python/Shell 예제
```

---

## (선택) 사이드바 알림 링 설정

스킬만 설치해도 Claude Code가 cmux를 활용하는 데는 문제없습니다.

추가로 **cmux 사이드바에 Claude Code의 상태가 자동으로 표시**되길 원한다면 (작업 완료 시 알림 링, "Running" 상태 표시 등), Claude Code hooks를 설정해야 합니다.

이 설정은 `~/.claude/settings.json`에 hooks를 추가하는 것인데, 스크립트로 간편하게 할 수 있습니다:

```bash
bash will-my-claude/setup/setup-cmux-hooks.sh
```

| 기능 | 스킬만 설치 | hooks도 설정 |
|------|-----------|-------------|
| Claude Code가 cmux 명령 활용 | O | O |
| 별도 패인에서 빌드/테스트 실행 | O | O |
| 내장 브라우저로 웹 UI 확인 | O | O |
| `cmux notify`로 알림 전송 | O | O |
| 사이드바에 알림 링 자동 표시 | **X** | O |
| 사이드바에 "Running" 상태 표시 | **X** | O |
| 프롬프트 전송 시 알림 자동 초기화 | **X** | O |

hooks가 하는 일에 대한 자세한 내용은 [hooks-integration.md](skills/cmux/references/hooks-integration.md)를 참고하세요.

---

## 벤치마크

스킬 적용 전후 비교 (3개 시나리오, 14개 assertion):

| 지표 | 스킬 없이 | 스킬 적용 |
|------|----------|----------|
| assertion 통과율 | 36% (5/14) | **100% (14/14)** |
| 평균 토큰 | 10,243 | 13,371 |
| 평균 소요시간 | 39.0s | 37.6s |

스킬 없이는 잘못된 CLI 문법 사용, curl로 웹 UI 확인 시도, cmux 알림 대신 osascript 사용 등의 문제가 발생합니다.

## 요구 사항

- macOS 14.0+
- [cmux](https://cmux.com) (`brew install cmux`)
- [Claude Code](https://claude.ai/claude-code) (`npm install -g @anthropic-ai/claude-code`)

> 이 스킬은 cmux **v0.63.1** 기준으로 작성되었습니다. 이후 버전에서 CLI가 변경되면 스킬 업데이트가 필요할 수 있습니다.

## 라이선스

MIT
