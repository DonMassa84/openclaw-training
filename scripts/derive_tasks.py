import json
from pathlib import Path
import chromadb

DB  = str(Path.home() / "openclaw_training" / "artifacts" / "chroma_multi")
OUT = Path.home() / "openclaw_training" / "artifacts" / "derived_tasks.jsonl"

TEMPLATES = [
    "Aufgabe ({sa} / {year}):\nAnalysieren Sie folgende Situation:\n\n{body}",
    "Aufgabe ({sa} / {year}):\nBewerten Sie die nachfolgende Problemstellung:\n\n{body}",
    "Aufgabe ({sa} / {year}):\nEntwickeln Sie eine Lösung:\n\n{body}",
    "Aufgabe ({sa} / {year}):\nErläutern Sie Ursachen und Maßnahmen:\n\n{body}",
]

client = chromadb.PersistentClient(path=DB)
try:
    coll = client.get_collection("itpl_solutions")
except Exception:
    print("[DERIVE] itpl_solutions nicht gefunden – übersprungen"); exit(0)

results = coll.get(include=["documents","metadatas"])
docs  = results.get("documents") or []
metas = results.get("metadatas") or []
total = 0

with open(OUT,"w",encoding="utf-8") as f:
    for i,(doc,meta) in enumerate(zip(docs,metas)):
        doc = (doc or "").strip()
        meta = meta or {}
        if len(doc) < 150: continue
        sa   = meta.get("sa","GEN")
        year = meta.get("year","UNKNOWN")
        text = TEMPLATES[i % len(TEMPLATES)].format(sa=sa, year=year, body=doc[:700])
        rec  = {"text":text,"metadata":{**meta,"type":"TASK","derived_from":"SOLUTION"}}
        f.write(json.dumps(rec, ensure_ascii=False)+"\n")
        total += 1

print(f"[DERIVE] {total} Task-Derivate -> {OUT}")
