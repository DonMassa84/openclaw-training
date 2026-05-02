#!/usr/bin/env bash
set -Eeuo pipefail

TS="$(date +%Y%m%d_%H%M%S)"
TODAY="$(date +%F)"

BASE="$HOME/openclaw_training"
MISSION="$BASE/mission_control"
RUNTIME_DIR="$MISSION/agent_runtime"
MNEMO_DIR="$RUNTIME_DIR/mnemosyne"
LOG_DIR="$RUNTIME_DIR/logs"
MEMORY_DIR="$MISSION/memory_wiki"
STATUS_DIR="$BASE/docs/status"
REPORT_DIR="$BASE/reports"
DAILY_DIR="$MISSION/daily_logs"
BRIEF_DIR="$MISSION/daily_briefs"
DELIGHT_DIR="$MISSION/daily_delight"
WINKY_DIR="$RUNTIME_DIR/winky"
TASK_DIR="$MISSION/tasks"

OUT="$MNEMO_DIR/mnemosyne_report_$TS.md"
LATEST="$MNEMO_DIR/latest_mnemosyne_report.md"
STATUS_LATEST="$STATUS_DIR/latest_mnemosyne_agent_status.md"
LOG="$LOG_DIR/mnemosyne_run_$TS.txt"

mkdir -p "$MNEMO_DIR" "$LOG_DIR" "$MEMORY_DIR" "$STATUS_DIR" "$REPORT_DIR"

exec > >(tee -a "$LOG") 2>&1

safe_latest_file() {
  local dir="$1"
  if [ -d "$dir" ]; then
    find "$dir" -maxdepth 2 -type f \( -iname '*.md' -o -iname '*.txt' \) \
      ! -iname '.env' \
      ! -iname '*token*' \
      ! -iname '*secret*' \
      ! -iname '*key*' \
      -printf '%T@ %p\n' 2>/dev/null | sort -nr | head -1 | cut -d' ' -f2-
  fi
}

safe_read_head() {
  local file="$1"
  local max="${2:-160}"
  if [ -n "${file:-}" ] && [ -f "$file" ]; then
    local lower
    lower="$(basename "$file" | tr '[:upper:]' '[:lower:]')"
    case "$lower" in
      *.env|*token*|*secret*|*key*|*credential*)
        echo "[redacted: sensitive filename]"
        ;;
      *)
        sed -n "1,${max}p" "$file" 2>/dev/null || true
        ;;
    esac
  else
    echo "Keine Datei gefunden."
  fi
}

LAST_DAILY_BRIEF="$(safe_latest_file "$BRIEF_DIR")"
LAST_DAILY_DELIGHT="$(safe_latest_file "$DELIGHT_DIR")"
LAST_WINKY="$(safe_latest_file "$WINKY_DIR")"
LAST_PHASE5="$(safe_latest_file "$STATUS_DIR")"
TASKS_FILE="$TASK_DIR/latest_tasks_master.md"

SUMMARY="$MNEMO_DIR/memory_summary_${TODAY}_${TS}.md"

{
  echo "# Mnemosyne Memory Curator Report"
  echo
  echo "Stand: $(date)"
  echo
  echo "## Rolle"
  echo
  echo "Mnemosyne konsolidiert Systemzustand, Entscheidungen, offene Punkte und nutzbare Befehle in das Memory Wiki."
  echo
  echo "## Quellen"
  echo
  echo "- Daily Brief: ${LAST_DAILY_BRIEF:-none}"
  echo "- Daily Delight: ${LAST_DAILY_DELIGHT:-none}"
  echo "- Winky Report: ${LAST_WINKY:-none}"
  echo "- Status: ${LAST_PHASE5:-none}"
  echo "- Tasks: ${TASKS_FILE:-none}"
  echo
  echo "## Konsolidierte Lage"
  echo
  echo "- Mission Control WebUI läuft lokal auf 127.0.0.1:4173, sofern der Next.js-Prozess aktiv ist."
  echo "- Winky ist als erster echter Agent produktiv und liefert Systemberichte."
  echo "- Mnemosyne wurde als zweiter echter Agent aktiviert und pflegt Memory-Wiki-Struktur."
  echo "- Discord Routing ist aktiv."
  echo "- Freeze/Timeshift bleiben Pflicht nach stabilen Änderungen."
  echo
  echo "## Offene Punkte"
  echo
  echo "- OpenClaw Host HTTP bleibt Warnpunkt, intern/containerseitig war es zuvor funktionsfähig."
  echo "- shadowops-autopilot.timer und shadowops-log-push.timer wurden deaktiviert, weil SHADOWOPS_PASSPHRASE fehlte."
  echo "- casper-md5check.service bleibt unkritisch, sofern Live-ISO-Reststatus."
  echo "- Next.js Workspace-Root-Warnung kann später optional bereinigt werden."
  echo
  echo "## Entscheidungen"
  echo
  echo "- Multi-Agent Crew wird schrittweise aktiviert."
  echo "- Winky bleibt read-only Monitor."
  echo "- Mnemosyne darf Memory-Wiki schreiben, aber keine Secrets lesen."
  echo "- Weitere Agenten werden erst nach stabiler Beobachtung aktiviert."
  echo
  echo "## Sicherheitsbewertung"
  echo
  echo "- Kein sudo."
  echo "- Keine Löschung."
  echo "- Keine Secrets gelesen."
  echo "- Keine externen Inhalte im Klartext versendet."
  echo "- Kein Fundament verändert."
  echo
  echo "## Relevante Befehle"
  echo
  echo "- winky-run"
  echo "- mnemosyne-run"
  echo "- phase5-crew-status"
  echo "- mission-control-webui-start"
  echo "- deep-security-check"
  echo "- /freeze_report"
} > "$SUMMARY"

