#!/usr/bin/env bash
set -Eeuo pipefail

echo "== START SHADOWMAKER STACK =="

echo "1) OpenClaw Docker Stack"
if [ -d /opt/openclaw ] && [ -f /opt/openclaw/docker-compose.yml ]; then
  cd /opt/openclaw
  sudo docker compose up -d
else
  echo "[WARN] /opt/openclaw/docker-compose.yml nicht gefunden."
fi

echo
echo "2) Telegram Control Bot"
systemctl --user daemon-reload
systemctl --user enable shadowmaker-control-bot.service
systemctl --user restart shadowmaker-control-bot.service

echo
echo "3) Status"
systemctl --user status shadowmaker-control-bot.service --no-pager || true
docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}' | grep -Ei 'openclaw|flowise|n8n|gateway|agent' || true
