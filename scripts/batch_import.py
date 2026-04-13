import json, hashlib
from pathlib import Path
import chromadb
from sentence_transformers import SentenceTransformer

DB      = str(Path.home() / "openclaw_training" / "artifacts" / "chroma_multi")
SOURCES = [
    Path.home() / "openclaw_training" / "artifacts" / "harvested_tasks.jsonl",
    Path.home() / "openclaw_training" / "artifacts" / "derived_tasks.jsonl",
    Path.home() / "openclaw_training" / "artifacts" / "paste_tasks.jsonl",
]
BATCH   = 50

client = chromadb.PersistentClient(path=DB)
model  = SentenceTransformer("all-MiniLM-L6-v2")
coll   = client.get_or_create_collection("itpl_tasks")

existing = set(coll.get(include=[]).get("ids") or [])
print(f"[IMPORT] itpl_tasks vorher: {coll.count()}")

total = 0
for src in SOURCES:
    if not src.exists():
        print(f"[IMPORT] {src.name} nicht gefunden"); continue
    records = [json.loads(l) for l in src.read_text(encoding="utf-8").splitlines() if l.strip()]
    texts,metas,ids = [],[],[]
    for rec in records:
        text = (rec.get("text") or "").strip()
        if len(text) < 80: continue
        rid = hashlib.md5(text.encode()).hexdigest()
        if rid in existing: continue
        existing.add(rid)
        texts.append(text)
        metas.append({k:str(v) for k,v in (rec.get("metadata") or {}).items() if v is not None})
        ids.append(rid)
        if len(texts) >= BATCH:
            coll.add(documents=texts, metadatas=metas, ids=ids, embeddings=model.encode(texts).tolist())
            total += len(texts); print(f"  +{len(texts)} ({src.name})")
            texts,metas,ids = [],[],[]
    if texts:
        coll.add(documents=texts, metadatas=metas, ids=ids, embeddings=model.encode(texts).tolist())
        total += len(texts); print(f"  +{len(texts)} ({src.name}) Rest")

print(f"[IMPORT] itpl_tasks nachher: {coll.count()} (+{total} neu)")
