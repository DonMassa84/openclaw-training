import sys
from pathlib import Path
import chromadb

DB = str(Path.home() / "openclaw_training" / "artifacts" / "chroma_multi")
THRESHOLDS = {
    "itpl_tasks":         {"min": 300, "target": 500},
    "itpl_solutions":     {"min": 50,  "target": 200},
    "itpl_masterpattern": {"min": 20,  "target": 100},
}

client   = chromadb.PersistentClient(path=DB)
existing = {c.name: c for c in client.list_collections()}
passed   = True

print("=== QUALITY GATE ===\n")
for name, thr in THRESHOLDS.items():
    count = existing[name].count() if name in existing else 0
    ok    = count >= thr["min"]
    if not ok: passed = False
    pct = min(100, int(count / thr["target"] * 100))
    bar = "█" * (pct // 5) + "░" * (20 - pct // 5)
    print(f"{'✓' if ok else '✗'} {name:<22} {count:>5}/{thr['target']:<5} [{bar}] {pct:>3}% {'PASS' if ok else 'FAIL'}")

print()
task_n = existing["itpl_tasks"].count() if "itpl_tasks" in existing else 0
if task_n < 300:
    print("→ Weitere PDFs nach ~/openclaw_training/pdfs/ kopieren")
    passed = False
elif task_n < 500:
    print("→ Basis ok. Mehr PDFs empfohlen. MASTER-Feinschliff möglich.")
else:
    print("→ GATE BESTANDEN. System bereit für MASTER-Feinschliff.")

print(f"\nGATE: {'BESTANDEN' if passed else 'NICHT BESTANDEN'}")
result_path = Path.home() / "openclaw_training" / "artifacts" / "quality_gate_result.txt"
result_path.write_text(f"GATE: {'BESTANDEN' if passed else 'NICHT BESTANDEN'}\nitpl_tasks: {task_n}\n")
sys.exit(0 if passed else 1)
