#!/usr/bin/env bash
set -Eeuo pipefail

PROMPT="$(cat)"
PROMPT="${PROMPT:-}"

if [ -z "$PROMPT" ]; then
  echo "Keine Frage übergeben."
  exit 0
fi

if command -v curl >/dev/null 2>&1 && curl -fsS --max-time 2 http://127.0.0.1:11434/api/tags >/tmp/shadowmaker_ollama_tags.json 2>/dev/null; then
  MODEL="$(python3 - << 'PY'
import json
from pathlib import Path

p = Path("/tmp/shadowmaker_ollama_tags.json")
data = json.loads(p.read_text() or "{}")
models = [m.get("name","") for m in data.get("models", [])]

preferred = ["qwen2.5:7b", "llama3.2:latest", "llama3.1:latest", "mistral:latest", "gemma2:latest"]

for pref in preferred:
    if pref in models:
        print(pref)
        raise SystemExit

if models:
    print(models[0])
PY
)"

  if [ -n "${MODEL:-}" ]; then
    python3 - "$MODEL" "$PROMPT" << 'PY'
import json
import sys
import urllib.request

model = sys.argv[1]
prompt = sys.argv[2]

payload = {
    "model": model,
    "prompt": (
        "Du bist der lokale Shadowmaker Agent. Antworte kurz, direkt und operativ. "
        "Bei Linux/OpenClaw/Discord/Systemfragen gib konkrete nächste Schritte. "
        "Keine Floskeln.\n\n"
        f"Frage:\n{prompt}"
    ),
    "stream": False
}

req = urllib.request.Request(
    "http://127.0.0.1:11434/api/generate",
    data=json.dumps(payload).encode("utf-8"),
    headers={"Content-Type": "application/json"},
    method="POST",
)

try:
    with urllib.request.urlopen(req, timeout=90) as r:
        data = json.loads(r.read().decode("utf-8", errors="replace"))
    print(data.get("response", "").strip() or "Ollama lieferte keine Antwort.")
except Exception as e:
    print(f"Ollama Backend Fehler: {type(e).__name__}: {e}")
PY
    exit 0
  fi
fi

cat << FALLBACK
Shadowmaker Ask Backend ist erreichbar, aber kein aktives LLM wurde gefunden.

Frage:
$PROMPT

Aktiviere Ollama auf 127.0.0.1:11434 oder passe ask_backend.sh auf OpenClaw/OpenAI an.
FALLBACK
