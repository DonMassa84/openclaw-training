#!/usr/bin/env bash
set -Eeuo pipefail

TS="$(date +%Y%m%d_%H%M%S)"
BASE="$HOME/openclaw_training"
REPORT_DIR="$BASE/reports"
LOG="$REPORT_DIR/security_audit_discord_timer_$TS.txt"

mkdir -p "$REPORT_DIR"

exec > >(tee -a "$LOG") 2>&1

echo "============================================================"
echo " SHADOWMAKER SECURITY AUDIT DISCORD TIMER RUN"
echo "============================================================"
echo "Zeit: $(date)"
echo "Log: $LOG"
echo

"$BASE/scripts/security_audit_to_discord.sh"

echo
echo "============================================================"
echo "FERTIG"
echo "============================================================"
