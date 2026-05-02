#!/usr/bin/env bash
set -Eeuo pipefail

BASE="$HOME/openclaw_training"
WEB_DIR="$BASE/mission_control/webui"

echo "============================================================"
echo " MISSION CONTROL WEBUI STATUS"
echo "============================================================"
echo "Zeit: $(date)"
echo
echo "WebUI:"
echo "$WEB_DIR"
echo
echo "URL:"
echo "http://127.0.0.1:4173"
echo
echo "Files:"
find "$WEB_DIR" -maxdepth 3 -type f | sed "s#$WEB_DIR/##" | sort | head -200
echo
echo "Port:"
ss -tulpn 2>/dev/null | grep ':4173' || echo "Port 4173 aktuell nicht aktiv."
echo
echo "Node modules:"
if [ -d "$WEB_DIR/node_modules" ]; then
  echo "node_modules vorhanden"
else
  echo "node_modules fehlt: mission-control-webui-install ausführen"
fi
