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

OPENCLAW_INTERNAL="$(docker exec -i openclaw-openclaw-gateway-1 sh -lc 'curl -sS -I --max-time 8 http://127.0.0.1:18789 2>&1 | head -1' 2>&1 || true)"
FLOWISE_HTTP="$(curl -sS -I --max-time 8 http://127.0.0.1:3001 2>&1 | head -1 || true)"
N8N_HTTP="$(curl -sS -I --max-time 8 http://127.0.0.1:5678 2>&1 | head -1 || true)"
DOCKER_PS="$(docker ps --format '{{.Names}}: {{.Status}}' | grep -Ei 'openclaw|shadowmaker|n8n|flowise' || true)"
USER_FAILED="$(systemctl --user --failed --no-pager 2>&1 || true)"

python3 - "$OPENCLAW_INTERNAL" "$FLOWISE_HTTP" "$N8N_HTTP" "$DOCKER_PS" "$USER_FAILED" > /tmp/discord_stack_payload.json << 'PY'
import json, sys, datetime, socket

openclaw, flowise, n8n, docker_ps, user_failed = sys.argv[1:6]

def short(s, n=900):
    return s if len(s) <= n else s[:n] + "\n..."

payload = {
    "username": "CrashBandicot",
    "content": "📡 Shadowmaker Stack Report",
    "embeds": [{
        "title": "Shadowmaker Stack Report",
        "description": "Automatischer Discord-Statusbericht.",
        "fields": [
            {"name": "Host", "value": socket.gethostname(), "inline": True},
            {"name": "Zeit", "value": datetime.datetime.now().isoformat(timespec="seconds"), "inline": True},
            {"name": "OpenClaw intern", "value": short(openclaw or "n/a", 300), "inline": False},
            {"name": "Flowise", "value": short(flowise or "n/a", 300), "inline": False},
            {"name": "n8n", "value": short(n8n or "n/a", 300), "inline": False},
            {"name": "Docker", "value": "```text\n" + short(docker_ps or "n/a", 900) + "\n```", "inline": False},
            {"name": "User Failed", "value": "```text\n" + short(user_failed or "n/a", 900) + "\n```", "inline": False}
        ]
    }]
}
print(json.dumps(payload))
PY

curl -sS -H 'Content-Type: application/json' -d @/tmp/discord_stack_payload.json "$WEBHOOK"
echo
