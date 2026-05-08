# 🧠⚔️ ShadowMaker / OpenClaw Function Wiki — ALL IN ONE

Stand: 2026-05-08

Diese Wiki dokumentiert das lokale ShadowMaker/OpenClaw-System so, dass ein anderer Operator damit arbeiten kann.

Keine echten Secrets in Git. API-Keys bleiben lokal in:
`~/.config/shadowmaker/shadowmaker.env`

---

## 1. Systemzweck

ShadowMaker/OpenClaw dient als lokales Dokumentations-, RAG-, Archiv- und Automationssystem.

Funktionen:

- lokale Dokumente archivieren
- docs_archive und userdocs_all_ssd in ChromaDB indexieren
- Thunderbird-Mails exportieren und integrieren
- AI Provider per Env automatisch laden
- Discord-Archivspuren prüfen
- Workflow-Bibliothek pflegen
- GitHub-Savepoints ohne Secrets erstellen
- Timeshift-Snapshots erstellen
- Recovery- und Healthcheck-Abläufe bereitstellen

---

## 2. Hauptpfade

```text
Projektbasis:
~/openclaw_training

Workflow-Bibliothek:
~/openclaw_training/docs/docs_archive/06_it_openclaw_llm/workflow_library

docs_archive:
~/openclaw_training/docs/docs_archive

RAG Dataset:
~/openclaw_training/ai_docs_workflow/03_dataset/docs_training_rag_chunks.jsonl

docs_archive Chroma Index:
~/openclaw_training/ai_docs_workflow/04_index/chroma_docs_archive

userdocs JSONL:
~/openclaw_training/all_ssd_docs_pipeline/03_jsonl/latest_userdocs_all_ssd.jsonl

userdocs Chroma Index:
~/openclaw_training/all_ssd_docs_pipeline/05_rag_index/chroma_userdocs_all_ssd

AI Env:
~/.config/shadowmaker/shadowmaker.env

AI Loader:
~/.config/shadowmaker/load_shadowmaker_env.sh

Tools:
~/openclaw_training/bin
3. Zielwerte
docs_archive Chroma Count      = 144209
userdocs_all_ssd Chroma Count  = 866859
Thunderbird-Chunks             = 99469 genau einmal
Thunderbird JSONL Lines        = 7548
AI Provider Autoload           = OPENAI / CLAUDE / KIMI / PPLX = YES
Secrets in Git                 = NEIN
4. Workflow-Bibliothek

Pfad:

~/openclaw_training/docs/docs_archive/06_it_openclaw_llm/workflow_library

Wichtige Dateien:

latest_WORKFLOW_LIBRARY_ALL_IN_ONE.md
latest_workflow_library_cat.txt
latest_discord_workflow_library.md

latest_ai_provider_workflow_all_in_one.md
latest_ai_provider_all_in_one_cat.txt
latest_ai_provider_commands.md
latest_discord_ai_provider_workflow.md

latest_discord_archive_all_in_one.md
latest_discord_archive_all_in_one_cat.txt
latest_discord_archive_commands.md
discord_archive_audit/latest_discord_archive_audit.md

latest_shadowmaker_function_wiki_all_in_one.md
latest_shadowmaker_function_wiki_all_in_one_cat.txt
latest_shadowmaker_function_wiki_commands.md
latest_discord_shadowmaker_function_wiki.md
5. RAG / ChromaDB

Zweck:

docs_archive       = kuratierter Dokumentenbestand
userdocs_all_ssd   = großer SSD-Gesamtdokumentenbestand

Counts prüfen:

echo -n "docs_archive="
sqlite3 ~/openclaw_training/ai_docs_workflow/04_index/chroma_docs_archive/chroma.sqlite3 "SELECT COUNT(*) FROM embeddings;"

echo -n "userdocs_all_ssd="
sqlite3 ~/openclaw_training/all_ssd_docs_pipeline/05_rag_index/chroma_userdocs_all_ssd/chroma.sqlite3 "SELECT COUNT(*) FROM embeddings;"

Soll:

docs_archive=144209
userdocs_all_ssd=866859

docs_archive neu bauen:

cd ~/openclaw_training
~/openclaw_training/venv_docs_rag/bin/python ~/openclaw_training/ai_docs_workflow/build_chroma_docs_archive.py

Erfolg:

RAG_INDEX_OK
CHUNKS_INDEXED=144209
COLLECTION_COUNT=144209

Fehlerbilder:

docs_archive=136320
→ Index unvollständig, neu bauen

ModuleNotFoundError: chromadb
→ falscher Python, venv_docs_rag nutzen

Segfault nach erfolgreichem Build
→ SQLite Count prüfen; wenn Count stimmt, Index akzeptieren
6. Thunderbird Import

Pfade:

~/.thunderbird
~/openclaw_training/docs/docs_archive/03_email_thunderbird
~/openclaw_training/local_docs_pipeline/03_jsonl/latest_thunderbird_emails.jsonl
~/openclaw_training/ai_docs_workflow/03_dataset/docs_training_rag_chunks.jsonl

Prüfen:

find ~/openclaw_training/docs/docs_archive/03_email_thunderbird -type f -name '*.md' | wc -l
wc -l ~/openclaw_training/local_docs_pipeline/03_jsonl/latest_thunderbird_emails.jsonl
grep -c "03_email_thunderbird" ~/openclaw_training/ai_docs_workflow/03_dataset/docs_training_rag_chunks.jsonl

Bewertung:

99469   = korrekt
198938  = doppelt integriert

Doppelimport reparieren:

cp ~/openclaw_training/ai_docs_workflow/03_dataset/docs_training_rag_chunks.jsonl.bak_before_thunderbird_20260508_040754 \
   ~/openclaw_training/ai_docs_workflow/03_dataset/docs_training_rag_chunks.jsonl

cd ~/openclaw_training
~/openclaw_training/venv_docs_rag/bin/python ~/openclaw_training/ai_docs_workflow/build_chroma_docs_archive.py
7. GPU-Reindex

Regel:

1. docs_archive zuerst
2. userdocs_all_ssd danach
3. kein paralleler Reindex
4. kein erneutes Extrahieren, wenn JSONL existiert

GPU prüfen:

nvidia-smi
~/openclaw_training/venv_docs_rag/bin/python - <<'PY'
import torch
print("CUDA_AVAILABLE=", torch.cuda.is_available())
if torch.cuda.is_available():
    print("CUDA_DEVICE=", torch.cuda.get_device_name(0))
    print("CUDA_MEMORY_GB=", round(torch.cuda.get_device_properties(0).total_memory / 1024**3, 2))
PY

Bekannter Zustand:

CUDA_AVAILABLE=True
CUDA_DEVICE=NVIDIA GeForce RTX 3060
CUDA_MEMORY_GB=11.63
8. userdocs_all_ssd

Zielwert:

866859

Prüfen:

sqlite3 ~/openclaw_training/all_ssd_docs_pipeline/05_rag_index/chroma_userdocs_all_ssd/chroma.sqlite3 "SELECT COUNT(*) FROM embeddings;"

Wenn 866859 erscheint, ist der Index vollständig.

9. AI Provider Integration

Dateien:

~/.config/shadowmaker/shadowmaker.env
~/.config/shadowmaker/load_shadowmaker_env.sh
~/openclaw_training/bin/shadowmaker_ai_provider_smoke_test.sh

Provider:

OpenAI
Perplexity
Kimi / Moonshot
Claude / Anthropic
Hugging Face

Env laden:

source ~/.config/shadowmaker/load_shadowmaker_env.sh

Smoke-Test:

~/openclaw_training/bin/shadowmaker_ai_provider_smoke_test.sh

Erwartung:

OPENAI=YES
CLAUDE=YES
KIMI=YES
PPLX=YES

Sicherheitsregeln:

Keine echten Keys in Git
Keine echten Keys in Screenshots
Keine echten Keys in Reports
Nur SET len=... dokumentieren
Bei Leak Key sofort rotieren
10. Discord Archive Audit

Dateien:

~/openclaw_training/docs/docs_archive/06_it_openclaw_llm/workflow_library/discord_archive_audit/latest_discord_archive_audit.md
~/openclaw_training/docs/docs_archive/06_it_openclaw_llm/workflow_library/latest_discord_archive_all_in_one.md
~/openclaw_training/docs/docs_archive/06_it_openclaw_llm/workflow_library/latest_discord_archive_all_in_one_cat.txt
~/openclaw_training/docs/docs_archive/06_it_openclaw_llm/workflow_library/latest_discord_archive_commands.md

Aktuelle Channel-Treffer:

housing-jobcenter           14
agent-control                4
mail-control                 4
ihk-training                 8
security-control             4
docs-archive                 6
daily-reports                4
system-alerts               34
daily-brief                 23
freeze-reports              22
openclaw-status             23
daily-delight               19
openclaw-projects           18
automation-n8n-flowise      14
memory-wiki                 31

Interpretation:

Treffer > 0 = lokal referenziert
Treffer 0   = fehlt oder anders benannt
Attachment-Kandidaten = lokale Dateispuren, aber kein Beweis für vollständigen Discord-Download

Audit lesen:

cat ~/openclaw_training/docs/docs_archive/06_it_openclaw_llm/workflow_library/discord_archive_audit/latest_discord_archive_audit.md
11. GitHub Savepoints

Nie git add . blind verwenden.

Standardprozess:

cd ~/openclaw_training
git status --short
git add -f <sichere_dateien>
git diff --cached -- . | grep -E 'sk-[A-Za-z0-9_-]{20,}|ghp_[A-Za-z0-9_]{20,}|hf_[A-Za-z0-9]{20,}' && echo ALARM_SECRET_LEAK || echo OK_NO_SECRET_PATTERN
git commit -m "<Commit Message>"
git push

Nicht committen:

.env Dateien
echte Secrets
Chroma SQLite Indizes
venv Ordner
große Exporte
security_quarantine
thunderbird_email_import Rohdaten

Großen Push reparieren:

cd ~/openclaw_training
git branch backup_before_push_cleanup_$(date +%Y%m%d_%H%M%S)
git reset --soft origin/main
git restore --staged :/
12. Timeshift

Snapshot erstellen:

sudo -E timeshift --create --comments "ShadowMaker savepoint $(date +%Y%m%d_%H%M%S)" --tags D

Snapshots anzeigen:

sudo timeshift --list | head -60

Bestätigte Snapshots:

2026-05-08_09-51-27  D  ShadowMaker workflow library + clean RAG state
2026-05-08_10-22-36  D  AI API env integration
2026-05-08_10-32-43  D  AI provider all-in-one workflow
2026-05-08_10-34-49  D  AI provider all-in-one workflow

Wenn Timeshift Segfault meldet, trotzdem mit timeshift --list prüfen.

13. Backup & Restore

Dataset Backup:

cp ~/openclaw_training/ai_docs_workflow/03_dataset/docs_training_rag_chunks.jsonl \
   ~/openclaw_training/ai_docs_workflow/03_dataset/docs_training_rag_chunks.jsonl.bak_$(date +%Y%m%d_%H%M%S)

Index Backup:

cp -a ~/openclaw_training/ai_docs_workflow/04_index/chroma_docs_archive \
      ~/openclaw_training/ai_docs_workflow/04_index/chroma_docs_archive.bak_$(date +%Y%m%d_%H%M%S)

Secret Backup lokal:

cp ~/.config/shadowmaker/shadowmaker.env ~/.config/shadowmaker/shadowmaker.env.local_secret_backup_$(date +%Y%m%d_%H%M%S)
chmod 600 ~/.config/shadowmaker/shadowmaker.env.local_secret_backup_*
14. Gesamt-Healthcheck
cd ~/openclaw_training

echo "== RAG Counts =="
echo -n "docs_archive="
sqlite3 ~/openclaw_training/ai_docs_workflow/04_index/chroma_docs_archive/chroma.sqlite3 "SELECT COUNT(*) FROM embeddings;"
echo -n "userdocs_all_ssd="
sqlite3 ~/openclaw_training/all_ssd_docs_pipeline/05_rag_index/chroma_userdocs_all_ssd/chroma.sqlite3 "SELECT COUNT(*) FROM embeddings;"

echo "== Thunderbird =="
grep -c "03_email_thunderbird" ~/openclaw_training/ai_docs_workflow/03_dataset/docs_training_rag_chunks.jsonl

echo "== AI Provider =="
~/openclaw_training/bin/shadowmaker_ai_provider_smoke_test.sh

echo "== Discord Audit =="
head -60 ~/openclaw_training/docs/docs_archive/06_it_openclaw_llm/workflow_library/discord_archive_audit/latest_discord_archive_audit.md

echo "== Git =="
git status --short

echo "== Timeshift =="
sudo timeshift --list | head -20
15. Operator-Onboarding

Startreihenfolge:

1. cd ~/openclaw_training
2. source ~/.config/shadowmaker/load_shadowmaker_env.sh
3. AI-Smoke-Test ausführen
4. RAG Counts prüfen
5. Thunderbird-Chunks prüfen
6. Discord-Audit lesen
7. Workflow-Bibliothek lesen
8. Vor Änderungen git status --short
9. Vor Reindex Backup anlegen
10. Nach stabilem Zustand GitHub + Timeshift Savepoint

Verbote:

Kein git add .
Keine echten Secrets committen
Keine parallelen Reindex-Läufe
Keine Chroma-Indexordner pushen
Keine Thunderbird-Integration mehrfach
Keine venvs pushen
Keine riesigen Exporte pushen
16. Schnellbefehle
cat ~/openclaw_training/docs/docs_archive/06_it_openclaw_llm/workflow_library/latest_shadowmaker_function_wiki_all_in_one.md
~/openclaw_training/bin/shadowmaker_ai_provider_smoke_test.sh
sqlite3 ~/openclaw_training/ai_docs_workflow/04_index/chroma_docs_archive/chroma.sqlite3 "SELECT COUNT(*) FROM embeddings;"
sqlite3 ~/openclaw_training/all_ssd_docs_pipeline/05_rag_index/chroma_userdocs_all_ssd/chroma.sqlite3 "SELECT COUNT(*) FROM embeddings;"
grep -c "03_email_thunderbird" ~/openclaw_training/ai_docs_workflow/03_dataset/docs_training_rag_chunks.jsonl
cat ~/openclaw_training/docs/docs_archive/06_it_openclaw_llm/workflow_library/discord_archive_audit/latest_discord_archive_audit.md
17. Abschlussstatus
Workflow-Bibliothek dokumentiert:       JA
RAG / Chroma dokumentiert:              JA
Thunderbird dokumentiert:               JA
GPU-Reindex dokumentiert:               JA
userdocs_all_ssd dokumentiert:          JA
AI Provider dokumentiert:               JA
Discord Archive Audit dokumentiert:     JA
GitHub Savepoint dokumentiert:          JA
Timeshift dokumentiert:                 JA
Backup & Restore dokumentiert:          JA
Onboarding dokumentiert:                JA
Secrets in Git:                         NEIN

