#!/usr/bin/env bash
set -Eeuo pipefail

BASE="$HOME/openclaw_training"
FREEZE_SCRIPT="$BASE/scripts/shadowmaker_freeze_report_no_sudo.sh"
LATEST="$BASE/docs/status/latest_shadowmaker_freeze_report.md"
SENDER="$BASE/scripts/discord_send_channel.sh"

if [ ! -x "$FREEZE_SCRIPT" ]; then
  echo "[FEHLER] Freeze Script fehlt oder nicht ausführbar: $FREEZE_SCRIPT"
  exit 1
fi

if [ ! -x "$SENDER" ]; then
  echo "[FEHLER] Discord Sender fehlt: $SENDER"
  exit 1
fi

"$FREEZE_SCRIPT"

if [ ! -f "$LATEST" ]; then
  echo "[FEHLER] Latest Freeze Report fehlt: $LATEST"
  exit 1
fi

SUMMARY="$(python3 - "$LATEST" << 'PY'
from pathlib import Path
import sys
p = Path(sys.argv[1])
txt = p.read_text(encoding="utf-8", errors="replace")
keys = ["FREEZE", "Archiv", "SHA256", "OpenClaw", "Flowise", "n8n", "CrashBandicot", "Failed", "Report"]
lines = []
for line in txt.splitlines():
    if any(k.lower() in line.lower() for k in keys):
        lines.append(line)
out = "\n".join(lines).strip()
if not out:
    out = txt[:1600]
if len(out) > 1700:
    out = out[:1700] + "\n...[gekürzt]"
print("🧊 SHADOWMAKER FREEZE REPORT\n\n" + out + f"\n\nLatest: {p}")
PY
)"

"$SENDER" DISCORD_FREEZE_REPORTS_WEBHOOK_URL "$SUMMARY"
