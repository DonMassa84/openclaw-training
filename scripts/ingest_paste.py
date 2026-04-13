import json, re
from pathlib import Path

SRC = Path.home() / "openclaw_training" / "artifacts" / "paste.txt"
OUT = Path.home() / "openclaw_training" / "artifacts" / "paste_tasks.jsonl"

if not SRC.exists():
    print(f"[PASTE] Keine Datei gefunden: {SRC}")
    raise SystemExit(0)

text = SRC.read_text(encoding="utf-8", errors="ignore")

secret_markers = [
    "OPENAIAPIKEY", "CLAUDEAPIKEY", "ANTHROPICAPIKEY", "NOMICAPIKEY",
    "GOOGLEAPIKEY", "VAPIAPIKEY", "SCRAPERAPIKEY", "CHATGPTAPIKEY",
    ".env", "APIKEY", "sk-", "nk-"
]

drop_markers = [
    ".bin,", ".gguf,", ".safetensors,", "distutils-precedence.pth",
    "scriptCache", "urlCache", "snapshotblob", "v8contextsnapshot",
    "timeshift", "cache", "nvidia", "firmware", "CMakeFiles",
    "site-packages", "registry.x86", "usr/lib", "var/lib", "var/cache"
]

keep_markers = [
    "TITLE ", "DATEI ", "messages ", '"metadata"', '"text"',
    "Personalplanung", "Assessment Center", "Kündigungsschutz",
    "Bewerbung", "Ausbildung", "Auswahlverfahren", "Personalbeschaffung",
    "AGG", "Datenschutz", "Aufgabe", "Situationsaufgabe"
]

def has_secret(s: str) -> bool:
    u = s.upper()
    return any(m.upper() in u for m in secret_markers)

def looks_like_noise(s: str) -> bool:
    low = s.lower()
    hits = sum(1 for m in drop_markers if m.lower() in low)
    return hits >= 2

def looks_relevant(s: str) -> bool:
    return any(m.lower() in s.lower() for m in keep_markers)

parts = re.split(r'(?=\b(?:DATEI|TITLE|messages)\b)', text)
written = 0
skipped_secret = 0
skipped_noise = 0
skipped_short = 0

with open(OUT, "w", encoding="utf-8") as f:
    for part in parts:
        block = re.sub(r'\s+', ' ', part).strip()
        if len(block) < 200:
            skipped_short += 1
            continue
        if has_secret(block):
            skipped_secret += 1
            continue
        if looks_like_noise(block) and not looks_relevant(block):
            skipped_noise += 1
            continue
        if not looks_relevant(block):
            continue

        block = block[:2000]
        rec = {
            "text": block,
            "metadata": {
                "sa": "GEN",
                "year": "UNKNOWN",
                "type": "TASK",
                "source_file": "paste.txt",
                "domain": "ITPL",
                "task_no": "",
                "derived_from": "PASTE"
            }
        }
        f.write(json.dumps(rec, ensure_ascii=False) + "\n")
        written += 1

print(f"[PASTE] {written} Records -> {OUT}")
print(f"[PASTE] übersprungen kurz={skipped_short} secret={skipped_secret} noise={skipped_noise}")
