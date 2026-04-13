import json
from pathlib import Path
from datetime import datetime

ROOT = Path.home() / "Schreibtisch" / "Zusammenfassungen"
OUT = Path.home() / "openclaw_training" / "artifacts" / "inventory.jsonl"

def safe_str(s):
    return str(s).encode("utf-8", "ignore").decode("utf-8")

with open(OUT, "w", encoding="utf-8") as f:
    for p in ROOT.rglob("*"):
        if p.is_file():
            rec = {
                "path": safe_str(p),
                "name": safe_str(p.name),
                "size": p.stat().st_size,
                "time": datetime.fromtimestamp(p.stat().st_mtime).isoformat()
            }
            f.write(json.dumps(rec, ensure_ascii=False) + "\\n")

print("DONE:", OUT)
