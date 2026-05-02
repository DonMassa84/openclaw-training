#!/usr/bin/env bash
set -Eeuo pipefail

SERVICE_DIR="$HOME/.config/systemd/user"
BASE="$HOME/openclaw_training"
SCRIPT="$BASE/scripts/winky_system_monitor_agent.sh"

mkdir -p "$SERVICE_DIR"

cat > "$SERVICE_DIR/shadowmaker-winky-agent.service" << SERVICE
[Unit]
Description=Shadowmaker Winky Agent read-only system monitor

[Service]
Type=oneshot
ExecStart=$SCRIPT
SERVICE

cat > "$SERVICE_DIR/shadowmaker-winky-agent.timer" << TIMERUNIT
[Unit]
Description=Run Shadowmaker Winky Agent every 6 hours

[Timer]
OnCalendar=*-*-* 06,12,18,23:05:00
Persistent=true

[Install]
WantedBy=timers.target
TIMERUNIT

systemctl --user daemon-reload

echo "[OK] Winky Timer vorbereitet, aber nicht aktiviert."
echo
echo "Aktivieren nur wenn gewünscht:"
echo "systemctl --user enable --now shadowmaker-winky-agent.timer"
echo
echo "Status:"
echo "systemctl --user status shadowmaker-winky-agent.timer --no-pager"
