# 🧠⚔️ ShadowMaker Operator Wiki — Discord Edition

## ✅ Zweck

Discord-taugliche Bedienübersicht für ShadowMaker/OpenClaw.

Diese Doku zeigt schnell:

- was das System macht
- welche Healthchecks wichtig sind
- welche Zielwerte gelten
- welche Recovery-Befehle genutzt werden
- welche Sicherheitsregeln gelten

---

## 🧭 Hauptpfade

```text
Projektbasis:
~/openclaw_training

Workflow-Bibliothek:
~/openclaw_training/docs/docs_archive/06_it_openclaw_llm/workflow_library

AI Env:
~/.config/shadowmaker/shadowmaker.env

AI Loader:
~/.config/shadowmaker/load_shadowmaker_env.sh

Tools:
~/openclaw_training/bin
🎯 Zielwerte
docs_archive       = 144209
userdocs_all_ssd   = 866859
Thunderbird        = 99469 Chunks, genau 1x integriert
AI Provider        = OPENAI / CLAUDE / KIMI / PPLX = YES
Secrets in Git     = NEIN
🩺 Quick Healthcheck
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
📧 Thunderbird-Regel
99469   = korrekt
198938  = doppelt integriert

Repair:

cp ~/openclaw_training/ai_docs_workflow/03_dataset/docs_training_rag_chunks.jsonl.bak_before_thunderbird_20260508_040754 \
   ~/openclaw_training/ai_docs_workflow/03_dataset/docs_training_rag_chunks.jsonl

cd ~/openclaw_training
~/openclaw_training/venv_docs_rag/bin/python ~/openclaw_training/ai_docs_workflow/build_chroma_docs_archive.py
🤖 AI Provider
source ~/.config/shadowmaker/load_shadowmaker_env.sh
~/openclaw_training/bin/shadowmaker_ai_provider_smoke_test.sh

Erwartung:

OPENAI=YES
CLAUDE=YES
KIMI=YES
PPLX=YES
📦 Discord Archive Audit
cat ~/openclaw_training/docs/docs_archive/06_it_openclaw_llm/workflow_library/discord_archive_audit/latest_discord_archive_audit.md

Bedeutung:

Treffer > 0 = lokal referenziert
Treffer 0   = fehlt oder anders benannt
Attachment-Kandidaten = lokale Dateispuren, kein Vollständigkeitsbeweis
🔐 Sicherheitsregeln
Kein git add .
Keine echten Secrets committen
Keine echten Secrets in Screenshots
Keine echten Secrets in Reports
Keine Chroma-Indizes pushen
Keine venvs pushen
Keine riesigen Exporte pushen
💾 Git Savepoint
cd ~/openclaw_training
git status --short
git add -f <sichere_dateien>
git commit -m "<Commit Message>"
git push
🧊 Timeshift
sudo -E timeshift --create --comments "ShadowMaker savepoint $(date +%Y%m%d_%H%M%S)" --tags D
sudo timeshift --list | head -60
🧠 Operator-Merksatz
Erst prüfen. Dann sichern. Dann ändern. Dann reindexieren. Dann pushen.
Nie Secrets. Nie parallel.

