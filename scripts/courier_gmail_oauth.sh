#!/usr/bin/env bash
set -Eeuo pipefail

BASE="$HOME/openclaw_training"
CONFIG_DIR="$BASE/mission_control/mail_briefing/config"
MAIL_DIR="$BASE/mission_control/mail_briefing"
CRED="$CONFIG_DIR/gmail_credentials.json"
TOKEN="$CONFIG_DIR/gmail_token.json"

echo "============================================================"
echo " COURIER GMAIL OAUTH"
echo "============================================================"
echo

if [ ! -f "$CRED" ]; then
  echo "[FEHLER] Gmail credentials.json fehlt:"
  echo "$CRED"
  echo
  echo "Lege die OAuth Desktop-App credentials.json dort ab und starte erneut."
  exit 1
fi

chmod 600 "$CRED"

echo "[INFO] Starte Gmail OAuth read-only."
echo "[INFO] Browser öffnet sich. Danach wird token lokal gespeichert:"
echo "$TOKEN"
echo

"$MAIL_DIR/.venv/bin/python" "$BASE/scripts/courier_mail_briefing_agent.py"

if [ -f "$TOKEN" ]; then
  chmod 600 "$TOKEN"
  echo "[OK] Gmail OAuth Token lokal erstellt:"
  echo "$TOKEN"
else
  echo "[WARN] Token wurde nicht gefunden. Prüfe Ausgabe."
fi
