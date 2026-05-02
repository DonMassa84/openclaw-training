#!/usr/bin/env bash
set -Eeuo pipefail

SERVICE_DIR="$HOME/.config/systemd/user"
BASE="$HOME/openclaw_training"
SCRIPT="$BASE/scripts/mnemosyne_memory_curator_agent.sh"

mkdir -p "$SERVICE_DIR"

cat > "$SERVICE_DIR/shadowmaker-mnemosyne-agent.service" << SERVICE
[Unit]
Description=Shadowmaker Mnemosyne Memory Curator Agent

[Service]
Type=oneshot
ExecStart=$SCRIPT
SERVICE

cat > "$SERVICE_DIR/shadowmaker-mnemosyne-agent.timer" << TIMERUNIT
[Unit]
Description=Run Shadowmaker Mnemosyne Memory Curator daily

[Timer]
OnCalendar=*-*-* 23:20:00
Persistent=true

[Install]
WantedBy=timers.target
TIMERUNIT

systemctl --user daemon-reload

echo "[OK] Mnemosyne Timer vorbereitet, aber nicht aktiviert."
echo
echo "Aktivieren nur wenn gewünscht:"
echo "systemctl --user enable --now shadowmaker-mnemosyne-agent.timer"
echo
echo "Status:"
echo "systemctl --user status shadowmaker-mnemosyne-agent.timer --no-pager"
