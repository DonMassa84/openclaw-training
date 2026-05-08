# 🧠⚔️ ShadowMaker Workflow Library — ALL IN ONE

Stand: 2026-05-08T09:16:12+02:00

## ✅ Zielwerte

```text
docs_archive       = 144209
userdocs_all_ssd   = 866859
Thunderbird        = 99469 Chunks, genau 1x integriert
```

## 🩺 Healthcheck

```bash
docs-rag-status
sqlite3 ~/openclaw_training/ai_docs_workflow/04_index/chroma_docs_archive/chroma.sqlite3 "SELECT COUNT(*) FROM embeddings;"
sqlite3 ~/openclaw_training/all_ssd_docs_pipeline/05_rag_index/chroma_userdocs_all_ssd/chroma.sqlite3 "SELECT COUNT(*) FROM embeddings;"
wc -l ~/openclaw_training/ai_docs_workflow/03_dataset/docs_training_rag_chunks.jsonl
grep -c "03_email_thunderbird" ~/openclaw_training/ai_docs_workflow/03_dataset/docs_training_rag_chunks.jsonl
```

## 📧 Thunderbird-Regel

Soll: 99469. Fehler: 198938 = doppelt integriert. Fix: Backup vor zweiter Integration zurückspielen, danach docs_archive neu bauen.

```bash
cp ~/openclaw_training/ai_docs_workflow/03_dataset/docs_training_rag_chunks.jsonl.bak_before_thunderbird_20260508_040754 ~/openclaw_training/ai_docs_workflow/03_dataset/docs_training_rag_chunks.jsonl
```

## 🧩 docs_archive Rebuild

```bash
mv ~/openclaw_training/ai_docs_workflow/04_index/chroma_docs_archive ~/openclaw_training/ai_docs_workflow/04_index/chroma_docs_archive.bak_$(date +%Y%m%d_%H%M%S); mkdir -p ~/openclaw_training/ai_docs_workflow/04_index/chroma_docs_archive; cd ~/openclaw_training && ~/openclaw_training/venv_docs_rag/bin/python ~/openclaw_training/ai_docs_workflow/build_chroma_docs_archive.py
```

## 🗃️ userdocs_all_ssd

Zielwert: 866859. Wenn SQLite 866859 zeigt, ist der Index vollständig, auch wenn ein nachgelagerter Test einen Segfault hatte.

## 🚨 Failure Patterns

- docs_archive=136320 → unvollständig, neu bauen
- 03_email_thunderbird=198938 → doppelt, Backup restore
- ModuleNotFoundError chromadb → falscher Python, venv nutzen
- HF Token Warnung → nicht kritisch, nur langsamer

## ⚡ GPU

```bash
nvidia-smi
~/openclaw_training/venv_docs_rag/bin/python -c "import torch; print(torch.cuda.is_available()); print(torch.cuda.get_device_name(0) if torch.cuda.is_available() else \"CPU\")"
```


---

# 🤖 AI Provider Addendum

Stand: 2026-05-08T10:15:25.724186

```text
/home/schattenmacher/openclaw_training/docs/docs_archive/06_it_openclaw_llm/workflow_library/latest_ai_provider_workflow_all_in_one.md
/home/schattenmacher/openclaw_training/docs/docs_archive/06_it_openclaw_llm/workflow_library/latest_discord_ai_provider_workflow.md
/home/schattenmacher/openclaw_training/docs/docs_archive/06_it_openclaw_llm/workflow_library/latest_ai_provider_commands.md
/home/schattenmacher/openclaw_training/docs/docs_archive/06_it_openclaw_llm/workflow_library/latest_ai_provider_all_in_one_cat.txt
/home/schattenmacher/openclaw_training/bin/shadowmaker_ai_provider_smoke_test.sh
```
