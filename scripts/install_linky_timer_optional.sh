#!/usr/bin/env bash
set -Eeuo pipefail

SERVICE_DIR="$HOME/.config/systemd/user"
BASE="$HOME/openclaw_training"
SCRIPT="$BASE/scripts/linky_builder_agent.sh"

mkdir -p "$SERVICE_DIR"

cat > "$SERVICE_DIR/shadowmaker-linky-agent.service" << SERVICE
[Unit]
Description=Shadowmaker Linky Builder Prompt-to-Code Agent

[Service]
Type=oneshot
ExecStart=$SCRIPT
SERVICE

cat > "$SERVICE_DIR/shadowmaker-linky-agent.timer" << TIMERUNIT
[Unit]
Description=Run Shadowmaker Linky Builder Agent weekly

[Timer]
OnCalendar=Sat *-*-* 10:30:00
Persistent=true

[Install]
WantedBy=timers.target
TIMERUNIT

systemctl --user daemon-reload

echo "[OK] Linky Timer vorbereitet, aber nicht aktiviert."
echo
echo "Aktivieren nur wenn gewünscht:"
echo "systemctl --user enable --now shadowmaker-linky-agent.timer"
echo
echo "Status:"
echo "systemctl --user status shadowmaker-linky-agent.timer --no-pager"
