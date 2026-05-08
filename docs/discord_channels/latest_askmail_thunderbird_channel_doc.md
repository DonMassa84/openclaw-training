# Discord Channel Doc — mail-thunderbird / askmail

## Zweck

Dieser Kanal dokumentiert die Thunderbird-Integration in das lokale ShadowMaker/OpenClaw-KI-System.

## Produktionsstatus

- WF-034 askmail Thunderbird Integration: STABLE
- Telegram Skill: /run askmail <query>
- Secret Scan: OK_NO_SECRET_PATTERN
- Git Commit: 5ee9584 Add WF-034 Thunderbird askmail integration workflow
- 409 Conflict: bereinigt
- Runtime: Skill-Bot + Discord Router

## Architektur

Thunderbird Mailbox
→ lokaler Mail-/Attachment-Index
→ SQLite/FTS
→ shadowmaker-thunderbird-search
→ askmail-backend
→ askmail CLI
→ Telegram Skill Bot
→ Discord-Doku/Status

## Produktionsbefehle

Telegram:

- /run askmail Thunderbird
- /run askmail Jobcenter
- /run askmail Rechnung
- /run askmail Bewerbung
- /run secret_scan
- /run all_status

Lokal:

- askmail "Bewerbung"
- shadowmaker-thunderbird-search "Jobcenter"
- shadowmaker-thunderbird-ingest

## Sicherheitsregeln

- Keine Passwörter extrahieren.
- Keine logins.json, key4.db, Cookies oder Tokens verarbeiten.
- Keine vollständigen Mailinhalte in Discord posten.
- Keine personenbezogenen Details unredigiert posten.
- Nur minimaler Betreff-/Status-/Trefferkontext.
- Vor Commit immer Secret-Scan.

## Discord-Update Vorlage

WF-034 askmail Thunderbird Integration stable.

Status:
- /run askmail funktioniert.
- Thunderbird-Mail-RAG liefert lokale Treffer.
- secret_scan: OK_NO_SECRET_PATTERN.
- Git clean.
- 409 Conflict bereinigt.
- Nur Skill-Bot + Discord Router aktiv.

Nutzung:
- /run askmail Bewerbung
- /run askmail Jobcenter
- /run askmail Rechnung

Sicherheitslinie:
Keine Credentials, keine Passwörter, keine Tokens, keine Roh-Mailinhalte in Discord.
