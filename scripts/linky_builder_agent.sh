#!/usr/bin/env bash
set -Eeuo pipefail

TS="$(date +%Y%m%d_%H%M%S)"
TODAY="$(date +%F)"

BASE="$HOME/openclaw_training"
MISSION="$BASE/mission_control"
RUNTIME_DIR="$MISSION/agent_runtime"
LINKY_DIR="$RUNTIME_DIR/linky"
LOG_DIR="$RUNTIME_DIR/logs"
PROMPT_CODE_DIR="$MISSION/prompt_to_code"
MEMORY_DIR="$MISSION/memory_wiki"
STATUS_DIR="$BASE/docs/status"
REPORT_DIR="$BASE/reports"

OUT="$LINKY_DIR/linky_builder_report_${TS}.md"
LATEST="$LINKY_DIR/latest_linky_report.md"
MODULE="$PROMPT_CODE_DIR/linky_module_${TODAY}_${TS}.md"
MODULE_LATEST="$PROMPT_CODE_DIR/latest_linky_module.md"
STATUS_LATEST="$STATUS_DIR/latest_linky_agent_status.md"
LOG="$LOG_DIR/linky_run_${TS}.txt"

mkdir -p "$LINKY_DIR" "$LOG_DIR" "$PROMPT_CODE_DIR" "$MEMORY_DIR" "$STATUS_DIR" "$REPORT_DIR"

exec > >(tee -a "$LOG") 2>&1

cat > "$MODULE" << MD
# Linky Prompt-to-Code Module – ${TODAY}

Stand: $(date)

## 1 Modulname

Shadowmaker Safe Command Wrapper Pattern

## 2 Zweck

Dieses Modul definiert einen wiederverwendbaren Standard für sichere All-in-one-Skripte im Shadowmaker-System. Ziel ist, wiederkehrende Aufgaben kontrolliert, dokumentiert und rollbackfähig auszuführen.

## 3 Risiko

Niedrig, weil dieses Modul nur eine Vorlage und keine produktive Systemänderung ausführt.

## 4 Safe Pattern

Jedes neue Skript soll diese Regeln einhalten:

\`\`\`bash
#!/usr/bin/env bash
set -Eeuo pipefail

TS="\$(date +%Y%m%d_%H%M%S)"
BASE="\$HOME/openclaw_training"
REPORT_DIR="\$BASE/reports"
STATUS_DIR="\$BASE/docs/status"
REPORT="\$REPORT_DIR/example_\$TS.txt"

mkdir -p "\$REPORT_DIR" "\$STATUS_DIR"

exec > >(tee -a "\$REPORT") 2>&1

echo "Start: \$(date)"
echo "Report: \$REPORT"

# 1. prüfen
# 2. Backup erstellen
# 3. Änderung isoliert durchführen
# 4. Syntax/Test prüfen
# 5. Status schreiben
# 6. optional Git commit
# 7. Freeze/Timeshift nur als manuelle Folge
\`\`\`

## 5 Testbefehl

\`\`\`bash
bash -n <script>
\`\`\`

## 6 Rollback

Vor jeder Änderung:
- Datei mit Timestamp sichern
- Symlink erst nach erfolgreichem Syntaxcheck setzen
- produktive Timer nicht automatisch aktivieren
- bei Fehler: Backup zurückkopieren

## 7 Keine automatische Aktivierung

Dieses Modul aktiviert keine Dienste, keine Timer und keine externen Aktionen.

## 8 Nächste sinnvolle Linky-Aufgaben

1. Bashrc-Alias-Guard verbessern
2. Next.js Workspace-Root-Warnung sauber dokumentieren
3. ShadowOps failed services nur analysieren, nicht reparieren
4. Prompt-to-Code Registry erzeugen
5. kleine Modulvorlagen für Mentor/Strategist/Steward bauen

## 9 Kontrollsatz

Linky baut nur kleine, prüfbare Module. Keine Systemänderung ohne separate Freigabe.
MD

cp "$MODULE" "$MODULE_LATEST"

cat > "$OUT" << MD
# Linky Builder Agent Report

Stand: $(date)

## Rolle

Linky ist der Builder-/Prompt-to-Code-Agent.

## Ergebnis

Ein sicheres Prompt-to-Code-Modul wurde erzeugt.

## Output

Module:
$MODULE

Latest:
$MODULE_LATEST

## Sicherheitsbewertung

- Kein sudo.
- Keine Systemänderung.
- Keine Secrets gelesen.
- Keine Löschung.
- Kein Timer aktiviert.
- Kein Dienst gestartet.
- Kein Docker/Compose geändert.
- Nur Vorlage/Modul erzeugt.
- Discord nur für Status genutzt.

## Nächste Nutzung

Befehl:
linky-run

Empfohlene Routine:
1. wiederkehrenden Prompt oder Ablauf nennen
2. Linky erzeugt Mini-Modul
3. Syntax/Test prüfen
4. manuell entscheiden
5. erst dann produktiv übernehmen
MD

cp "$OUT" "$LATEST"
cp "$OUT" "$STATUS_LATEST"

cat >> "$MEMORY_DIR/daily_summaries.md" << MD

## ${TODAY} – Linky Summary – ${TS}

Linky wurde als sechster echter Agent produktiv aktiviert. Er erzeugt kleine, sichere Prompt-to-Code-Module ohne sudo, ohne Löschung, ohne Fundamentänderung und ohne automatische Aktivierung produktiver Dienste.

Aktive Agenten:
- CrashBandicot: Control
- Winky: System Monitor
- Mnemosyne: Memory Curator
- Mentor: IHK/MFP Drill
- Strategist: Career/CV/Recruiter
- Steward: Finance/Housing/Jobcenter read-only
- Linky: Builder/Prompt-to-Code

Pfad:
$LATEST
MD

cat >> "$MEMORY_DIR/decisions.md" << MD

## ${TODAY} – Entscheidung: Linky aktivieren

Entscheidung:
Linky wird als sechster echter Agent produktiv gemacht.

Begründung:
Prompt-to-Code erzeugt hohen Nutzen, solange Linky nur kleine, prüfbare, nicht-destruktive Module erstellt und keine produktiven Dienste automatisch verändert.

Grenzen:
Kein sudo, keine Löschung, keine Fundamentänderung, keine automatische Aktivierung.

Kontrolle:
linky-run, latest_linky_report.md, latest_linky_module.md.
MD

cat "$OUT"

if [ -x "$BASE/scripts/discord_send_channel.sh" ]; then
  "$BASE/scripts/discord_send_channel.sh" DISCORD_OPENCLAW_PROJECTS_WEBHOOK_URL "🛠️ Linky Modul erstellt: $MODULE_LATEST" || true
  "$BASE/scripts/discord_send_channel.sh" DISCORD_AGENT_LOGS_WEBHOOK_URL "🛠️ Linky aktiv: Builder/Prompt-to-Code-Agent hat sicheres Mini-Modul erzeugt." || true
fi

echo
echo "============================================================"
echo "LINKY FERTIG"
echo "============================================================"
echo "Report:"
echo "$LATEST"
echo "Module:"
echo "$MODULE_LATEST"
echo "Log:"
echo "$LOG"
