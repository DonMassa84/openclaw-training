#!/usr/bin/env bash
set -Eeuo pipefail

echo "== CrashBandicot Logs =="
journalctl --user -u shadowmaker-control-bot.service -n 120 --no-pager || true
echo

echo "== OpenClaw Logs =="
docker logs --tail 120 openclaw-openclaw-gateway-1 2>&1 || true
