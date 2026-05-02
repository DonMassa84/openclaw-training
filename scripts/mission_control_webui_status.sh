#!/usr/bin/env bash
set -u

BASE="$HOME/openclaw_training"
WEBUI="$BASE/mission_control/webui"
URL="http://127.0.0.1:4173"

echo "============================================================"
echo " MISSION CONTROL WEBUI STATUS"
echo "============================================================"
echo "Zeit: $(date)"
echo
echo "WebUI:"
echo "$WEBUI"
echo
echo "URL:"
echo "$URL"
echo

if [ ! -d "$WEBUI" ]; then
  echo "Status:"
  echo "WebUI-Verzeichnis fehlt."
  exit 1
fi

echo "Core Files:"
for f in package.json next.config.js postcss.config.js tailwind.config.ts tsconfig.json app/page.tsx app/layout.tsx app/globals.css lib/data.ts; do
  if [ -f "$WEBUI/$f" ]; then
    echo "[OK] $f"
  else
    echo "[MISS] $f"
  fi
done

echo
echo "Port:"
if ss -tulpn 2>/dev/null | grep -q ':4173\b'; then
  ss -tulpn 2>/dev/null | grep ':4173\b' || true
else
  echo "Port 4173 aktuell nicht aktiv."
fi

echo
echo "HTTP:"
curl -I --max-time 5 "$URL" 2>&1 | head -20 || true

echo
echo "Node modules:"
if [ -d "$WEBUI/node_modules" ]; then
  echo "node_modules vorhanden."
else
  echo "node_modules fehlt: mission-control-webui-install ausführen"
fi

echo
echo "Next Build:"
if [ -d "$WEBUI/.next" ]; then
  echo ".next vorhanden."
else
  echo ".next nicht vorhanden oder noch nicht gebaut."
fi
