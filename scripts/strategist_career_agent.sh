#!/usr/bin/env bash
set -Eeuo pipefail

TS="$(date +%Y%m%d_%H%M%S)"
TODAY="$(date +%F)"

BASE="$HOME/openclaw_training"
MISSION="$BASE/mission_control"
RUNTIME_DIR="$MISSION/agent_runtime"
STRATEGIST_DIR="$RUNTIME_DIR/strategist"
LOG_DIR="$RUNTIME_DIR/logs"
CAREER_DIR="$MISSION/career_it"
MEMORY_DIR="$MISSION/memory_wiki"
STATUS_DIR="$BASE/docs/status"
REPORT_DIR="$BASE/reports"

OUT="$STRATEGIST_DIR/strategist_career_report_$TS.md"
LATEST="$STRATEGIST_DIR/latest_strategist_report.md"
CAREER_TEMPLATE="$CAREER_DIR/strategist_career_template_${TODAY}_${TS}.md"
CAREER_LATEST="$CAREER_DIR/latest_strategist_career_template.md"
STATUS_LATEST="$STATUS_DIR/latest_strategist_agent_status.md"
LOG="$LOG_DIR/strategist_run_$TS.txt"

mkdir -p "$STRATEGIST_DIR" "$LOG_DIR" "$CAREER_DIR" "$MEMORY_DIR" "$STATUS_DIR" "$REPORT_DIR"

exec > >(tee -a "$LOG") 2>&1

cat > "$CAREER_TEMPLATE" << MD
# Strategist Career/CV Template – $TODAY

Stand: $(date)

## Zweck

Dieses Artefakt dient als sichere Standardbasis für Bewerbungen, Recruiter-Kommunikation und Stellen-Fit-Analysen im IT-Umfeld.

## 1 Zielrolle

Bevorzugte Zielrollen:
- IT Support / Service Desk
- IT Operations
- Systemadministration
- Endpoint / Workplace IT
- ITSM / Service Management
- AI Automation / RAG / Agentic Workflow-nahe Rollen, sofern realistisch anschlussfähig

## 2 Fit-Analyse Raster

| Bereich | Prüffrage | Bewertung |
|---|---|---|
| Aufgabenfit | Decken die Aufgaben Support, Betrieb, ITSM, Automatisierung oder Infrastruktur ab? | hoch/mittel/niedrig |
| Skill-Fit | Passen Python, Linux, Docker, Active Directory, ITSM, Monitoring, RAG/AI-Automation? | hoch/mittel/niedrig |
| Erfahrungsfit | Ist die Rolle Junior/Mid-Level erreichbar oder verlangt sie Senior-Tiefe? | hoch/mittel/niedrig |
| Standortfit | Stuttgart/Remote/Hybrid realistisch? | ja/nein |
| Gehaltsfit | Zielkorridor realistisch? | ja/nein |
| Risiko | Welche Lücke muss im Anschreiben kontrolliert werden? | Text |

## 3 Stärkenprofil

Kernstärken:
- praxisnahe IT-Erfahrung in Support, Infrastruktur und Systembetrieb
- technische Lernfähigkeit und Automatisierungsdenken
- Python-, Linux-, Docker- und RAG-/LLM-Projektpraxis
- strukturierte Fehleranalyse und Dokumentation
- hohe Eigeninitiative bei lokalen AI-/Automation-Stacks
- Kommunikationsfähigkeit im Umgang mit internen Stakeholdern

## 4 Risikokontrolle

Nicht überziehen:
- keine Senior-Claims ohne Nachweis
- keine Enterprise-Projekterfahrung behaupten, wenn nicht vorhanden
- keine Zertifizierungen nennen, die nicht abgeschlossen sind
- AI-Projekte als Praxis-/Portfolio-Projekte darstellen, nicht als langjährige Berufserfahrung

## 5 ATS-CV-Baustein

Profil:
IT-orientierter Bewerber mit Praxis in Support, Systembetrieb, Automatisierung und lokaler KI-Infrastruktur. Erfahrung mit Linux, Docker, Python, Monitoring, Ticketprozessen und strukturiertem Troubleshooting. Ergänzend Aufbau eigener RAG-/LLM- und Agenten-Workflows zur Prozessanalyse, Dokumentation und Automatisierung.

Technische Schwerpunkte:
Linux, Windows, Docker, Python, Git, Active Directory-Grundlagen, Monitoring, ITSM/Ticketprozesse, RAG, lokale LLMs, n8n, Flowise, Open WebUI, OpenClaw, Automatisierung.

## 6 Anschreiben-Modul

Sehr geehrte Damen und Herren,

die ausgeschriebene Position spricht mich an, weil sie technische Problemlösung, strukturierten IT-Betrieb und serviceorientierte Zusammenarbeit verbindet. Ich bringe praktische Erfahrung im IT-Umfeld mit und habe zusätzlich eigene Automatisierungs- und KI-Workflows aufgebaut, um wiederkehrende Aufgaben systematisch zu analysieren, zu dokumentieren und effizienter umzusetzen.

