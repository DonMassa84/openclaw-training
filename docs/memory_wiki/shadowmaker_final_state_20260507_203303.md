# Shadowmaker Memory-Wiki – Stabiler Endstand

Datum: Do 7. Mai 20:33:03 CEST 2026

## Zielkanal

- Discord Channel: #memory-wiki
- Channel ID: 1499989343270600795
- Env Variable: DISCORD_MEMORY_WIKI_CHANNEL_ID=1499989343270600795

## GitHub

- Repository: https://github.com/DonMassa84/openclaw-training.git
- Branch: main
- HEAD: f87b688
- Commit: docs: save Shadowmaker final state to memory wiki 20260507_203106
- Push-Status: OK

## Kernstatus

- Discord /ask: OK
- Telegram /ask: OK
- Telegram /freeze_report: OK
- Master .env: OK
- Timeshift: OK
- Freeze Report: OK
- Safe Git Push: OK
- Secret-Scan: OK
- Große Dateien >95MB: OK
- GitHub Push Protection: OK

## Services

| Service | Status |
|---|---|
| shadowmaker-discord-agent-router.service | active |
| shadowmaker-telegram-ask.service | active |
| shadowmaker-control-bot.service | active |
| schatten-watch-bot.service | active |
| schatten-backup-bot.service | active |
| shadowmaker-timeshift-auto.timer | enabled |
| shadowmaker-safe-push-auto.timer | enabled |

## Lokale Ports

```text
LISTEN 0      4096         0.0.0.0:3000       0.0.0.0:*                                        
LISTEN 0      4096       127.0.0.1:18789      0.0.0.0:*                                        
LISTEN 0      4096       127.0.0.1:11434      0.0.0.0:*    users:(("ollama",pid=1375,fd=3))    
LISTEN 0      4096            [::]:3000          [::]:*                                        
```

## Lokale Modelle

```text
NAME                       ID              SIZE      MODIFIED     
qwen2.5:3b                 357c53fb659c    1.9 GB    3 weeks ago     
nomic-embed-text:latest    0a109f422b47    274 MB    3 weeks ago     
llama3.1:8b                46e0c10c039e    4.9 GB    3 weeks ago     
mistral:7b                 6577803aa9a0    4.4 GB    3 weeks ago     
qwen2.5-coder:14b          9ec8897f747e    9.0 GB    3 weeks ago     
qwen2.5:7b                 845dbda0ea48    4.7 GB    2 months ago    
```

## Standardmodelle

- Fast Ask: qwen2.5:3b
- Quality Ask: qwen2.5:7b
- Coder: qwen2.5-coder:14b
- Embedding: nomic-embed-text:latest

## Wichtige Pfade

- Master Env: ~/.config/shadowmaker/shadowmaker.env
- OpenClaw Training: ~/openclaw_training
- Discord Router: ~/openclaw_training/mission_control/discord_agent_router
- Telegram Ask Agent: ~/openclaw_training/mission_control/telegram_ask_agent
- Latest Freeze Report: /home/schattenmacher/openclaw_training/docs/status/latest_shadowmaker_freeze_report.md

## Bedienung

```text
Discord:
/status
/winky
/courier
/ask prompt: ...

Telegram:
/start
/status
/ask ...
/freeze_report
```

## Nicht mehr anfassen

- Keine neuen Services
- Keine Bot-Änderungen
- Keine Git-History-Rewrites
- Keine Token-Migration im Betriebsfluss
- Keine OpenClaw-Konfigänderung ohne Wartungsblock

## Separater Wartungsblock später

- Discord Bot Token rotieren
- Discord Webhooks rotieren
- Telegram Tokens rotieren
- Google OAuth Secret rotieren
- Danach: Freeze + Safe Push
