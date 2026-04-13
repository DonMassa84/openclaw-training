import pdfplumber
import docx
from odf import text, teletype
from odf.opendocument import load
from pathlib import Path

ROOT = Path.home() / "Schreibtisch" / "Zusammenfassungen"
OUT = Path.home() / "openclaw_training" / "artifacts" / "extracted_text"

def save_text(name, content):
    safe = str(name).replace(" ", "_")
    out_file = OUT / (safe + ".txt")
    with open(out_file, "w", encoding="utf-8") as f:
        f.write(content)

def extract_pdf(p):
    text = ""
    with pdfplumber.open(p) as pdf:
        for page in pdf.pages:
            text += page.extract_text() or ""
            text += "\n"
    return text

def extract_docx(p):
    d = docx.Document(p)
    return "\n".join([para.text for para in d.paragraphs])

def extract_odt(p):
    doc = load(str(p))
    allparas = doc.getElementsByType(text.P)
    return "\n".join([teletype.extractText(p) for p in allparas])

for file in ROOT.rglob("*"):
    if not file.is_file():
        continue

    try:
        if file.suffix.lower() == ".pdf":
            content = extract_pdf(file)
        elif file.suffix.lower() == ".docx":
            content = extract_docx(file)
        elif file.suffix.lower() == ".odt":
            content = extract_odt(file)
        elif file.suffix.lower() in [".txt", ".md"]:
            content = file.read_text(encoding="utf-8", errors="ignore")
        else:
            continue

        if content.strip():
            save_text(file.name, content)

    except Exception as e:
        print("ERROR:", file, e)

print("DONE EXTRACTION")
