#!/usr/bin/env bash
set -Eeuo pipefail

SERVICE_DIR="$HOME/.config/systemd/user"
BASE="$HOME/openclaw_training"
SCRIPT="$BASE/scripts/strategist_career_agent.sh"

mkdir -p "$SERVICE_DIR"

cat > "$SERVICE_DIR/shadowmaker-strategist-agent.service" << SERVICE
[Unit]
Description=Shadowmaker Strategist Career Agent

[Service]
Type=oneshot
ExecStart=$SCRIPT
SERVICE

cat > "$SERVICE_DIR/shadowmaker-strategist-agent.timer" << TIMERUNIT
[Unit]
Description=Run Shadowmaker Strategist Career Agent weekly

[Timer]
OnCalendar=Mon *-*-* 09:30:00
Persistent=true

[Install]
WantedBy=timers.target
TIMERUNIT

systemctl --user daemon-reload

echo "[OK] Strategist Timer vorbereitet, aber nicht aktiviert."
echo
echo "Aktivieren nur wenn gewünscht:"
echo "systemctl --user enable --now shadowmaker-strategist-agent.timer"
echo
echo "Status:"
echo "systemctl --user status shadowmaker-strategist-agent.timer --no-pager"
