#!/usr/bin/env bash
set -Eeuo pipefail

echo "== SHADOWMAKER STACK STATUS =="
echo

echo "== Telegram Control Bot =="
systemctl --user is-active shadowmaker-control-bot.service || true
echo

echo "== Docker =="
docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}' | grep -Ei 'openclaw|flowise|n8n|gateway|agent' || true
echo

echo "== OpenClaw intern =="
docker exec -i openclaw-openclaw-gateway-1 sh -lc 'curl -sS -I --max-time 8 http://127.0.0.1:18789 2>&1 | head -5' || true
echo

echo "== Flowise =="
curl -sS -I --max-time 8 http://127.0.0.1:3001 2>&1 | head -5 || true
echo

echo "== n8n =="
curl -sS -I --max-time 8 http://127.0.0.1:5678 2>&1 | head -5 || true
