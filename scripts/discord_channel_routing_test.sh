#!/usr/bin/env bash
set -Eeuo pipefail

BASE="$HOME/openclaw_training"
SENDER="$BASE/scripts/discord_send_channel.sh"

"$SENDER" DISCORD_SYSTEM_ALERTS_WEBHOOK_URL "✅ Routing OK: #system-alerts"
"$SENDER" DISCORD_DAILY_BRIEF_WEBHOOK_URL "✅ Routing OK: #daily-brief"
"$SENDER" DISCORD_FREEZE_REPORTS_WEBHOOK_URL "✅ Routing OK: #freeze-reports"
"$SENDER" DISCORD_OPENCLAW_STATUS_WEBHOOK_URL "✅ Routing OK: #openclaw-status"
"$SENDER" DISCORD_SECURITY_AUDIT_WEBHOOK_URL "✅ Routing OK: #security-audit"
"$SENDER" DISCORD_MISSION_CONTROL_WEBHOOK_URL "✅ Routing OK: #mission-control"
