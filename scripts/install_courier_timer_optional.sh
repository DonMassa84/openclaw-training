#!/usr/bin/env bash
set -Eeuo pipefail

SERVICE_DIR="$HOME/.config/systemd/user"
BASE="$HOME/openclaw_training"
SCRIPT="$BASE/scripts/courier_mail_briefing_run.sh"

mkdir -p "$SERVICE_DIR"

cat > "$SERVICE_DIR/shadowmaker-courier-agent.service" << SERVICE
[Unit]
Description=Shadowmaker Courier Mail Briefing Agent

[Service]
Type=oneshot
ExecStart=$SCRIPT
SERVICE

cat > "$SERVICE_DIR/shadowmaker-courier-agent.timer" << TIMERUNIT
[Unit]
Description=Run Shadowmaker Courier Mail Briefing every morning

[Timer]
OnCalendar=*-*-* 08:05:00
Persistent=true

[Install]
WantedBy=timers.target
TIMERUNIT

systemctl --user daemon-reload

echo "[OK] Courier Timer vorbereitet, aber nicht aktiviert."
echo
echo "Aktivieren nur wenn Gmail/Proton sauber getestet sind:"
echo "systemctl --user enable --now shadowmaker-courier-agent.timer"
echo
echo "Status:"
echo "systemctl --user status shadowmaker-courier-agent.timer --no-pager"
