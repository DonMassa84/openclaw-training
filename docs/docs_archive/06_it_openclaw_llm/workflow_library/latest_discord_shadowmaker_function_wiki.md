
🧠⚔️ ShadowMaker Function Wiki

Enthalten:

RAG / ChromaDB
Thunderbird Import
GPU Reindex
userdocs_all_ssd
AI Provider Env
Discord Archive Audit
GitHub Savepoints
Timeshift Snapshots
Backup & Restore
Operator Onboarding

Quick Check:

cat ~/openclaw_training/docs/docs_archive/06_it_openclaw_llm/workflow_library/latest_shadowmaker_function_wiki_all_in_one.md
~/openclaw_training/bin/shadowmaker_ai_provider_smoke_test.sh
sqlite3 ~/openclaw_training/ai_docs_workflow/04_index/chroma_docs_archive/chroma.sqlite3 "SELECT COUNT(*) FROM embeddings;"
sqlite3 ~/openclaw_training/all_ssd_docs_pipeline/05_rag_index/chroma_userdocs_all_ssd/chroma.sqlite3 "SELECT COUNT(*) FROM embeddings;"
grep -c "03_email_thunderbird" ~/openclaw_training/ai_docs_workflow/03_dataset/docs_training_rag_chunks.jsonl

Regel: Keine echten Secrets in Git, Chat, Screenshots oder Reports.
