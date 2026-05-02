#!/usr/bin/env bash
set -Eeuo pipefail

TS="$(date +%Y%m%d_%H%M%S)"
BASE="$HOME/openclaw_training"
REPORT_DIR="$BASE/reports"
SECURITY_DIR="$BASE/mission_control/security"
REPORT="$REPORT_DIR/openclaw_security_health_$TS.txt"

mkdir -p "$REPORT_DIR" "$SECURITY_DIR"

exec > >(tee -a "$REPORT") 2>&1

echo "============================================================"
echo " OPENCLAW SECURITY + HEALTH CHECK"
echo "============================================================"
echo "Zeit: $(date)"
echo

echo "1) CrashBandicot"
systemctl --user status shadowmaker-control-bot.service --no-pager || true
echo

echo "2) Docker Container"
docker ps --format 'table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}' | grep -Ei 'openclaw|flowise|n8n|gateway|agent|bot' || true
echo

echo "3) OpenClaw intern"
docker exec -i openclaw-openclaw-gateway-1 sh -lc 'curl -sS -I --max-time 8 [http://127.0.0.1:18789](http://127.0.0.1:18789) 2>&1 | head -20' || true
echo

echo "4) Flowise"
curl -sS -I --max-time 8 [http://127.0.0.1:3001](http://127.0.0.1:3001) 2>&1 | head -20 || true
echo

echo "5) n8n"
curl -sS -I --max-time 8 [http://127.0.0.1:5678](http://127.0.0.1:5678) 2>&1 | head -20 || true
echo

echo "6) Telegram IPv4"
curl -4 -I --max-time 8 [https://api.telegram.org](https://api.telegram.org) 2>&1 | head -20 || true
echo

echo "7) Telegram IPv6"
curl -6 -I --max-time 8 [https://api.telegram.org](https://api.telegram.org) 2>&1 | head -20 || true
echo

echo "8) Failed Services"
echo "-- User --"
systemctl --user --failed || true
echo
echo "-- System --"
systemctl --failed || true
echo

echo "9) Secrets Quick Scan ohne Inhalte auszugeben"
grep -RIlE 'TELEGRAM_BOT_TOKEN|OPENAI_API_KEY|ANTHROPIC_API_KEY|DISCORD_WEBHOOK|OPENCLAW_GATEWAY_TOKEN' "$HOME/shadowmaker_bots" "$HOME/openclaw_training" /opt/openclaw 2>/dev/null || true
echo

echo "10) Disk / RAM"
free -h || true
df -h / || true
echo

cp "$REPORT" "$SECURITY_DIR/latest_security_health_report.txt"

echo "============================================================"
echo "BEWERTUNG"
echo "============================================================"
echo "OpenClaw OK, wenn container-intern HTTP/1.1 200 OK."
echo "Host-HTTP-Fail ist dokumentierte Einschränkung."
echo "Keine Secrets im Report ausgeben."
echo "============================================================"
