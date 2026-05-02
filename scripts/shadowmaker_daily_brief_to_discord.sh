#!/usr/bin/env bash
set -Eeuo pipefail

BASE="$HOME/openclaw_training"
DAILY_SCRIPT="$BASE/scripts/shadowmaker_daily_brief.sh"
LATEST="$BASE/mission_control/daily_briefs/latest_daily_brief.md"
SENDER="$BASE/scripts/discord_send_channel.sh"

if [ ! -x "$DAILY_SCRIPT" ]; then
  echo "[FEHLER] Daily Brief Script fehlt oder nicht ausführbar: $DAILY_SCRIPT"
  exit 1
fi

if [ ! -x "$SENDER" ]; then
  echo "[FEHLER] Discord Sender fehlt: $SENDER"
  exit 1
fi

"$DAILY_SCRIPT"

if [ ! -f "$LATEST" ]; then
  echo "[FEHLER] Latest Daily Brief fehlt: $LATEST"
  exit 1
fi

SUMMARY="$(python3 - "$LATEST" << 'PY'
from pathlib import Path
import sys
p = Path(sys.argv[1])
txt = p.read_text(encoding="utf-8", errors="replace")
lines = txt.splitlines()
keep = []
for line in lines:
    if line.strip().startswith("# "):
        keep.append(line)
    elif "Kurzstatus" in line or "Offene Punkte" in line or "CrashBandicot:" in line or "OpenClaw" in line or "Flowise:" in line or "n8n:" in line or "Telegram" in line or "Freeze" in line or "Timeshift" in line:
        keep.append(line)
    elif line.strip().startswith("- "):
        keep.append(line)
out = "\n".join(keep).strip()
if not out:
    out = txt[:1600]
if len(out) > 1700:
    out = out[:1700] + "\n...[gekürzt]"
print("📌 SHADOWMAKER DAILY BRIEF\n\n" + out + f"\n\nLatest: {p}")
PY
)"

"$SENDER" DISCORD_DAILY_BRIEF_WEBHOOK_URL "$SUMMARY"
