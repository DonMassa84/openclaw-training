#!/usr/bin/env bash
set -Eeuo pipefail

BASE="$HOME/openclaw_training"
SENDER="$BASE/scripts/discord_send_channel.sh"

USER_FAILED="$(systemctl --user --failed --no-pager 2>&1 || true)"
SYSTEM_FAILED="$(systemctl --failed --no-pager 2>&1 || true)"
PORTS="$(ss -tulpn 2>/dev/null | grep -E ':(18789|3001|5678|22|80|443)\b' || true)"
GIT_STATUS="$(cd "$BASE" && git status --short 2>/dev/null || true)"

MSG="$(cat << MSG
🛡️ SHADOWMAKER SECURITY AUDIT

User failed services:
$USER_FAILED

System failed services:
$SYSTEM_FAILED

Relevante Ports:
$PORTS

Git Status:
$GIT_STATUS

Regel:
Audit berichtet nur. Keine automatische Reparatur.
MSG
)"

"$SENDER" DISCORD_SECURITY_AUDIT_WEBHOOK_URL "$MSG"
