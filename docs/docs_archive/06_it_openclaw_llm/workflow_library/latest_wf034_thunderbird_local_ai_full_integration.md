# WF-034 — Thunderbird Local AI Full Integration

## Status

Technischer Workflow zur lokalen Thunderbird-Integration in ShadowMaker/OpenClaw.

## Architektur

Thunderbird Mailbox  
→ sichere lokale Extraktion  
→ Mailtext + sichere Anhänge  
→ Secret-Redaction  
→ SQLite FTS Index  
→ `shadowmaker-thunderbird-search`  
→ `askmail-backend`  
→ Telegram Skill Bot `/run askmail ...`  
→ Discord askmail/Workflow-Nutzung

## Installierte Kommandos

```bash
shadowmaker-thunderbird-ingest
shadowmaker-thunderbird-search "Suchbegriff"
askmail "Suchbegriff"
askmail-backend "Suchbegriff"
```

## Sicherheitsmodell

Nicht verarbeitet:

- logins.json
- key4.db
- cert9.db
- cookies.sqlite
- gespeicherte Passwörter
- Tokens/Credentials als Zielinformation

Verarbeitet:

- Mailtexte
- sichere Metadaten
- sichere Anhänge
- PDF/TXT/MD/DOCX/ODT/CSV/XML/JSON soweit lokal verfügbar

## Telegram-Nutzung

```text
/run askmail Jobcenter
/run askmail Rechnung
/run askmail Bewerbung
/run askmail Thunderbird Discord Passwort
```

## Reindex

```bash
shadowmaker-thunderbird-ingest
```

## Test

```bash
askmail "Thunderbird"
askmail "Discord Passwort"
askmail "Jobcenter"
```

## Erstellt

2026-05-09T00:09:19+02:00
