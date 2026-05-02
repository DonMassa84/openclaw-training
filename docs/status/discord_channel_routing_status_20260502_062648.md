# Discord Channel Routing Status

Stand: Sa 2. Mai 06:26:55 CEST 2026

## Status

```text
Discord Channel Routing: OK
Generic Sender: /home/schattenmacher/openclaw_training/scripts/discord_send_channel.sh
Daily Brief to Discord: /home/schattenmacher/openclaw_training/scripts/shadowmaker_daily_brief_to_discord.sh
Freeze Report to Discord: /home/schattenmacher/openclaw_training/scripts/shadowmaker_freeze_report_to_discord.sh
OpenClaw Status to Discord: /home/schattenmacher/openclaw_training/scripts/openclaw_status_to_discord.sh
Security Audit to Discord: /home/schattenmacher/openclaw_training/scripts/security_audit_to_discord.sh
Routing Test: /home/schattenmacher/openclaw_training/scripts/discord_channel_routing_test.sh
Report: /home/schattenmacher/openclaw_training/reports/integrate_discord_channel_routing_allinone_20260502_062648.txt
```

## Channel Mapping

```text
#system-alerts      <- allgemeine Alerts / Haupt-Webhook
#daily-brief        <- Daily Brief
#freeze-reports     <- Freeze Reports
#openclaw-status    <- OpenClaw / Flowise / n8n
#security-audit     <- Security Audit
#mission-control    <- Mission-Control-Status
```

## Lokale Befehle

```bash
discord-routing-test
daily-brief-discord
freeze-report-discord
openclaw-status-discord
security-audit-discord
discord-channel-env
discord-channels
```

## Telegram bleibt Steuerung

```text
/status
/openclaw
/discordtest
/daily_brief
/freeze_report
```

## Nächster Sicherheitsstandard

Nach erfolgreichem Test:

```text
/freeze_report
```

Dann lokal:

```bash
sudo timeshift --create --comments "Shadowmaker stable freeze after Discord channel routing"
```
