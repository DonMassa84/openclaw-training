#!/usr/bin/env bash
set -Eeuo pipefail

TS="$(date +%Y%m%d_%H%M%S)"
BASE="$HOME/openclaw_training"
OUT_DIR="$BASE/mission_control/ihk_mfp"
REPORT_DIR="$BASE/reports"
OUT="$OUT_DIR/ihk_mfp_drill_$TS.md"
LATEST="$OUT_DIR/latest_ihk_mfp_drill.md"
REPORT="$REPORT_DIR/ihk_mfp_drill_$TS.txt"

mkdir -p "$OUT_DIR" "$REPORT_DIR"

exec > >(tee -a "$REPORT") 2>&1

cat > "$OUT" << 'MD'
# IHK/MFP Drill – SA1/SA2

## Zeitlimit

25 Minuten

## Situation

In einem IT-Unternehmen sinkt die Leistungsbereitschaft eines Projektteams. Deadlines werden verfehlt, die Kommunikation ist unklar, und einzelne Mitarbeiter wirken demotiviert. Die Führungskraft soll die Situation stabilisieren und die Zusammenarbeit verbessern.

## Aufgabe

Entwickeln Sie ein strukturiertes Vorgehen zur Analyse und Verbesserung der Teamleistung.

## Schreibstruktur

### 1. Situation

Im Projektteam bestehen Leistungs- und Kommunikationsprobleme. Dies gefährdet Termine, Qualität und Motivation.

### 2. Ziel SMART

Innerhalb von vier Wochen soll die Termintreue des Teams von aktuell unzureichend auf mindestens 90 % steigen, die Aufgabenverteilung transparent dokumentiert werden und die Mitarbeiterzufriedenheit durch ein strukturiertes Teamgespräch verbessert werden.

### 3. Stakeholder

Betroffen sind Teammitglieder, Projektleitung, Führungskraft, Kunden, Geschäftsleitung und gegebenenfalls Betriebsrat.

### 4. Ursachen

Mensch: unklare Erwartungen, Demotivation, Konflikte.  
Organisation: fehlende Rollenklärung, unzureichende Führung, unklare Prioritäten.  
Prozess: fehlende Abstimmung, keine regelmäßigen Reviews, mangelhafte Aufgabenverfolgung.

### 5. Alternativen

A: Einzelgespräche mit allen Teammitgliedern.  
B: Teamworkshop mit Rollenklärung und Maßnahmenplan.  
C: Kombination aus Einzelgesprächen, Teamworkshop und regelmäßigen Reviews.

### 6. Bewertung

Wirtschaftlich ist C sinnvoll, da Terminverzug und Nacharbeit reduziert werden.  
Menschlich ist C geeignet, weil individuelle Ursachen berücksichtigt und Beteiligung ermöglicht wird.  
Organisatorisch schafft C klare Rollen, Prozesse und Verantwortlichkeiten.

### 7. Entscheidung

Ich entscheide mich für Alternative C, weil sie sowohl individuelle als auch strukturelle Ursachen berücksichtigt und nachhaltige Verbesserung ermöglicht.

### 8. Umsetzung

Die Führungskraft führt in Woche 1 Einzelgespräche, in Woche 2 einen Teamworkshop und ab Woche 3 wöchentliche Kurzreviews durch. Aufgaben, Rollen und Fristen werden schriftlich festgelegt.

### 9. Kontrolle

Kontrolliert werden Termintreue, offene Aufgaben, Fehlerrate, Rückmeldungen im Team und Zielerreichung nach vier Wochen. Bei Abweichungen werden Maßnahmen angepasst.

### 10. Nachhaltigkeit & Kommunikation

Die Ergebnisse werden transparent kommuniziert und in regelmäßigen Reviews gesichert. Rechtlich ist auf Mitbestimmungsrechte des Betriebsrats zu achten, sofern Arbeitsverhalten, Beurteilungssysteme oder technische Überwachung betroffen sind.
MD

cp "$OUT" "$LATEST"

echo "[OK] IHK/MFP Drill erstellt:"
echo "$OUT"
echo "Latest:"
echo "$LATEST"

if [ -x "$BASE/scripts/discord_send_channel.sh" ]; then
  "$BASE/scripts/discord_send_channel.sh" DISCORD_IHK_MFP_WEBHOOK_URL "✅ IHK/MFP Drill erstellt: $LATEST" || true
fi
