#!/usr/bin/env bash
set -Eeuo pipefail

TS="$(date +%Y%m%d_%H%M%S)"
BASE="$HOME/openclaw_training"
MISSION="$BASE/mission_control"
AUDIT_DIR="$MISSION/workspace_audit"
REPORT_DIR="$BASE/reports"
STATUS_DIR="$BASE/docs/status"
OPENCLAW_ROOT="$HOME/.openclaw"
OPENCLAW_WS="$HOME/.openclaw/workspace"

OUT="$AUDIT_DIR/workspace_audit_$TS.md"
LATEST="$AUDIT_DIR/latest_workspace_audit.md"
STATUS_LATEST="$STATUS_DIR/latest_workspace_audit.md"
REPORT="$REPORT_DIR/openclaw_workspace_audit_readonly_$TS.txt"

mkdir -p "$AUDIT_DIR" "$REPORT_DIR" "$STATUS_DIR"

exec > >(tee -a "$REPORT") 2>&1

exists_status() {
  local p="$1"
  if [ -e "$p" ]; then
    echo "YES"
  else
    echo "NO"
  fi
}

safe_find_md() {
  local p="$1"
  if [ -d "$p" ]; then
    find "$p" -maxdepth 4 -type f \( -iname '*.md' -o -iname '*.txt' -o -iname '*.json' \) \
      ! -iname '.env' \
      ! -iname '*token*' \
      ! -iname '*secret*' \
      ! -iname '*key*' \
      -printf '%TY-%Tm-%Td %TH:%TM\t%p\n' 2>/dev/null | sort -r | head -200
  fi
}

safe_tree_dirs() {
  local p="$1"
  if [ -d "$p" ]; then
    find "$p" -maxdepth 3 -type d 2>/dev/null | sort | head -200
  fi
}

OPENCLAW_ROOT_EXISTS="$(exists_status "$OPENCLAW_ROOT")"
OPENCLAW_WS_EXISTS="$(exists_status "$OPENCLAW_WS")"

{
  echo "# OpenClaw Workspace Audit Read-Only"
  echo
  echo "Stand: $(date)"
  echo
  echo "## Ergebnis"
  echo
  echo '```text'
  echo "OpenClaw root: $OPENCLAW_ROOT"
  echo "OpenClaw root exists: $OPENCLAW_ROOT_EXISTS"
  echo "OpenClaw workspace: $OPENCLAW_WS"
  echo "OpenClaw workspace exists: $OPENCLAW_WS_EXISTS"
  echo "Mission Control: $MISSION"
  echo "Report: $REPORT"
  echo '```'
  echo
  echo "## OpenClaw Root Directories"
  echo
  echo '```text'
  safe_tree_dirs "$OPENCLAW_ROOT"
  echo '```'
  echo
  echo "## OpenClaw Workspace Candidate Files"
  echo
  echo '```text'
  safe_find_md "$OPENCLAW_WS"
  echo '```'
  echo
  echo "## Mission Control Directories"
  echo
  echo '```text'
  safe_tree_dirs "$MISSION"
  echo '```'
  echo
  echo "## Mission Control Candidate Files"
  echo
  echo '```text'
  safe_find_md "$MISSION"
  echo '```'
  echo
  echo "## Status Documents"
  echo
  echo '```text'
  safe_find_md "$BASE/docs/status"
  echo '```'
  echo
  echo "## Bewertung"
  echo
  echo "- Audit ist read-only."
  echo "- Secrets werden durch Namensfilter ausgeschlossen."
  echo "- Web-UI darf diese Daten lesen, aber nicht verändern."
  echo "- Falls ~/.openclaw/workspace fehlt, nutzt Web-UI zunächst mission_control als reale Datenquelle."
} > "$OUT"

cp "$OUT" "$LATEST"
cp "$OUT" "$STATUS_LATEST"

cat "$OUT"

if [ -x "$BASE/scripts/discord_send_channel.sh" ]; then
  "$BASE/scripts/discord_send_channel.sh" DISCORD_MISSION_CONTROL_WEBHOOK_URL "Phase 4 Workspace Audit erstellt: $LATEST" || true
fi

echo
echo "============================================================"
echo "FERTIG"
echo "============================================================"
echo "Latest:"
echo "$LATEST"
echo "Report:"
echo "$REPORT"
