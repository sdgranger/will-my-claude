#!/bin/bash
# =============================================================
# cmux + Claude Code hooks 설정 스크립트
#
# Claude Code가 cmux 사이드바에 상태를 자동 표시하도록
# hooks를 설정합니다. (알림 링, "Running" 상태 등)
#
# 스킬은 별도로 설치해야 합니다 (README 참고).
# 이 스크립트는 hooks 설정만 담당합니다.
#
# 사용법: bash setup-cmux-hooks.sh
# =============================================================

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo ""
echo "========================================="
echo "  cmux + Claude Code hooks 설정"
echo "========================================="
echo ""

# --- 1. 사전 조건 확인 ---
echo "[1/3] 사전 조건 확인..."

if ! command -v cmux &>/dev/null; then
  echo -e "${RED}  ✗ cmux CLI를 찾을 수 없습니다.${NC}"
  echo "    cmux 앱 내부 터미널에서 실행하거나, 아래 명령으로 심볼릭 링크를 생성하세요:"
  echo "    ln -s /Applications/cmux.app/Contents/MacOS/cmux ~/.local/bin/cmux"
  exit 1
fi
echo -e "${GREEN}  ✓ cmux CLI: $(cmux version 2>/dev/null || echo 'OK')${NC}"

if ! command -v claude &>/dev/null; then
  echo -e "${YELLOW}  ⚠ Claude Code CLI를 찾을 수 없습니다. npm install -g @anthropic-ai/claude-code 로 설치하세요.${NC}"
else
  echo -e "${GREEN}  ✓ Claude Code: $(claude --version 2>/dev/null)${NC}"
fi

# --- 2. Claude Code hooks 설정 ---
echo ""
echo "[2/3] Claude Code hooks 설정..."

SETTINGS_FILE="$HOME/.claude/settings.json"
mkdir -p "$HOME/.claude"

HOOKS_JSON='{
    "SessionStart": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "cmux claude-hook session-start",
            "async": true
          }
        ]
      }
    ],
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "cmux claude-hook stop",
            "async": true
          }
        ]
      }
    ],
    "Notification": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "cmux claude-hook notification",
            "async": true
          }
        ]
      }
    ],
    "UserPromptSubmit": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "cmux claude-hook prompt-submit",
            "async": true
          }
        ]
      }
    ]
  }'

if [ -f "$SETTINGS_FILE" ]; then
  # 기존 설정에 hooks가 이미 있는지 확인
  if python3 -c "import json; d=json.load(open('$SETTINGS_FILE')); exit(0 if 'hooks' in d else 1)" 2>/dev/null; then
    echo -e "${YELLOW}  ⚠ hooks가 이미 설정되어 있습니다. 덮어쓰시겠습니까? (y/N)${NC}"
    read -r response
    if [[ ! "$response" =~ ^[Yy]$ ]]; then
      echo "  → hooks 설정을 건너뜁니다."
    else
      python3 -c "
import json
with open('$SETTINGS_FILE') as f:
    d = json.load(f)
d['hooks'] = json.loads('''$HOOKS_JSON''')
with open('$SETTINGS_FILE', 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('  done')
"
      echo -e "${GREEN}  ✓ hooks 업데이트 완료${NC}"
    fi
  else
    python3 -c "
import json
with open('$SETTINGS_FILE') as f:
    d = json.load(f)
d['hooks'] = json.loads('''$HOOKS_JSON''')
with open('$SETTINGS_FILE', 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
"
    echo -e "${GREEN}  ✓ hooks 추가 완료${NC}"
  fi
else
  python3 -c "
import json
d = {'hooks': json.loads('''$HOOKS_JSON''')}
with open('$SETTINGS_FILE', 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
"
  echo -e "${GREEN}  ✓ settings.json 생성 + hooks 추가 완료${NC}"
fi

# --- 3. 검증 ---
echo ""
echo "[3/3] 설정 검증..."

if cmux ping &>/dev/null; then
  echo -e "${GREEN}  ✓ cmux 소켓 연결 정상${NC}"
else
  echo -e "${YELLOW}  ⚠ cmux 소켓 연결 실패 — cmux 앱이 실행 중인지 확인하세요${NC}"
fi

if echo '{}' | cmux claude-hook stop &>/dev/null; then
  echo -e "${GREEN}  ✓ claude-hook 명령 정상${NC}"
else
  echo -e "${YELLOW}  ⚠ claude-hook 테스트 실패${NC}"
fi

echo ""
echo "========================================="
echo -e "${GREEN}  hooks 설정 완료!${NC}"
echo "========================================="
echo ""
echo "적용된 파일:"
echo "  • $SETTINGS_FILE  (Claude Code hooks)"
echo ""
echo "hooks가 하는 일:"
echo "  • 사이드바에 알림 링 자동 표시 (작업 완료 시)"
echo "  • 사이드바에 \"Running\" 상태 표시"
echo "  • 프롬프트 전송 시 알림 자동 초기화"
echo ""
echo "다음 단계:"
echo "  1. Claude Code를 재시작하세요 (/exit 후 claude)"
echo "  2. Claude Code 작업 완료 시 사이드바 알림 링을 확인하세요"
echo ""
