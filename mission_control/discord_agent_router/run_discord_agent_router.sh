#!/usr/bin/env bash
set -Eeuo pipefail
cd "/home/schattenmacher/openclaw_training/mission_control/discord_agent_router"
exec "/home/schattenmacher/openclaw_training/mission_control/discord_agent_router/.venv/bin/python" "/home/schattenmacher/openclaw_training/mission_control/discord_agent_router/discord_agent_router.py"
