#!/usr/bin/env bash
set -Eeuo pipefail

BASE="$HOME/openclaw_training"
MAIL_DIR="$BASE/mission_control/mail_briefing"
CONFIG_DIR="$MAIL_DIR/config"
BRIEF="$MAIL_DIR/briefs/latest_courier_mail_brief.md"
STATUS_FILE="$BASE/docs/status/latest_courier_agent_status.md"

echo "============================================================"
echo " COURIER STATUS"
echo "============================================================"
echo "Zeit: $(date)"
echo

echo "Config:"
ls -la "$CONFIG_DIR" 2>/dev/null || true
echo

echo "Status:"
cat "$STATUS_FILE" 2>/dev/null || echo "Noch kein Status."
echo

echo "Latest Brief:"
if [ -f "$BRIEF" ]; then
  echo "$BRIEF"
  grep -E '^- Gesamt erfasste Mails:|^- P1 Heute bearbeiten:|^- P2 Diese Woche bearbeiten:|^- P3 Lesen/ablegen:|^- Fehler' "$BRIEF" || true
else
  echo "Noch kein Brief."
fi
