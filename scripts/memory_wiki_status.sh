#!/usr/bin/env bash
set -Eeuo pipefail

BASE="$HOME/openclaw_training"
MEMORY_DIR="$BASE/mission_control/memory_wiki"

echo "============================================================"
echo " MEMORY WIKI STATUS"
echo "============================================================"
echo "Pfad: $MEMORY_DIR"
echo
find "$MEMORY_DIR" -maxdepth 1 -type f -printf '%f\n' | sort
echo
echo "Index:"
echo "$MEMORY_DIR/00_index.md"
