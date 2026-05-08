# Discord Channel Doc — agent-control

## Zweck

Operative Steuerung der ShadowMaker-/OpenClaw-Agenten.

## Aktive Runtime

- shadowmaker-telegram-skill-bot.service
- shadowmaker-discord-agent-router.service

## Telegram-Kommandos

- /run all_status
- /run health
- /run restart_bots
- /run all_logs
- /run secret_scan

## Betriebsregel

Keine freie Shell über Telegram. Nur Allowlist-Skills.
