# Discord Webhook Status

Stand: Sa 2. Mai 05:37:23 CEST 2026

## Status

```text
Discord Webhook Format: OK
Discord Webhook Test: HTTP 204
CrashBandicot Restart: durchgeführt
Discord Send Script: /home/schattenmacher/openclaw_training/scripts/discord_send.sh
Discord Stack Script: /home/schattenmacher/openclaw_training/scripts/discord_stack_report.sh
```

## Maskierter Webhook

```text
https://discordapp.com/api/webhook***76SAI1ldzD
```

## Nutzung

Lokal:

```bash
~/discord_send.sh "Testnachricht"
~/discord_stack_report.sh
```

Telegram an CrashBandicot:

```text
/discordtest
```

## Ziel

Discord ergänzt Telegram als Alert-/Report-Kanal.

Empfohlene Channels:
- #system-alerts
- #daily-brief
- #freeze-reports
- #projects
- #security

## Report

```text
/home/schattenmacher/openclaw_training/reports/finalize_discord_webhook_crashbandicot_20260502_053638.txt
```
