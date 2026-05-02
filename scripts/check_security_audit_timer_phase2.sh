#!/usr/bin/env bash
set -Eeuo pipefail

BASE="$HOME/openclaw_training"
STATUS_DIR="$BASE/docs/status"
REPORT_DIR="$BASE/reports"
TS="$(date +%Y%m%d_%H%M%S)"
REPORT="$REPORT_DIR/check_security_audit_timer_phase2_$TS.txt"
OUT="$STATUS_DIR/security_audit_timer_check_$TS.md"
LATEST="$STATUS_DIR/latest_security_audit_timer_check.md"

mkdir -p "$STATUS_DIR" "$REPORT_DIR"

exec > >(tee -a "$REPORT") 2>&1

SERVICE="shadowmaker-security-audit-discord.service"
TIMER="shadowmaker-security-audit-discord.timer"

SERVICE_ACTIVE="$(systemctl --user is-active "$SERVICE" 2>/dev/null || true)"
TIMER_ACTIVE="$(systemctl --user is-active "$TIMER" 2>/dev/null || true)"
TIMER_ENABLED="$(systemctl --user is-enabled "$TIMER" 2>/dev/null || true)"
LIST_TIMERS="$(systemctl --user list-timers --all --no-pager 2>/dev/null | grep -E 'shadowmaker-security-audit|NEXT|LEFT' || true)"
SERVICE_STATUS="$(systemctl --user status "$SERVICE" --no-pager 2>&1 || true)"
TIMER_STATUS="$(systemctl --user status "$TIMER" --no-pager 2>&1 || true)"

{
  echo "# Security Audit Timer Check"
  echo
  echo "Stand: $(date)"
  echo
  echo "## Ergebnis"
  echo
  echo "Service: $SERVICE"
  echo "Service active: $SERVICE_ACTIVE"
  echo "Timer: $TIMER"
  echo "Timer active: $TIMER_ACTIVE"
  echo "Timer enabled: $TIMER_ENABLED"
  echo
  echo "## Timer-Liste"
  echo
  echo "$LIST_TIMERS"
  echo
  echo "## Service Detail"
  echo
  echo "$SERVICE_STATUS"
  echo
  echo "## Timer Detail"
  echo
  echo "$TIMER_STATUS"
  echo
  echo "## Bewertung"
  echo
  if [ "$TIMER_ACTIVE" = "active" ] && [ "$TIMER_ENABLED" = "enabled" ]; then
    echo "OK - Security Audit Timer ist aktiv und enabled."
  else
    echo "WARN - Security Audit Timer ist nicht vollständig aktiv/enabled."
    echo "Reparaturbefehl:"
    echo "systemctl --user enable --now shadowmaker-security-audit-discord.timer"
  fi
  echo
  echo "Hinweis: Der Service darf inactive sein, weil Type=oneshot."
} > "$OUT"

cp "$OUT" "$LATEST"

cat "$OUT"

echo
echo "[OK] Timer Check gespeichert:"
echo "$LATEST"
