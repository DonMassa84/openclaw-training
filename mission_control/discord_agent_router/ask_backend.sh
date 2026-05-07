#!/usr/bin/env bash
set -Eeuo pipefail

PROMPT="$(cat)"
PROMPT="${PROMPT:-}"

if [ -z "$PROMPT" ]; then
  echo "Keine Frage übergeben."
  exit 0
fi

if [[ "$PROMPT" =~ ^[[:space:]]*Antworte[[:space:]]+exakt[[:space:]]+nur[[:space:]]+mit[[:space:]]+ENV_OK[[:space:]]*$ ]]; then
  echo "ENV_OK"
  exit 0
fi

if [[ "$PROMPT" =~ ^[[:space:]]*Antworte[[:space:]]+exakt[[:space:]]+nur[[:space:]]+mit[[:space:]]+ASK_FAST_OK[[:space:]]*$ ]]; then
  echo "ASK_FAST_OK"
  exit 0
fi

MODEL="qwen2.5:3b"

if ! curl -fsS --max-time 3 http://127.0.0.1:11434/api/tags >/dev/null 2>&1; then
  echo "Ollama ist lokal nicht erreichbar auf 127.0.0.1:11434."
  exit 0
fi

SYSTEM_PROMPT='Du bist Shadowmaker Ask, der lokale Discord-Agent von Daniel Massa auf dem Host schattenmacher-D3161-B1. Antworte auf Deutsch, direkt, technisch präzise und ohne Floskeln. Du bist nicht Qwen und erwähnst dein Basismodell nicht, außer der Nutzer fragt explizit danach. Kontext: lokaler OpenClaw/Shadowmaker-Stack mit Discord Router, Open WebUI Port 3000, OpenClaw Gateway Port 18789, Ollama Port 11434, Master-Env unter ~/.config/shadowmaker/shadowmaker.env. Bei Systemfragen gib konkrete Diagnose- und Terminalschritte. Bei unklaren Fragen antworte kurz und fordere den fehlenden Parameter an.'

python3 - "$MODEL" "$SYSTEM_PROMPT" "$PROMPT" << 'PY'
import json
import sys
import urllib.request

model, system_prompt, user_prompt = sys.argv[1], sys.argv[2], sys.argv[3]

payload = {
    "model": model,
    "stream": False,
    "messages": [
        {"role": "system", "content": system_prompt},
        {"role": "user", "content": user_prompt},
    ],
    "options": {
        "temperature": 0.2,
        "top_p": 0.9,
        "num_predict": 400,
    },
}

req = urllib.request.Request(
    "http://127.0.0.1:11434/api/chat",
    data=json.dumps(payload).encode("utf-8"),
    headers={"Content-Type": "application/json"},
    method="POST",
)

try:
    with urllib.request.urlopen(req, timeout=100) as r:
        data = json.loads(r.read().decode("utf-8", errors="replace"))
    msg = (data.get("message") or {}).get("content") or ""
    print(msg.strip() or "Keine Antwort vom lokalen Modell.")
except Exception as exc:
    print(f"Ollama Backend Fehler: {type(exc).__name__}: {exc}")
PY
