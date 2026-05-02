#!/usr/bin/env bash
set -Eeuo pipefail

TS="$(date +%Y%m%d_%H%M%S)"
TODAY="$(date +%F)"
BASE="$HOME/openclaw_training"
DELIGHT_DIR="$BASE/mission_control/daily_delight"
PROJECT_DIR="$BASE/mission_control/projects"
REPORT_DIR="$BASE/reports"
DISCORD_SEND="$BASE/scripts/discord_send_channel.sh"
OUT="$DELIGHT_DIR/daily_delight_${TODAY}_$TS.md"
LATEST="$DELIGHT_DIR/latest_daily_delight.md"
REPORT="$REPORT_DIR/daily_delight_$TS.txt"

mkdir -p "$DELIGHT_DIR" "$PROJECT_DIR" "$REPORT_DIR"

exec > >(tee -a "$REPORT") 2>&1

echo "============================================================"
echo " SHADOWMAKER DAILY DELIGHT"
echo "============================================================"
echo "Zeit: $(date)"
echo "Report: $REPORT"
echo "Output: $OUT"
echo

DAY_NUM="$(date +%u)"

case "$DAY_NUM" in
  1)
    THEME="IHK/MFP Prüfungsmodul"
    BUILD="Eine SA1/SA2-Mikrodrill-Vorlage mit 10-Punkte-Gerüst."
    ;;
  2)
    THEME="OpenClaw Stabilität"
    BUILD="Ein Mini-Runbook für aktuellen Stackstatus und bekannte Warnpunkte."
    ;;
  3)
    THEME="Karriere / Bewerbungen"
    BUILD="Ein wiederverwendbares CV-Projektmodul für AI-Automation/OpenClaw."
    ;;
  4)
    THEME="Finanzen / Kontrolle"
    BUILD="Ein ruhiges Budget-Kontrollblatt als Markdown-Struktur."
    ;;
  5)
    THEME="Wohnung / Jobcenter"
    BUILD="Ein Nachweislog für WBS, Besichtigungen und Jobcenter-Kommunikation."
    ;;
  6)
    THEME="Memory Wiki"
    BUILD="Eine Konsolidierung der wichtigsten Entscheidungen der Woche."
    ;;
  *)
    THEME="Systempflege"
    BUILD="Ein Review-Template: Was läuft, was fehlt, was wird nicht angefasst."
    ;;
esac

cat > "$OUT" << MD
# Daily Delight – $TODAY

## Thema

$THEME

## Build-Idee

$BUILD

## Ziel

Ein kleiner, stabiler, nützlicher Baustein, der ohne Risiko in Mission Control aufgenommen werden kann.

## Output heute

### Mini-Artefakt

\`\`\`text
Thema: $THEME
Nutzen: sofort verwendbar
Risiko: niedrig
Automatisierung: nein, nur Vorschlag/Struktur
\`\`\`

## Umsetzungsvorschlag

1. Prüfen, ob der Vorschlag relevant ist.
2. Falls ja: als separates Modul bauen.
3. Vor produktiver Automatisierung: /freeze_report.
4. Nach stabilem Stand: Timeshift.

## Kontrollfrage

Bringt dieses Artefakt heute Kontrolle, Klarheit oder Wiederverwendbarkeit?

## Pfad

\`\`\`text
$OUT
\`\`\`
MD

cp "$OUT" "$LATEST"

echo "[OK] Daily Delight erstellt:"
echo "$OUT"
echo "Latest:"
echo "$LATEST"

if [ -x "$DISCORD_SEND" ]; then
  MSG="$(cat "$OUT")"
  "$DISCORD_SEND" DISCORD_DAILY_DELIGHT_WEBHOOK_URL "$MSG" || true
fi

echo
echo "============================================================"
echo "FERTIG"
echo "============================================================"
