#!/usr/bin/env bash
set -Eeuo pipefail

TS="$(date +%Y%m%d_%H%M%S)"
BASE="$HOME/openclaw_training"
OUT_DIR="$BASE/mission_control/prompt_to_code"
OUT="$OUT_DIR/prompt_to_code_review_$TS.md"
LATEST="$OUT_DIR/latest_prompt_to_code_review.md"

mkdir -p "$OUT_DIR"

{
echo "# Prompt-to-Code Review"
echo
echo "Stand: $(date)"
echo
echo "## Skript-Kandidaten"
echo
find "$BASE/scripts" -maxdepth 1 -type f -name '*.sh' -printf '%f\n' | sort
echo
echo "## Bewertung"
echo
echo "Stabile Skripte sind vorhanden. Neue Automatisierungen nur klein, testbar und ohne sudo."
echo
echo "## Nächste Kandidaten"
echo
echo "- IHK Drill Varianten"
echo "- Career Template Generator"
echo "- Memory Wiki Weekly Summary"
echo "- Local Inventory Deep Dive read-only"
} > "$OUT"

cp "$OUT" "$LATEST"

cat "$OUT"

if [ -x "$BASE/scripts/discord_send_channel.sh" ]; then
"$BASE/scripts/discord_send_channel.sh" DISCORD_OPENCLAW_PROJECTS_WEBHOOK_URL "✅ Prompt-to-Code Review erstellt: $LATEST" || true
fi
