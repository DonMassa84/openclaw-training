#!/usr/bin/env bash
set -Eeuo pipefail

TS="$(date +%Y%m%d_%H%M%S)"
BASE="$HOME/openclaw_training"
OUT_DIR="$BASE/mission_control/security"
REPORT_DIR="$BASE/reports"
OUT="$OUT_DIR/deep_security_check_$TS.md"
LATEST="$OUT_DIR/latest_deep_security_check.md"
REPORT="$REPORT_DIR/deep_security_check_$TS.txt"

mkdir -p "$OUT_DIR" "$REPORT_DIR"

exec > >(tee -a "$REPORT") 2>&1

USER_FAILED="$(systemctl --user --failed --no-pager 2>&1 || true)"
SYSTEM_FAILED="$(systemctl --failed --no-pager 2>&1 || true)"
PORTS="$(ss -tulpn 2>/dev/null | grep -E ':(18789|3001|5678|22|80|443)\b' || true)"
DOCKER_PS="$(docker ps --format '{{.Names}} | {{.Image}} | {{.Status}} | {{.Ports}}' 2>/dev/null || true)"
SENSITIVE_PATHS="$(find "$HOME" -maxdepth 5 \( -iname '.env' -o -iname '*.env' -o -iname '*token*' -o -iname '*secret*' -o -iname '*.pem' -o -iname '*.key' \) 2>/dev/null | head -120 || true)"
GIT_STATUS="$(cd "$BASE" && git status --short 2>/dev/null || true)"
TIMERS="$(systemctl --user list-timers --all --no-pager 2>/dev/null | grep -E 'shadowmaker|security|NEXT|LEFT' || true)"

{
  echo "# Deep Security Check Read-Only"
  echo
  echo "Stand: $(date)"
  echo
  echo "## Regel"
  echo
  echo "Read-only. Keine Reparatur. Keine Secrets im Inhalt."
  echo
  echo "## User Failed Services"
  echo
  echo '```text'
  echo "$USER_FAILED"
  echo '```'
  echo
  echo "## System Failed Services"
  echo
  echo '```text'
  echo "$SYSTEM_FAILED"
  echo '```'
  echo
  echo "## Relevante Ports"
  echo
  echo '```text'
  echo "$PORTS"
  echo '```'
  echo
  echo "## Docker"
  echo
  echo '```text'
  echo "$DOCKER_PS"
  echo '```'
  echo
  echo "## Sensible Pfade erkannt, Inhalte nicht ausgegeben"
  echo
  echo '```text'
  echo "$SENSITIVE_PATHS"
  echo '```'
  echo
  echo "## Git Status"
  echo
  echo '```text'
  echo "$GIT_STATUS"
  echo '```'
  echo
  echo "## User Timer"
  echo
  echo '```text'
  echo "$TIMERS"
  echo '```'
  echo
  echo "## Bewertung"
  echo
  echo "- Secrets werden nur als Pfade erkannt, nicht gelesen."
  echo "- OpenClaw Binding nicht verändern."
  echo "- ShadowOps failed services separat entscheiden: reparieren oder deaktivieren."
  echo "- casper-md5check ist typischerweise unkritisch."
} > "$OUT"

cp "$OUT" "$LATEST"

cat "$OUT"

if [ -x "$BASE/scripts/discord_send_channel.sh" ]; then
  "$BASE/scripts/discord_send_channel.sh" DISCORD_SECURITY_AUDIT_WEBHOOK_URL "Deep Security Check read-only repariert und erstellt: $LATEST" || true
fi

echo
echo "============================================================"
echo "FERTIG"
echo "============================================================"
echo "Latest:"
echo "$LATEST"
echo "Report:"
echo "$REPORT"
