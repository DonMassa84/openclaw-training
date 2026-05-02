#!/usr/bin/env bash
set -Eeuo pipefail

TS="$(date +%Y%m%d_%H%M%S)"
BASE="$HOME/openclaw_training"
MISSION="$BASE/mission_control"
MAIL_DIR="$MISSION/mail_briefing"
VENV="$MAIL_DIR/.venv"
LOG_DIR="$MISSION/agent_runtime/logs"
REPORT_DIR="$BASE/reports"
LOG="$LOG_DIR/courier_run_$TS.txt"

mkdir -p "$LOG_DIR" "$REPORT_DIR"

exec > >(tee -a "$LOG") 2>&1

echo "============================================================"
echo " COURIER MAIL BRIEFING RUN"
echo "============================================================"
echo "Zeit: $(date)"
echo "Log: $LOG"
echo

"$VENV/bin/python" "$BASE/scripts/courier_mail_briefing_agent.py"

LATEST="$MAIL_DIR/briefs/latest_courier_mail_brief.md"

if [ -x "$BASE/scripts/discord_send_channel.sh" ] && [ -f "$LATEST" ]; then
  P1="$(grep -E '^- P1 Heute bearbeiten:' "$LATEST" | sed 's/.*: //' | head -1 || echo '?')"
  P2="$(grep -E '^- P2 Diese Woche bearbeiten:' "$LATEST" | sed 's/.*: //' | head -1 || echo '?')"
  TOTAL="$(grep -E '^- Gesamt erfasste Mails:' "$LATEST" | sed 's/.*: //' | head -1 || echo '?')"
  "$BASE/scripts/discord_send_channel.sh" DISCORD_DAILY_BRIEF_WEBHOOK_URL "📬 Courier Mail Brief: Gesamt=$TOTAL | P1=$P1 | P2=$P2 | lokal: $LATEST" || true
  "$BASE/scripts/discord_send_channel.sh" DISCORD_AGENT_LOGS_WEBHOOK_URL "📬 Courier read-only Lauf abgeschlossen. Keine Mails gesendet/gelöscht/archiviert." || true
fi

echo
echo "============================================================"
echo "COURIER RUN FERTIG"
echo "============================================================"
echo "Latest:"
echo "$LATEST"