Besonders relevant für die Position sind meine Kenntnisse in Linux, Docker, Python, Ticketprozessen, Monitoring und technischer Fehleranalyse. Ich arbeite strukturiert, dokumentiere sauber und kann technische Themen verständlich gegenüber unterschiedlichen Ansprechpartnern kommunizieren.

Gerne erläutere ich Ihnen in einem Gespräch, wie ich meine IT-Praxis, meine Lernbereitschaft und mein Automatisierungsverständnis gewinnbringend in Ihr Team einbringen kann.

Mit freundlichen Grüßen
Daniel Massa

## 7 Recruiter-Antwort

Hallo Frau/Herr [Name],

vielen Dank für Ihre Nachricht und die interessante Position. Die Rolle passt grundsätzlich gut zu meinem Profil, insbesondere wenn der Schwerpunkt auf IT-Betrieb, Support, Systemadministration, ITSM oder technischer Prozessverbesserung liegt.

Ich bringe praktische IT-Erfahrung sowie Kenntnisse in Linux, Docker, Python, Ticketprozessen und Automatisierung mit. Zusätzlich habe ich eigene lokale KI-/RAG- und Agenten-Workflows aufgebaut, um technische Abläufe zu strukturieren und effizienter zu machen.

Gerne können wir die Anforderungen und Rahmenbedingungen in einem kurzen Gespräch abgleichen.

Viele Grüße
Daniel Massa

## 8 Interview-Kernsatz

Ich verbinde solide IT-Praxis mit strukturiertem Automatisierungsdenken: Ich analysiere wiederkehrende technische Abläufe, dokumentiere sie sauber und entwickle daraus belastbare, einfache Lösungen für Support, Betrieb und Prozessverbesserung.

## 9 Nächste Aktion

Bei neuer Stellenanzeige:
1. Anzeige speichern
2. Fit nach Raster bewerten
3. CV-Bausteine anpassen
4. Anschreiben auf Aufgaben spiegeln
5. Recruiter-Nachricht kurz und kontrolliert formulieren
6. Keine Skills erfinden
MD

cp "$CAREER_TEMPLATE" "$CAREER_LATEST"

cat > "$OUT" << MD
# Strategist Agent Report

Stand: $(date)

## Rolle

Strategist ist der Career-/CV-/Recruiter-Kommunikations-Agent.

## Ergebnis

Ein sicheres Career/CV-Grundartefakt wurde erzeugt.

## Output

Career Template:
$CAREER_TEMPLATE

Latest:
$CAREER_LATEST

## Sicherheitsbewertung

- Kein sudo.
- Keine Systemänderung.
- Keine Secrets gelesen.
- Keine Löschung.
- Keine Bewerbung versendet.
- Keine E-Mail gesendet.
- Nur Entwürfe und Analysebausteine erstellt.
- Discord nur für Status genutzt.

## Nächste Nutzung

Befehl:
strategist-run

Empfohlene Routine bei Stellenanzeige:
1. Stellenanzeige einfügen
2. Fit-Analyse erstellen
3. ATS-CV-Bausteine anpassen
4. Anschreiben-Modul generieren
5. Recruiter-Nachricht erstellen
6. Vor Versand manuell prüfen
MD

cp "$OUT" "$LATEST"
cp "$OUT" "$STATUS_LATEST"

cat >> "$MEMORY_DIR/daily_summaries.md" << MD

## $TODAY – Strategist Summary – $TS

Strategist wurde als vierter echter Agent produktiv aktiviert. Er erzeugt Career-/CV-/Recruiter-Artefakte ohne Versandautomatik.

Aktive Agenten:
- CrashBandicot: Control
- Winky: System Monitor
- Mnemosyne: Memory Curator
- Mentor: IHK/MFP Drill
- Strategist: Career/CV/Recruiter-Kommunikation

Pfad:
$LATEST
MD

cat >> "$MEMORY_DIR/decisions.md" << MD

## $TODAY – Entscheidung: Strategist aktivieren

Entscheidung:
Strategist wird als vierter echter Agent produktiv gemacht.

Begründung:
Career-/CV-/Recruiter-Kommunikation erzeugt hohen beruflichen Nutzen und bleibt sicher, solange nur Entwürfe erstellt und keine Nachrichten automatisch versendet werden.

Grenzen:
Nur Analyse und Textentwürfe. Kein Versand, keine Portalbedienung, keine falschen Skills.

Kontrolle:
strategist-run, latest_strategist_report.md, latest_strategist_career_template.md.
MD

cat "$OUT"

if [ -x "$BASE/scripts/discord_send_channel.sh" ]; then
  "$BASE/scripts/discord_send_channel.sh" DISCORD_CAREER_IT_WEBHOOK_URL "💼 Strategist Career Template erstellt: $CAREER_LATEST" || true
  "$BASE/scripts/discord_send_channel.sh" DISCORD_AGENT_LOGS_WEBHOOK_URL "💼 Strategist aktiv: Career/CV/Recruiter-Agent hat Grundartefakt erzeugt." || true
fi

echo
echo "============================================================"
echo "STRATEGIST FERTIG"
echo "============================================================"
echo "Report:"
echo "$LATEST"
echo "Career Template:"
echo "$CAREER_LATEST"
echo "Log:"
echo "$LOG"
