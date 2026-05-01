#!/usr/bin/env bash
set -Eeuo pipefail

echo "== OPENCLAW OPERATING LOOP =="
echo "Zeit: $(date)"
echo

echo "1) CrashBandicot"
systemctl --user status shadowmaker-control-bot.service --no-pager | sed -n '1,18p' || true
echo

echo "2) Docker"
docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}' | grep -Ei 'openclaw|flowise|n8n|gateway|agent' || true
echo

echo "3) OpenClaw Host-Test"
curl -sS -I --max-time 8 http://127.0.0.1:18789
 2>&1 || true
echo

echo "4) OpenClaw container-intern"
docker exec -i openclaw-openclaw-gateway-1 sh -lc 'curl -sS -I --max-time 8 http://127.0.0.1:18789
 2>&1 | head -20' || true
echo

echo "5) Flowise"
curl -sS -I --max-time 8 http://127.0.0.1:3001
 2>&1 | head -10 || true
echo

echo "6) n8n"
curl -sS -I --max-time 8 http://127.0.0.1:5678
 2>&1 | head -10 || true
echo

echo "Bewertung: OpenClaw ist OK, wenn container-intern HTTP/1.1 200 OK erscheint."
