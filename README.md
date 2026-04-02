# will-public-claude

Claude Code를 더 잘 활용하기 위한 스킬 모음입니다.

---

## 스킬 목록

| 스킬 | 설명 | 플러그인 |
|---|---|---|
| [cmux](skills/cmux/SKILL.md) | cmux 환경 감지 및 패인/사이드바/알림 제어 | `will-public-claude-cmux` |
| [cmux-browser](skills/cmux-browser/README.md) | 내장 브라우저에서 로컬 웹 UI 열기 및 인터랙션 | `will-public-claude-cmux` |
| [cmux-parallel](skills/cmux-parallel/README.md) | 2개 이상 프로세스 병렬 실행 및 상태 추적 | `will-public-claude-cmux` |
| [cmux-run](skills/cmux-run/README.md) | 별도 패인에서 장시간 프로세스 실행 및 모니터링 | `will-public-claude-cmux` |
| [skillify](skills/skillify/README.md) | 대화 기록 기반 재사용 가능한 SKILL.md 자동 생성 | `will-public-claude-skillify` |

---

## 설치

### 플러그인 (권장)

Claude Code에서 아래 명령을 실행하세요. 필요한 플러그인만 선택해 설치할 수 있습니다.

```
/plugin marketplace add sdgranger/will-public-claude
```

**cmux 스킬 설치** (cmux 터미널 사용자):
```
/plugin install will-public-claude-cmux
```

**skillify 설치** (스킬 자동 생성 도구):
```
/plugin install will-public-claude-skillify
```

GitHub에 업데이트가 올라오면 자동으로 반영됩니다.

### 수동 설치

플러그인 없이 원하는 스킬만 직접 복사할 수도 있습니다 (자동 업데이트 없음).

각 스킬 폴더의 README를 참고하세요.

---

## 상세 문서

- **cmux 계열 스킬**: [setup/cmux-claude-code-guide.md](setup/cmux-claude-code-guide.md)
- **skillify**: [skills/skillify/README.md](skills/skillify/README.md)

---

## 요구 사항

- [Claude Code](https://claude.ai/claude-code) (`npm install -g @anthropic-ai/claude-code`)
- cmux 스킬 사용 시: macOS 14.0+, [cmux](https://cmux.com) v0.63.1+ (`brew install cmux`)

## 라이선스

MIT
