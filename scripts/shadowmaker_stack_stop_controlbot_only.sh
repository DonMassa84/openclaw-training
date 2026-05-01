#!/usr/bin/env bash
set -Eeuo pipefail

echo "== STOP CONTROL BOT ONLY =="
systemctl --user stop shadowmaker-control-bot.service || true
systemctl --user status shadowmaker-control-bot.service --no-pager || true
