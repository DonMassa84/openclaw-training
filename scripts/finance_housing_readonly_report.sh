#!/usr/bin/env bash
set -Eeuo pipefail

TS="$(date +%Y%m%d_%H%M%S)"
BASE="$HOME/openclaw_training"
OUT_DIR="$BASE/mission_control/finance_housing_readonly"
OUT="$OUT_DIR/finance_housing_readonly_report_$TS.md"
LATEST="$OUT_DIR/latest_finance_housing_readonly_report.md"

mkdir -p "$OUT_DIR"

cat > "$OUT" << 'MD'
# Finance / Housing Read-Only Report

## Zweck

Kontrollierte Übersicht ohne sensible Inhalte.

## Aktive Themen

- Jobcenter
- WBS / Wohnung
- Miete / Doppelmiete
- Budgetkontrolle
- offene Forderungen
- Nachweise

## Sicherheitsregel

Nur Metadaten und Aufgabenstruktur. Keine Kontoauszüge, Tokens, privaten Gesundheitsdaten oder vollständigen Behördenunterlagen in öffentliche Kanäle.

## Nächste sichere Aktion

Alle Nachweise getrennt nach Thema ablegen:

```text
finance_housing_readonly/
- jobcenter/
- wbs_wohnung/
- budget/
- forderungen/
- nachweise/
Prüflogik

Nichts löschen. Nichts automatisch senden. Erst Entwurf, dann Prüfung.
MD

cp "$OUT" "$LATEST"

echo "[OK] Finance/Housing Read-only Report:"
echo "$LATEST"

if [ -x "$BASE/scripts/discord_send_channel.sh" ]; then
"$BASE/scripts/discord_send_channel.sh" DISCORD_FINANCE_CONTROL_WEBHOOK_URL "✅ Finance/Housing Read-only Report aktualisiert: $LATEST" || true
fi
