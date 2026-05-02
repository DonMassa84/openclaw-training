#!/usr/bin/env bash
set -Eeuo pipefail

BASE="$HOME/openclaw_training"
WEB_DIR="$BASE/mission_control/webui"
REPORT_DIR="$BASE/reports"
TS="$(date +%Y%m%d_%H%M%S)"
REPORT="$REPORT_DIR/mission_control_webui_start_$TS.txt"

mkdir -p "$REPORT_DIR"

cd "$WEB_DIR"

echo "============================================================" | tee -a "$REPORT"
echo " MISSION CONTROL WEBUI START" | tee -a "$REPORT"
echo "============================================================" | tee -a "$REPORT"
echo "Zeit: $(date)" | tee -a "$REPORT"
echo "URL: http://127.0.0.1:4173" | tee -a "$REPORT"
echo "Report: $REPORT" | tee -a "$REPORT"
echo | tee -a "$REPORT"

if [ ! -d "$WEB_DIR/node_modules" ]; then
  echo "[FEHLER] node_modules fehlt. Erst ausführen:" | tee -a "$REPORT"
  echo "mission-control-webui-install" | tee -a "$REPORT"
  exit 1
fi

npm run dev 2>&1 | tee -a "$REPORT"
