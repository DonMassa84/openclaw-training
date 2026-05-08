# Discord Channel Doc — openclaw-status

## Zweck

Statuskanal für OpenClaw/ShadowMaker Runtime, RAG, Telegram Skill Bot und Discord Router.

## Grüner Sollstatus

- ShadowMaker Telegram Skill Bot: active/running
- Discord Agent Router: active/running
- askmail: OK
- secret_scan: OK_NO_SECRET_PATTERN
- Git: clean
- 409 Conflict: bereinigt

## Standard-Kommandos

Telegram:

- /run all_status
- /run health
- /run secret_scan
- /run ask OpenClaw RAG Status

Lokal:

- systemctl --user list-units --type=service | grep -Ei 'telegram|shadow|bot|agent'
- journalctl --user -u shadowmaker-telegram-skill-bot.service --since "2 minutes ago" --no-pager
- ~/.local/bin/shadowmaker-telegram-skill-bot-selfscan

## 409-Regel

Ein Telegram Bot Token = ein aktiver getUpdates-Poller.

Bei Konflikt:
- alle lokalen Telegram-Poller stoppen
- Webhook löschen
- pending updates droppen
- nur shadowmaker-telegram-skill-bot starten
