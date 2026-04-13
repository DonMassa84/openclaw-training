# OPENCLAW Training System
## IHK IT-Projektleiter – Prüfungsvorbereitung via RAG + Local LLM

> **Stand: 2026-04-13 | Version: IHK-ROUTER-V4.1-FINAL-HARDENED**  
> **Batch-Score: Ø 19.0/20 | Bestanden: 5/5 | Status: ✅ PRODUKTIONSREIF**

---

## System-Architektur
PDFs (IHK-Prüfungen 2011–2023)
│
▼
┌─────────────────┐    ┌──────────────────────┐
│  PDF-Harvester  │───▶│  ChromaDB (lokal)    │
│  + Deriver      │    │  itpl_tasks    5309  │
└─────────────────┘    │  itpl_solutions 2741 │
│  itpl_masterpattern  │
│               2654   │
└──────────┬───────────┘
│ Embedding
│ all-MiniLM-L6-v2
▼
┌──────────────────────┐
│  RAG Query Router    │
│  Intent Detection    │
│  TASK/SOLUTION/MASTER│
└──────────┬───────────┘
│
▼
┌──────────────────────┐
│  Ollama (lokal)      │
│  qwen2.5:7b          │
│  10-Punkte-Prompt    │
└──────────────────────┘
---

## Collections

| Collection | Chunks | Inhalt |
|---|---|---|
| `itpl_tasks` | 5309 | Aufgabenstellungen SA1/SA2/SA3 (2011–2023) |
| `itpl_solutions` | 2741 | Musterlösungen + Lösungshinweise |
| `itpl_masterpattern` | 2654 | IHK-Bewertungsmuster |

---

## Scoring-Ergebnisse (Batch-Test 2026-04-13)

| SA-Typ | Score | Status |
|---|---|---|
| SA1 | 19.0/20 | ✅ BESTANDEN |
| SA2 | 19.5/20 | ✅ BESTANDEN |
| SA3 | 18.0/20 | ✅ BESTANDEN |
| **Ø Gesamt** | **19.0/20** | **✅ PRODUKTIONSREIF** |

### 10-Punkte-Struktur (IHK-Pflichtformat)

| Punkt | Inhalt | Ø Score |
|---|---|---|
| P01 | Situation | 2.0/2 |
| P02 | Ziel (SMART) | 2.0/2 |
| P03 | Stakeholder | 1.8/2 |
| P04 | Ursachen M/O/P | 2.0/2 |
| P05 | Alternativen A/B/C | 2.0/2 |
| P06 | Bewertung | 2.0/2 |
| P07 | Entscheidung | 2.0/2 |
| P08 | Umsetzung | 2.0/2 |
| P09 | Kontrolle KPIs | 2.0/2 |
| P10 | Nachhaltigkeit/Rechtlich | 1.3/2 |

---

## Projektstruktur
openclaw_training/
├── src/
│   ├── rag_query_router.py       # Haupt-Router V4.1
│   └── pruefungssimulator.py     # Interaktiver Simulator
├── scripts/
│   ├── harvest_pdfs.py           # PDF → Chunks
│   ├── derive_tasks.py           # Solution → Task-Derivate
│   ├── batch_import.py           # ChromaDB Import
│   ├── patch_router.py           # Idempotenter Patcher
│   └── quality_gate.py           # Collection-Check
├── artifacts/
│   ├── chroma_multi/             # ChromaDB Datenbank
│   ├── harvested_tasks.jsonl     # PDF-Extrakte
│   └── derived_tasks.jsonl      # Derivate
├── pdfs/                         # IHK-Quell-PDFs (gitignored)
├── reports/                      # Batch-Scores + Sim-Reports
├── openclaw_booster.sh           # Vollautomatischer Workflow
└── openclaw_batch_scorer.sh      # Automatisches Batch-Scoring
---

## Schnellstart

```bash
# 1. Venv aktivieren
cd ~/openclaw_training
source .venv/bin/activate

# 2. Router (Produktivmodus)
python src/rag_query_router.py

# 3. Prüfungssimulator
python src/pruefungssimulator.py

# 4. Kompletter Rebuild (nach neuen PDFs)
bash ~/openclaw_booster.sh

# 5. Batch-Scoring
bash ~/openclaw_batch_scorer.sh
```

---

## Router-Modi

| Intent | Trigger | Collection | Verhalten |
|---|---|---|---|
| `TASK` | Default | `itpl_tasks` | Fachliche Kernaussagen |
| `SOLUTION` | "welche Lösung", "laut Lösung" | `itpl_solutions` | Konkrete Lösungsinhalte |
| `MASTER` | "Erstelle eine SA1/2/3 Antwort" | `itpl_masterpattern` | 10-Punkte-Volltext |

---

## Iterationshistorie

| Version | Änderung | Score-Delta |
|---|---|---|
| V1 | Basis-Router | ~10/20 |
| V2 | Intent-Detection + Collections | ~12/20 |
| V3 | Prompt-Hardening | ~14/20 |
| V4.0 | MASTER-Struktur erzwungen | ~16/20 |
| V4.1 | SMART/KPI/Tabellarisch/Rechtlich | **19.0/20** |

---

## Stack

- **OS:** Linux Mint
- **LLM:** Ollama + qwen2.5:7b (lokal, offline)
- **Embedding:** sentence-transformers/all-MiniLM-L6-v2
- **VectorDB:** ChromaDB (persistent, lokal)
- **PDF:** pdfplumber
- **Sprache:** Python 3.10+

---

## Rechtlicher Hinweis

Alle IHK-Prüfungsunterlagen werden ausschließlich lokal verarbeitet.  
Keine Weitergabe. Keine Cloud-Übertragung. Nur zur persönlichen Prüfungsvorbereitung.

---

*Generiert: 2026-04-13 | IHK-ROUTER-V4.1-FINAL-HARDENED*
