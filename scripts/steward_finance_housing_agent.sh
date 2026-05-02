#!/usr/bin/env bash
set -Eeuo pipefail

TS="$(date +%Y%m%d_%H%M%S)"
TODAY="$(date +%F)"

BASE="$HOME/openclaw_training"
MISSION="$BASE/mission_control"
RUNTIME_DIR="$MISSION/agent_runtime"
STEWARD_DIR="$RUNTIME_DIR/steward"
LOG_DIR="$RUNTIME_DIR/logs"
FH_DIR="$MISSION/finance_housing_readonly"
MEMORY_DIR="$MISSION/memory_wiki"
STATUS_DIR="$BASE/docs/status"
REPORT_DIR="$BASE/reports"

OUT="$STEWARD_DIR/steward_finance_housing_report_$TS.md"
LATEST="$STEWARD_DIR/latest_steward_report.md"
FH_REPORT="$FH_DIR/steward_finance_housing_readonly_${TODAY}_${TS}.md"
FH_LATEST="$FH_DIR/latest_steward_finance_housing_readonly.md"
STATUS_LATEST="$STATUS_DIR/latest_steward_agent_status.md"
LOG="$LOG_DIR/steward_run_$TS.txt"

mkdir -p "$STEWARD_DIR" "$LOG_DIR" "$FH_DIR" "$MEMORY_DIR" "$STATUS_DIR" "$REPORT_DIR"

exec > >(tee -a "$LOG") 2>&1

cat > "$FH_REPORT" << MD
# Steward Finance/Housing/Jobcenter Read-Only Report – $TODAY

Stand: $(date)

## 1 Situation

Der Bereich Finanzen/Wohnen/Jobcenter benötigt eine klare, nachweissichere Struktur. Ziel ist nicht Automatisierung von Zahlungen oder Kommunikation, sondern Kontrolle über Fristen, Nachweise, offene Punkte und Argumentationslinien.

## 2 Ziel

Innerhalb der nächsten Arbeitswoche sollen alle relevanten Nachweise zu Wohnen, WBS, Jobcenter, KdU, Doppelmiete, Wohnungssuche und offenen Zahlungsverpflichtungen strukturiert vorliegen, damit jede Kommunikation sachlich, vollständig und belegbar erfolgen kann.

## 3 Beteiligte Stellen

- Jobcenter Stuttgart / zuständige Sachbearbeitung
- Vermieter / Hausverwaltung / Makler
- WBS-/Wohnungsamt
- potenzielle neue Vermieter
- Bank / P-Konto falls relevant
- Gläubiger nur bei Ratenvereinbarungen
- Nutzer als alleinige Entscheidungsinstanz

## 4 Nachweisliste

Wohnen / Jobcenter:
- aktueller Mietvertrag
- aktuelle Miethöhe
- WBS-Nachweis
- Wohnungsbesichtigungen mit Datum/Uhrzeit
- Bewerbungen auf Wohnungen
- Absagen oder Rückmeldungen
- Nachweis über Vormerkdatei / Dringlichkeit, falls vorhanden
- Fragebogen Vermieter / Mietangebot
- Antrag auf Zusicherung der Kosten der Unterkunft
- Nachweis Doppelmiete, falls erforderlich

Finanzen:
- Bürgergeld-/Leistungsbescheid
- Kontoauszüge nur lokal und nicht im Klartext an Discord
- offene Forderungen mit Betrag
- Ratenvereinbarungen
- Zahlungsfristen
- erledigte Forderungen separat markieren

## 5 Offene Punkte

- shadowops-autopilot.service und shadowops-log-push.service sind technische offene Punkte, nicht finanzbezogen.
- Finanz- und Wohnungsdaten dürfen nicht automatisch versendet werden.
- Jobcenter-Kommunikation muss einzeln geprüft werden.
- Doppelmiete nur mit vorheriger Zusicherung absichern.
- Mietvertrag vor Weitergabe an Jobcenter auf Betrag, Dauer, Nebenkosten, Beginn und Unterschriften prüfen.

## 6 Risiken

| Risiko | Bewertung | Kontrolle |
|---|---|---|
| unvollständige Nachweise | mittel | Nachweisliste abarbeiten |
| falsche oder zu frühe Vermieterkommunikation | mittel | Entwürfe manuell prüfen |
| Doppelmiete ohne Zusicherung | hoch | vorher schriftliche Bestätigung einholen |
| KdU-Grenze überschritten | hoch | Mietangebot mit Jobcenter abgleichen |
| sensible Daten in Discord | hoch | keine Beträge/Kontoauszüge/Details posten |
| automatische Zahlung/Versand | hoch | verboten |

## 7 Nächste sichere Aktion

