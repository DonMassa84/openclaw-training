#!/usr/bin/env bash
set -Eeuo pipefail

TS="$(date +%Y%m%d_%H%M%S)"
BASE="$HOME/openclaw_training"
MISSION="$BASE/mission_control"
RUNTIME_DIR="$MISSION/agent_runtime"
WINKY_DIR="$RUNTIME_DIR/winky"
LOG_DIR="$RUNTIME_DIR/logs"
STATUS_DIR="$BASE/docs/status"
REPORT_DIR="$BASE/reports"
OUT="$WINKY_DIR/winky_report_$TS.md"
LATEST="$WINKY_DIR/latest_winky_report.md"
STATUS_LATEST="$STATUS_DIR/latest_winky_agent_status.md"
LOG="$LOG_DIR/winky_run_$TS.txt"

mkdir -p "$WINKY_DIR" "$LOG_DIR" "$STATUS_DIR" "$REPORT_DIR"

exec > >(tee -a "$LOG") 2>&1

HOST="$(hostname)"
NOW="$(date)"
UPTIME="$(uptime 2>/dev/null || true)"
RAM="$(free -h 2>/dev/null || true)"
DISK="$(df -h / 2>/dev/null || true)"
USER_FAILED="$(systemctl --user --failed --no-pager 2>&1 || true)"
SYSTEM_FAILED="$(systemctl --failed --no-pager 2>&1 || true)"
USER_TIMERS="$(systemctl --user list-timers --all --no-pager 2>/dev/null | grep -E 'NEXT|LEFT|shadowmaker|openclaw|security|timer' || true)"
DOCKER_PS="$(docker ps --format '{{.Names}} | {{.Status}} | {{.Ports}}' 2>/dev/null || true)"
PORTS="$(ss -tulpn 2>/dev/null | grep -E ':(18789|3000|3001|4173|5678)\b' || true)"

OPENCLAW_HOST="$(curl -sS -I --max-time 5 http://127.0.0.1:18789 2>&1 | head -20 || true)"
FLOWISE="$(curl -sS -I --max-time 5 http://127.0.0.1:3001 2>&1 | head -10 || true)"
N8N="$(curl -sS -I --max-time 5 http://127.0.0.1:5678 2>&1 | head -10 || true)"
WEBUI="$(curl -sS -I --max-time 5 http://127.0.0.1:4173 2>&1 | head -10 || true)"

if echo "$OPENCLAW_HOST" | grep -qi "HTTP/"; then OPENCLAW_OK="YES"; else OPENCLAW_OK="WARN"; fi
if echo "$FLOWISE" | grep -qi "HTTP/"; then FLOWISE_OK="YES"; else FLOWISE_OK="WARN"; fi
if echo "$N8N" | grep -qi "HTTP/"; then N8N_OK="YES"; else N8N_OK="WARN"; fi
if echo "$WEBUI" | grep -qi "HTTP/"; then WEBUI_OK="YES"; else WEBUI_OK="WARN"; fi

cat > "$OUT" << MD
# Winky System Monitor Report

Stand: $NOW

## Rolle

Winky ist der read-only System-Monitor der Shadowmaker/OpenClaw-Crew.

## Kurzstatus

Host: $HOST  
OpenClaw Host HTTP: $OPENCLAW_OK  
Flowise: $FLOWISE_OK  
n8n: $N8N_OK  
Mission Control WebUI: $WEBUI_OK  

## Uptime

\`\`\`text
$UPTIME
\`\`\`

## RAM

\`\`\`text
$RAM
\`\`\`

## Disk Root

\`\`\`text
$DISK
\`\`\`

## Docker

\`\`\`text
$DOCKER_PS
\`\`\`

## Relevante Ports

\`\`\`text
$PORTS
\`\`\`

## User Failed Services

\`\`\`text
$USER_FAILED
\`\`\`

## System Failed Services

\`\`\`text
$SYSTEM_FAILED
\`\`\`

## User Timer

\`\`\`text
$USER_TIMERS
\`\`\`

## OpenClaw HTTP

\`\`\`text
$OPENCLAW_HOST
\`\`\`

## Flowise HTTP

\`\`\`text
$FLOWISE
\`\`\`

## n8n HTTP

\`\`\`text
$N8N
\`\`\`

## Mission Control WebUI HTTP

\`\`\`text
$WEBUI
\`\`\`

## Bewertung

- Read-only ausgeführt.
- Keine Secrets gelesen.
- Keine Reparatur durchgeführt.
- Kein sudo verwendet.
- Kein Fundament verändert.

## Nächste Entscheidung

shadowops-log-push.timer ist deaktiviert.  
casper-md5check.service bleibt unkritisch, wenn es nur Live-ISO-Reststatus ist.
MD

cp "$OUT" "$LATEST"
cp "$OUT" "$STATUS_LATEST"

cat "$OUT"

if [ -x "$BASE/scripts/discord_send_channel.sh" ]; then
  "$BASE/scripts/discord_send_channel.sh" DISCORD_AGENT_LOGS_WEBHOOK_URL "🤖 Winky Report erstellt: $LATEST" || true
  "$BASE/scripts/discord_send_channel.sh" DISCORD_OPENCLAW_STATUS_WEBHOOK_URL "🩺 Winky Kurzstatus: OpenClaw=$OPENCLAW_OK Flowise=$FLOWISE_OK n8n=$N8N_OK WebUI=$WEBUI_OK" || true
fi

echo
echo "============================================================"
echo "WINKY FERTIG"
echo "============================================================"
echo "Report:"
echo "$LATEST"
echo "Log:"
echo "$LOG"
