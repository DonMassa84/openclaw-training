#!/usr/bin/env bash
set -Eeuo pipefail

BASE="$HOME/openclaw_training"
MISSION="$BASE/mission_control"

echo "============================================================"
echo " MISSION CONTROL PHASE 2 STATUS"
echo "============================================================"
echo "Zeit: $(date)"
echo

echo "== Tasks =="
cat "$MISSION/tasks/latest_tasks_master.md" 2>/dev/null | head -80 || true
echo

echo "== Agents =="
cat "$MISSION/agents/latest_agent_roles.md" 2>/dev/null | head -80 || true
echo

echo "== Daily Delight Latest =="
cat "$MISSION/daily_delight/latest_daily_delight.md" 2>/dev/null || echo "Noch kein Daily Delight erzeugt."
echo

echo "== Memory Wiki =="
find "$MISSION/memory_wiki" -maxdepth 1 -type f -printf '%f\n' 2>/dev/null | sort || true
echo

echo "== Security Timer =="
systemctl --user list-timers --all --no-pager 2>/dev/null | grep -E 'shadowmaker-security-audit|NEXT|LEFT' || true