1. Aktuellen Wohn-/Jobcenter-Fall als eigenes Dossier im Ordner finance_housing_readonly strukturieren.
2. Nachweise nur als Dateinamen/Status erfassen, nicht als sensible Inhalte.
3. Für jede Jobcenter-Mail einen Entwurf erstellen, aber manuell prüfen.
4. Keine automatische Kommunikation auslösen.
5. Nach jeder wichtigen Entscheidung Freeze Report + Timeshift nur bei Systemänderungen.

## 8 Kommunikationsentwurf – Jobcenter neutral

Sehr geehrte Damen und Herren,

anbei bzw. nachfolgend reiche ich die aktuellen Unterlagen zu meinem Wohnungs- bzw. Mietangelegenheit nach. Ziel ist eine transparente Prüfung der Kostenübernahme und eine nachvollziehbare Dokumentation meiner bisherigen Bemühungen.

Bitte teilen Sie mir mit, falls weitere Unterlagen oder Angaben erforderlich sind.

Mit freundlichen Grüßen  
Daniel Massa

## 9 Bewertungslogik

Steward gibt keine verbindliche Rechtsberatung und trifft keine finale Entscheidung. Steward strukturiert nur die Lage, markiert Risiken und bereitet prüfbare Entwürfe vor.

## 10 Kontrollsatz

Keine Zahlung, kein Antrag, keine Mail und keine Vermieterkommunikation erfolgt automatisch. Alles bleibt manuell freigabepflichtig.
MD

cp "$FH_REPORT" "$FH_LATEST"

cat > "$OUT" << MD
# Steward Agent Report

Stand: $(date)

## Rolle

Steward ist der Finance/Housing/Jobcenter-read-only-Agent.

## Ergebnis

Ein sicheres Finance/Housing/Jobcenter-Lagebild wurde erzeugt.

## Output

Read-only Report:
$FH_REPORT

Latest:
$FH_LATEST

## Sicherheitsbewertung

- Kein sudo.
- Keine Systemänderung.
- Keine Secrets gelesen.
- Keine Löschung.
- Keine Zahlung ausgeführt.
- Keine E-Mail gesendet.
- Keine Jobcenter-Kommunikation versendet.
- Keine Finanzdetails an Discord gesendet.
- Nur Struktur, Risikoanalyse und Entwurf erstellt.

## Nächste Nutzung

Befehl:
steward-run

Empfohlene Routine:
1. Falllage nennen
2. Nachweise sortieren
3. Risiken markieren
4. Entwurf erstellen lassen
5. manuell prüfen
6. erst dann versenden
MD

cp "$OUT" "$LATEST"
cp "$OUT" "$STATUS_LATEST"

cat >> "$MEMORY_DIR/daily_summaries.md" << MD

## $TODAY – Steward Summary – $TS

Steward wurde als fünfter echter Agent produktiv aktiviert. Er erzeugt Finance-/Housing-/Jobcenter-read-only-Lagebilder ohne Zahlungen, ohne Versand und ohne verbindliche Rechtsentscheidung.

Aktive Agenten:
- CrashBandicot: Control
- Winky: System Monitor
- Mnemosyne: Memory Curator
- Mentor: IHK/MFP Drill
- Strategist: Career/CV/Recruiter
- Steward: Finance/Housing/Jobcenter read-only

Pfad:
$LATEST
MD

cat >> "$MEMORY_DIR/decisions.md" << MD

## $TODAY – Entscheidung: Steward aktivieren

Entscheidung:
Steward wird als fünfter echter Agent produktiv gemacht.

Begründung:
Finance/Housing/Jobcenter benötigt hohe Ordnung und Nachweissicherheit, darf aber keine automatische Kommunikation oder Zahlung ausführen.

Grenzen:
Read-only, keine Zahlungen, keine Rechtsentscheidung, kein Versand, keine sensiblen Daten an Discord.

Kontrolle:
steward-run, latest_steward_report.md, latest_steward_finance_housing_readonly.md.
MD

cat "$OUT"

if [ -x "$BASE/scripts/discord_send_channel.sh" ]; then
  "$BASE/scripts/discord_send_channel.sh" DISCORD_FINANCE_CONTROL_WEBHOOK_URL "🏠 Steward Report erstellt: $FH_LATEST" || true
  "$BASE/scripts/discord_send_channel.sh" DISCORD_HOUSING_JOBCENTER_WEBHOOK_URL "🏠 Steward aktiv: Finance/Housing/Jobcenter read-only Lagebild erstellt." || true
  "$BASE/scripts/discord_send_channel.sh" DISCORD_AGENT_LOGS_WEBHOOK_URL "🏠 Steward aktiv: keine Zahlung, kein Versand, keine sensiblen Details." || true
fi

echo
echo "============================================================"
echo "STEWARD FERTIG"
echo "============================================================"
echo "Report:"
echo "$LATEST"
echo "Finance/Housing:"
echo "$FH_LATEST"
echo "Log:"
echo "$LOG"
