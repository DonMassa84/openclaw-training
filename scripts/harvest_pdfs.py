import re, json, sys
from pathlib import Path
try:
    import pdfplumber
except ImportError:
    sys.exit("pdfplumber fehlt")

PDF_DIR = Path.home() / "openclaw_training" / "pdfs"
OUT     = Path.home() / "openclaw_training" / "artifacts" / "harvested_tasks.jsonl"
SA_PAT  = re.compile(r"(situationsaufgabe\s*[123]|sa\s*[123])", re.IGNORECASE)
TK_PAT  = re.compile(r"(aufgabe\s*\d+)", re.IGNORECASE)
YR_PAT  = re.compile(r"(20\d{2})")

def detect_sa(t):
    m = SA_PAT.search(t)
    if not m: return "GEN"
    r = m.group(1).upper().replace(" ","")
    for tag in ("SA1","SA2","SA3"):
        if tag in r: return tag
    return "GEN"

def detect_year(p):
    m = YR_PAT.search(p.stem)
    return m.group(1) if m else "UNKNOWN"

def split_blocks(text):
    parts = re.split(r"(?=(?:Aufgabe\s*\d+|Situationsaufgabe\s*[123])\s*[\n\r])", text, flags=re.IGNORECASE)
    return [p.strip() for p in parts if len(p.strip()) >= 120]

pdfs = list(PDF_DIR.glob("**/*.pdf"))
if not pdfs:
    print(f"[HARVEST] Keine PDFs in {PDF_DIR}")
    exit(0)

total = 0
with open(OUT,"w",encoding="utf-8") as f:
    for pdf_path in pdfs:
        year = detect_year(pdf_path)
        try:
            with pdfplumber.open(pdf_path) as pdf:
                full = "\n".join(p.extract_text() or "" for p in pdf.pages)
        except Exception as e:
            print(f"[HARVEST] Fehler {pdf_path.name}: {e}"); continue
        for block in split_blocks(full):
            sa = detect_sa(block)
            tm = TK_PAT.search(block)
            rec = {"text": block[:2000], "metadata": {"sa":sa,"year":year,"type":"TASK","source_file":pdf_path.name,"domain":"ITPL","task_no":tm.group(1) if tm else "","derived_from":"PDF"}}
            f.write(json.dumps(rec, ensure_ascii=False)+"\n")
            total += 1
print(f"[HARVEST] {total} Chunks aus {len(pdfs)} PDFs -> {OUT}")
