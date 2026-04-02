# cmux-run

  별도 cmux 패인에서 서버, 빌드, 테스트 등 장시간 프로세스를 실행하고 모니터링합니다.

  > **전제 조건**: cmux 터미널 내부에서 실행해야 합니다 (`CMUX_WORKSPACE_ID` 자동 설정).

  ## 주요 기능

  - 별도 패인에서 장시간 프로세스 실행
  - 패인 자동 재사용 (같은 이름의 패인이 있으면 재사용)
  - 프로세스 충돌 감지 및 사이드바 상태 표시
  - 완료 시 알림

  ## 설치

  `will-public-claude-cmux` 플러그인에 포함되어 있습니다:

  /plugin marketplace add sdgranger/will-public-claude
  /plugin install will-public-claude-cmux

  수동 설치:

  ```bash
  git clone https://github.com/sdgranger/will-public-claude.git /tmp/wpc
  cp /tmp/wpc/skills/cmux-run/SKILL.md ~/.claude/skills/cmux-run/
  rm -rf /tmp/wpc

  레퍼런스

  - ../cmux/references/common-patterns.md
  - ../cmux/references/cli-reference.md

  5. **Commit changes** (commit directly to main)