cp "$SUMMARY" "$OUT"
cp "$OUT" "$LATEST"
cp "$OUT" "$STATUS_LATEST"

cat >> "$MEMORY_DIR/daily_summaries.md" << MD

## $TODAY – Mnemosyne Summary – $TS

Winky ist als erster echter Agent produktiv. Mnemosyne wurde als zweiter echter Agent aktiviert und konsolidiert Memory-Wiki, Entscheidungen, offene Punkte und Systemstatus.

Aktive Agenten:
- CrashBandicot: Telegram Control
- Winky: System Monitor
- Mnemosyne: Memory Curator

Wichtige stabile Module:
- Mission Control Phase 2
- Phase 3 Module
- Phase 4 WebUI
- Phase 5 Winky
- Phase 5 Mnemosyne

Offene Punkte:
- OpenClaw Host HTTP Warnung beobachten
- shadowops-autopilot.service separat entscheiden
- shadowops-log-push.service separat entscheiden
- casper-md5check.service unkritisch belassen oder später reset-failed

Pfad:
$LATEST
MD

cat >> "$MEMORY_DIR/decisions.md" << MD

## $TODAY – Entscheidung: Mnemosyne aktivieren

Entscheidung:
Mnemosyne wird als zweiter echter Agent produktiv gemacht.

Begründung:
Memory-Konsolidierung ist risikoarm, erzeugt direkte Wiederverwendbarkeit und stabilisiert die Multi-Agent-Crew ohne destruktive Rechte.

Grenzen:
Keine Secrets, kein sudo, keine Löschung, keine externen Klartextdaten.

Kontrolle:
mnemosyne-run, latest_mnemosyne_report.md, Discord-Agent-Log.
MD

cat >> "$MEMORY_DIR/systems.md" << MD

## $TODAY – Multi-Agent Runtime

Aktive Runtime-Agenten:
- Winky: $WINKY_DIR/latest_winky_report.md
- Mnemosyne: $LATEST

Status:
Schrittweise Aktivierung, read-only bzw. kontrolliertes Memory-Wiki-Schreiben.
MD

cat >> "$MEMORY_DIR/risks.md" << MD

## $TODAY – Risiken nach Mnemosyne-Aktivierung

1. Memory-Wiki kann redundant wachsen.
   Kontrolle: regelmäßige Konsolidierung statt Löschung.

2. OpenClaw Host HTTP Warnung bleibt bestehen.
   Kontrolle: Winky beobachtet weiter, keine voreilige Binding-Änderung.

3. ShadowOps failed services bleiben offen.
   Kontrolle: separat reparieren oder deaktivieren, nicht automatisch.
MD

cat "$OUT"

if [ -x "$BASE/scripts/discord_send_channel.sh" ]; then
  "$BASE/scripts/discord_send_channel.sh" DISCORD_MEMORY_WIKI_WEBHOOK_URL "🧠 Mnemosyne Report erstellt: $LATEST" || true
  "$BASE/scripts/discord_send_channel.sh" DISCORD_AGENT_LOGS_WEBHOOK_URL "🧠 Mnemosyne aktiv: Memory Curator hat Daily Summary, Decisions, Systems und Risks aktualisiert." || true
fi

echo
echo "============================================================"
echo "MNEMOSYNE FERTIG"
echo "============================================================"
echo "Report:"
echo "$LATEST"
echo "Log:"
echo "$LOG"
