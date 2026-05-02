#!/usr/bin/env bash
set -Eeuo pipefail

CHANNEL_ENV="$HOME/openclaw_training/mission_control/discord/discord_channels.env"

if [ ! -f "$CHANNEL_ENV" ]; then
  echo "[FEHLER] Channel ENV fehlt: $CHANNEL_ENV"
  exit 1
fi

KEY="${1:-}"
shift || true
MESSAGE="${*:-}"

if [ -z "$KEY" ]; then
  echo "Nutzung:"
  echo "$0 DISCORD_DAILY_BRIEF_WEBHOOK_URL Nachricht"
  exit 1
fi

URL="$(grep "^${KEY}=" "$CHANNEL_ENV" 2>/dev/null | cut -d= -f2- || true)"

if [ -z "$URL" ]; then
  echo "[FEHLER] Webhook-Key fehlt: $KEY"
  exit 1
fi

case "$URL" in
  https://discord.com/api/webhooks/*|https://discordapp.com/api/webhooks/*)
    ;;
  *)
    echo "[FEHLER] Ungültige Webhook-URL für $KEY"
    exit 1
    ;;
esac

if [ -z "$MESSAGE" ]; then
  MESSAGE="Shadowmaker Discord Channel Test"
fi

python3 - "$MESSAGE" > /tmp/shadowmaker_discord_payload.json << 'PY'
import json
import sys
import datetime
import socket

msg = sys.argv[1]
if len(msg) > 1800:
    msg = msg[:1800] + "\n...[gekürzt]"

payload = {
    "username": "CrashBandicot",
    "content": msg,
    "embeds": [{
        "title": "Shadowmaker Channel Routing",
        "description": msg[:3900],
        "fields": [
            {"name": "Host", "value": socket.gethostname(), "inline": True},
            {"name": "Zeit", "value": datetime.datetime.now().isoformat(timespec="seconds"), "inline": True}
        ]
    }]
}
print(json.dumps(payload))
PY

HTTP_CODE="$(curl -sS -o /tmp/shadowmaker_discord_payload.out -w '%{http_code}' -H 'Content-Type: application/json' -d @/tmp/shadowmaker_discord_payload.json "$URL" || true)"

case "$HTTP_CODE" in
  200|204)
    echo "[OK] Discord Send $KEY HTTP=$HTTP_CODE"
    ;;
  *)
    echo "[FEHLER] Discord Send $KEY HTTP=$HTTP_CODE"
    cat /tmp/shadowmaker_discord_payload.out || true
    exit 1
    ;;
esac
