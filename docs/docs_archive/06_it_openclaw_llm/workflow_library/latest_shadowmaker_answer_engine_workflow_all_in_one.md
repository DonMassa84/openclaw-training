# 🧠 ShadowMaker Answer Engine Workflow — ALL IN ONE

## Zweck

Dieser Workflow sorgt dafür, dass Discord-/ShadowMaker-Befehle nicht mehr rohe grep-Treffer ausgeben, sondern ChatGPT-artig antworten.

## Architektur

```text
Slash Command
→ ask*-backend
→ docs-rag-* Suche
→ shadowmaker-answer-engine
→ strukturierte Discord-Antwort
Antwortformat
✅ Kurzstatus
🎯 Wichtigster Treffer
🧠 Bewertung
⚔️ Nächste Aktion
🧪 Lokaler Prüf-Befehl
Reparierte Backends
askhousing-backend
askihk-backend
askmail-backend
asksecurity-backend
askdocs-backend
AI Provider

Die Engine nutzt OPENAI_API_KEY, wenn vorhanden.

Env-Datei:

~/.config/shadowmaker/shadowmaker.env

Loader:

~/.config/shadowmaker/load_shadowmaker_env.sh

Fallback:

Wenn OPENAI_API_KEY fehlt oder die API nicht antwortet, erzeugt die Engine eine lokale strukturierte Fallback-Antwort.
Test
~/.local/bin/askhousing-backend "Hausenring 53 Zusicherung Jobcenter"
~/.local/bin/askmail-backend "Thunderbird Discord Passwort"
~/.local/bin/askdocs-backend "OpenClaw Workflow Library"
Discord-Test
/askhousing Hausenring 53 Zusicherung Jobcenter
/askmail Thunderbird Discord Passwort
/askdocs OpenClaw Workflow Library

