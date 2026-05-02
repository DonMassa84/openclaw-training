#!/usr/bin/env bash
set -Eeuo pipefail

SERVICE_DIR="$HOME/.config/systemd/user"
BASE="$HOME/openclaw_training"
SCRIPT="$BASE/scripts/steward_finance_housing_agent.sh"

mkdir -p "$SERVICE_DIR"

cat > "$SERVICE_DIR/shadowmaker-steward-agent.service" << SERVICE
[Unit]
Description=Shadowmaker Steward Finance Housing Jobcenter Agent

[Service]
Type=oneshot
ExecStart=$SCRIPT
SERVICE

cat > "$SERVICE_DIR/shadowmaker-steward-agent.timer" << TIMERUNIT
[Unit]
Description=Run Shadowmaker Steward Finance Housing Agent weekly

[Timer]
OnCalendar=Sun *-*-* 18:30:00
Persistent=true

[Install]
WantedBy=timers.target
TIMERUNIT

systemctl --user daemon-reload

echo "[OK] Steward Timer vorbereitet, aber nicht aktiviert."
echo
echo "Aktivieren nur wenn gewünscht:"
echo "systemctl --user enable --now shadowmaker-steward-agent.timer"
echo
echo "Status:"
echo "systemctl --user status shadowmaker-steward-agent.timer --no-pager"
