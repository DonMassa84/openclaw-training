#!/usr/bin/env bash
set -Eeuo pipefail

TS="$(date +%Y%m%d_%H%M%S)"
BASE="$HOME/openclaw_training"
OUT_DIR="$BASE/mission_control/career_it"
REPORT_DIR="$BASE/reports"
OUT="$OUT_DIR/career_template_$TS.md"
LATEST="$OUT_DIR/latest_career_template.md"

mkdir -p "$OUT_DIR" "$REPORT_DIR"

cat > "$OUT" << 'MD'
# Career Agent Template

## 1. Fit-Analyse

Die Stelle passt besonders, wenn Anforderungen in IT-Support, IT-Operations, Automatisierung, Prozessanalyse, Systembetreuung oder AI-gestützten Workflows enthalten sind.

## 2. Positionierung

Ich positioniere mich als operativer IT-Profi mit technischer Umsetzungsstärke, Automatisierungserfahrung und strukturierter Arbeitsweise.

## 3. CV-Schwerpunkte

- IT-Support und Systembetreuung
- Python / Automatisierung
- lokale LLM-/RAG-Setups
- Docker / Linux / Monitoring
- Prozessdokumentation
- Schnittstelle zwischen Technik und Fachbereich

## 4. Kurznachricht

Guten Tag,

die ausgeschriebene Position ist für mich interessant, weil sie operative IT-Kompetenz mit strukturierter Prozessarbeit verbindet. Ich bringe Erfahrung in IT-Support, Automatisierung mit Python sowie im Aufbau lokaler AI-/RAG-Systeme mit. Gerne sende ich Ihnen meine Unterlagen oder bespreche kurz, ob mein Profil zu Ihrem Bedarf passt.

Viele Grüße  
Daniel Massa

## 5. Prüfpunkt

Vor Versand immer Stellenanzeige gegen CV-Mussanforderungen abgleichen.
MD

cp "$OUT" "$LATEST"

echo "[OK] Career Template erstellt:"
echo "$LATEST"

if [ -x "$BASE/scripts/discord_send_channel.sh" ]; then
  "$BASE/scripts/discord_send_channel.sh" DISCORD_CAREER_IT_WEBHOOK_URL "✅ Career Agent Template aktualisiert: $LATEST" || true
fi
