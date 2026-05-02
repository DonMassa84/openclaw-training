#!/usr/bin/env bash
set -Eeuo pipefail

BASE="$HOME/openclaw_training"
SENDER="$BASE/scripts/discord_send_channel.sh"

OPENCLAW_INTERNAL="$(docker exec -i openclaw-openclaw-gateway-1 sh -lc 'curl -sS -I --max-time 8 http://127.0.0.1:18789 2>&1 | head -1' 2>&1 || true)"
FLOWISE="$(curl -sS -I --max-time 8 http://127.0.0.1:3001 2>&1 | head -1 || true)"
N8N="$(curl -sS -I --max-time 8 http://127.0.0.1:5678 2>&1 | head -1 || true)"
DOCKER="$(docker ps --format '{{.Names}} | {{.Status}} | {{.Ports}}' | grep -Ei 'openclaw|shadowmaker|flowise|n8n' || true)"

MSG="$(cat << MSG
📡 OPENCLAW STATUS

OpenClaw intern:
$OPENCLAW_INTERNAL

Flowise:
$FLOWISE

n8n:
$N8N

Docker:
$DOCKER
MSG
)"

"$SENDER" DISCORD_OPENCLAW_STATUS_WEBHOOK_URL "$MSG"
