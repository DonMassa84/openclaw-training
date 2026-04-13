from pathlib import Path

ROUTER = Path.home() / "openclaw_training" / "src" / "rag_query_router.py"
MARKER = "# PATCHED-V1"

OLD = '    if any(marker in text for marker in bad_markers):\n        return "Keine eindeutige Information im Kontext."'
NEW = '    master_score = sum(1 for m in bad_markers if m in text)  # PATCHED-V1\n    if master_score >= 5:\n        return "Keine eindeutige Information im Kontext."'

if not ROUTER.exists():
    print("[PATCH] Router nicht gefunden"); exit(0)

src = ROUTER.read_text(encoding="utf-8")
if MARKER in src:
    print("[PATCH] Bereits gepatcht"); exit(0)
if OLD not in src:
    print("[PATCH] Zielcode nicht gefunden (Versionsabweichung)"); exit(0)

backup = ROUTER.with_suffix(".py.prepatch")
ROUTER.rename(backup)
ROUTER.write_text(src.replace(OLD, NEW, 1), encoding="utf-8")
print(f"[PATCH] cleanup_non_master gepatcht. Backup: {backup.name}")
