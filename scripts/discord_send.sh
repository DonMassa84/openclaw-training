#!/usr/bin/env bash
set -Eeuo pipefail

ENV_FILE="$HOME/shadowmaker_bots/.env"

if [ ! -f "$ENV_FILE" ]; then
  echo "[FEHLER] Env-Datei fehlt: $ENV_FILE"
  exit 1
fi

set +u
source "$ENV_FILE"
set -u

WEBHOOK="${DISCORD_WEBHOOK_URL:-}"

case "$WEBHOOK" in
  https://discord.com/api/webhooks/*|https://discordapp.com/api/webhooks/*)
    ;;
  *)
    echo "[FEHLER] Kein gültiger DISCORD_WEBHOOK_URL gesetzt."
    exit 1
    ;;
esac

MSG="${*:-Shadowmaker Discord Test}"

python3 - "$MSG" > /tmp/discord_send_payload.json << 'PY'
import json, sys, datetime, socket
msg = sys.argv[1]
payload = {
    "username": "CrashBandicot",
    "content": msg,
    "embeds": [{
        "title": "Shadowmaker Alert",
        "description": msg,
        "fields": [
            {"name": "Host", "value": socket.gethostname(), "inline": True},
            {"name": "Zeit", "value": datetime.datetime.now().isoformat(timespec="seconds"), "inline": True}
        ]
    }]
}
print(json.dumps(payload))
PY

curl -sS -H 'Content-Type: application/json' -d @/tmp/discord_send_payload.json "$WEBHOOK"
echo
