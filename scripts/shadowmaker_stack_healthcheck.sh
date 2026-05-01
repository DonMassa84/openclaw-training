#!/usr/bin/env bash
set -Eeuo pipefail

echo "============================================================"
echo " SHADOWMAKER STACK HEALTHCHECK"
echo "============================================================"
echo "Zeit: $(date)"
echo

echo "1) Telegram Control Bot"
systemctl --user status shadowmaker-control-bot.service --no-pager || true
echo

echo "2) Docker Container"
docker ps --format 'table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}' | grep -Ei 'openclaw|flowise|n8n|gateway|agent' || true
echo

echo "3) OpenClaw Host-Test"
curl -sS -I --max-time 8 http://127.0.0.1:18789 2>&1 || true
echo

echo "4) OpenClaw container-intern"
docker exec -i openclaw-openclaw-gateway-1 sh -lc 'curl -sS -I --max-time 8 http://127.0.0.1:18789 2>&1 | head -20' || true
echo

echo "5) Flowise"
curl -sS -I --max-time 8 http://127.0.0.1:3001 2>&1 || true
echo

echo "6) n8n"
curl -sS -I --max-time 8 http://127.0.0.1:5678 2>&1 || true
echo

echo "7) Failed Services"
echo "-- User --"
systemctl --user --failed || true
echo
echo "-- System --"
systemctl --failed || true
echo

echo "============================================================"
echo "ERWARTUNG"
echo "============================================================"
echo "CrashBandicot: active/running"
echo "OpenClaw Host-Test: darf FAIL/Reset zeigen"
echo "OpenClaw container-intern: muss HTTP/1.1 200 OK zeigen"
echo "Flowise: erreichbar"
echo "n8n: erreichbar"
echo "============================================================"
