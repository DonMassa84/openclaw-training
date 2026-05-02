#!/usr/bin/env bash
set -Eeuo pipefail

BASE="$HOME/openclaw_training"
MISSION="$BASE/mission_control"

echo "============================================================"
echo " PHASE 5 CREW STATUS"
echo "============================================================"
echo "Zeit: $(date)"
echo

echo "== Agent Registry =="
cat "$MISSION/agents/latest_agent_registry.md" 2>/dev/null || echo "Keine Agent Registry gefunden."
echo

echo "== Winky Latest =="
cat "$MISSION/agent_runtime/winky/latest_winky_report.md" 2>/dev/null || echo "Kein Winky Report gefunden."
echo

echo "== Mnemosyne Latest =="
cat "$MISSION/agent_runtime/mnemosyne/latest_mnemosyne_report.md" 2>/dev/null || echo "Kein Mnemosyne Report gefunden."
echo

echo "== Mentor Latest =="
cat "$MISSION/agent_runtime/mentor/latest_mentor_report.md" 2>/dev/null || echo "Kein Mentor Report gefunden."
echo

echo "== Strategist Latest =="
cat "$MISSION/agent_runtime/strategist/latest_strategist_report.md" 2>/dev/null || echo "Kein Strategist Report gefunden."
echo

echo "== Steward Latest =="
cat "$MISSION/agent_runtime/steward/latest_steward_report.md" 2>/dev/null || echo "Kein Steward Report gefunden."
echo

echo "== Linky Latest =="
cat "$MISSION/agent_runtime/linky/latest_linky_report.md" 2>/dev/null || echo "Kein Linky Report gefunden."
echo

echo "== Runtime Files =="
find "$MISSION/agent_runtime" -maxdepth 3 -type f 2>/dev/null | sort | tail -320 || true
