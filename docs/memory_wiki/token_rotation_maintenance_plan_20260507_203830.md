# Shadowmaker Wartungsblock – Token-Rotation

## Zweck

Diese Vorlage ist für einen späteren kontrollierten Wartungsblock gedacht. Nicht spontan im laufenden Betrieb ausführen.

## Reihenfolge

1. Discord Bot Token rotieren
2. Discord Webhooks rotieren
3. Telegram Tokens rotieren
4. Google OAuth Secret rotieren
5. Master .env aktualisieren
6. Telegram Webhooks löschen, damit Polling sauber läuft
7. systemd Services neu starten
8. Discord /ask testen
9. Telegram /ask testen
10. /freeze_report testen
11. Timeshift Snapshot erstellen
12. Freeze Report erstellen
13. Safe Git Push ausführen
14. Memory-Wiki Abschluss posten

## Zentrale Datei

~/.config/shadowmaker/shadowmaker.env

## Betroffene Services

shadowmaker-discord-agent-router.service
shadowmaker-control-bot.service
shadowmaker-telegram-ask.service
schatten-watch-bot.service
schatten-backup-bot.service
shadowmaker-security-audit-discord.service

## Nach Rotation testen

Discord:
- /status
- /ask prompt: Antworte exakt nur mit ENV_OK

Telegram:
- /status
- /ask Antworte exakt nur mit TG_OK
- /freeze_report

## Abschlussbefehle nach erfolgreichem Test

shadowmaker-timeshift-now
shadowmaker-freeze-report
shadowmaker-safe-push-now
shadowmaker-memory-wiki-now

## Rollback-Prinzip

Vor jeder Änderung muss ~/.config/shadowmaker/shadowmaker.env nach ~/.config/shadowmaker/backups/ gesichert werden.

Rollback:
1. Backup zurückkopieren
2. chmod 600 ~/.config/shadowmaker/shadowmaker.env
3. systemctl --user daemon-reload
4. Services neu starten
5. Discord und Telegram testen

## Betriebsregel

Keine Git-History-Rewrites während der Token-Rotation.
Keine neuen Bots.
Keine neuen Services.
Keine OpenClaw-Konfigänderung.
Nur Token-/Webhook-/OAuth-Austausch, Tests, Freeze, Push.
