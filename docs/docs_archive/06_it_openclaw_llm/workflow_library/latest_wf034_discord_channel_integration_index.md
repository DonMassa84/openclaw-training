# WF-034 Discord Channel Integration Index

## Status

WF-034 askmail Thunderbird Integration wurde in die Discord-Channel-Dokumentation übernommen.

## Kernstatus

- askmail: OK
- Thunderbird-Mail-RAG: OK
- Telegram Skill Bot: OK
- Discord Router: OK
- secret_scan: OK_NO_SECRET_PATTERN
- Git clean: erwartet
- 409 Conflict: bereinigt

## Channel Docs

- docs/discord_channels/latest_askmail_thunderbird_channel_doc.md
- docs/discord_channels/latest_openclaw_status_channel_doc.md
- docs/discord_channels/latest_security_control_channel_doc.md
- docs/discord_channels/latest_docs_archive_channel_doc.md
- docs/discord_channels/latest_ihk_training_channel_doc.md
- docs/discord_channels/latest_housing_jobcenter_channel_doc.md
- docs/discord_channels/latest_finance_control_channel_doc.md
- docs/discord_channels/latest_agent_control_channel_doc.md

## Wichtigste Telegram-Kommandos

- /run askmail Bewerbung
- /run askmail Jobcenter
- /run askmail Rechnung
- /run askdocs WF-034 Thunderbird
- /run ask OpenClaw RAG Status
- /run secret_scan
- /run all_status

## Discord Master Post

WF-034 Thunderbird askmail Integration stable.

Thunderbird ist jetzt als lokale Kommunikations- und Dokumentenquelle in ShadowMaker/OpenClaw integriert.

Pipeline:
Thunderbird → lokaler Index → askmail → Telegram Skill Bot → Discord-Doku.

Validiert:
- /run askmail Bewerbung: OK
- /run askmail Jobcenter: OK
- secret_scan: OK_NO_SECRET_PATTERN
- Git clean
- 409 Conflict bereinigt
- nur Skill-Bot + Discord Router aktiv

Sicherheitslinie:
Keine Credentials, keine Passwörter, keine Tokens, keine Roh-Mailinhalte in Discord.
