#!/usr/bin/env bash
set -Eeuo pipefail

BASE="$HOME/openclaw_training"
WEB_DIR="$BASE/mission_control/webui"
REPORT_DIR="$BASE/reports"
TS="$(date +%Y%m%d_%H%M%S)"
REPORT="$REPORT_DIR/mission_control_webui_install_$TS.txt"

mkdir -p "$REPORT_DIR"

exec > >(tee -a "$REPORT") 2>&1

echo "============================================================"
echo " MISSION CONTROL WEBUI INSTALL"
echo "============================================================"
echo "Zeit: $(date)"
echo "WebUI: $WEB_DIR"
echo "Report: $REPORT"
echo

if ! command -v npm >/dev/null 2>&1; then
  echo "[FEHLER] npm nicht gefunden. Node/npm installieren, dann erneut ausführen."
  exit 1
fi

cd "$WEB_DIR"

echo "[INFO] npm install startet..."
npm install

echo
echo "[OK] npm install abgeschlossen."
echo "Start:"
echo "mission-control-webui-start"
