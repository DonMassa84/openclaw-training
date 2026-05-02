#!/usr/bin/env bash
set -Eeuo pipefail

echo "============================================================"
echo " OPENCLAW OPERATING LOOP"
echo "============================================================"
echo "Zeit: $(date)"
echo

echo "1) CrashBandicot Status"
systemctl --user is-active shadowmaker-control-bot.service || true
systemctl --user status shadowmaker-control-bot.service --no-pager | sed -n '1,18p' || true
echo

echo "2) Docker Status"
docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}' | grep -Ei 'openclaw|flowise|n8n|gateway|agent' || true
echo

echo "3) OpenClaw Host-Test"
curl -sS -I --max-time 8 [http://127.0.0.1:18789](http://127.0.0.1:18789) 2>&1 || true
echo

echo "4) OpenClaw Container-Intern"
docker exec -i openclaw-openclaw-gateway-1 sh -lc 'curl -sS -I --max-time 8 [http://127.0.0.1:18789](http://127.0.0.1:18789) 2>&1 | head -20' || true
echo

echo "5) Flowise"
curl -sS -I --max-time 8 [http://127.0.0.1:3001](http://127.0.0.1:3001) 2>&1 | head -20 || true
echo

echo "6) n8n"
curl -sS -I --max-time 8 [http://127.0.0.1:5678](http://127.0.0.1:5678) 2>&1 | head -20 || true
echo

echo "7) Telegram IPv4"
curl -4 -I --max-time 8 [https://api.telegram.org](https://api.telegram.org) 2>&1 | head -20 || true
echo

echo "8) Telegram IPv6"
curl -6 -I --max-time 8 [https://api.telegram.org](https://api.telegram.org) 2>&1 | head -20 || true
echo

echo "9) Failed Services"
systemctl --user --failed || true
echo
systemctl --failed || true
echo

echo "============================================================"
echo " BEWERTUNG"
echo "============================================================"
echo "OpenClaw Host-FAIL ist akzeptiert, wenn Container-intern HTTP/1.1 200 OK zeigt."
echo "CrashBandicot ist die primäre Kontrollinstanz."
echo "Keine Binding-Experimente bei stabilem internen OpenClaw-Test."
echo "============================================================"
