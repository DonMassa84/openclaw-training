# Shadowmaker Automation Commands – Memory-Wiki

## Hauptbefehle

shadowmaker-timeshift-now
shadowmaker-freeze-report
shadowmaker-safe-push-now
shadowmaker-memory-wiki-now
shadowmaker-env-show
shadowmaker-env-edit
shadowmaker-env-load

## Abschlusssequenz nach stabilem Umbau

shadowmaker-timeshift-now
shadowmaker-freeze-report
shadowmaker-safe-push-now
shadowmaker-memory-wiki-now

## Status prüfen

systemctl --user status shadowmaker-discord-agent-router.service --no-pager -l
systemctl --user status shadowmaker-control-bot.service --no-pager -l
systemctl --user status shadowmaker-telegram-ask.service --no-pager -l
systemctl --user status schatten-watch-bot.service --no-pager -l
systemctl --user status schatten-backup-bot.service --no-pager -l
ss -lntp | grep -E ':(3000|18789|11434)\b' || true
ollama list

## Logs prüfen

journalctl --user -u shadowmaker-discord-agent-router.service -n 120 --no-pager
journalctl --user -u shadowmaker-control-bot.service -n 120 --no-pager
journalctl --user -u shadowmaker-telegram-ask.service -n 120 --no-pager
journalctl --user -u schatten-watch-bot.service -n 120 --no-pager
journalctl --user -u schatten-backup-bot.service -n 120 --no-pager

## Discord Tests

/status
/winky
/courier
/ask prompt: Antworte exakt nur mit ENV_OK
/ask prompt: Wer bist du?

## Telegram Tests

/start
/status
/ask Antworte exakt nur mit TG_OK
/ask Wer bist du?
/freeze_report

## Master Env

shadowmaker-env-show
shadowmaker-env-edit
shadowmaker-env-load
ls -l ~/.config/shadowmaker/shadowmaker.env

## Service Restart nach Env-Änderung

systemctl --user daemon-reload
systemctl --user restart shadowmaker-discord-agent-router.service
systemctl --user restart shadowmaker-control-bot.service
systemctl --user restart shadowmaker-telegram-ask.service
systemctl --user restart schatten-watch-bot.service
systemctl --user restart schatten-backup-bot.service

## Problemservices stoppen

systemctl --user stop openclaw-bot.service openclaw-telegram-bot.service wallpaper-4mon-slideshow.service || true
systemctl --user disable openclaw-bot.service openclaw-telegram-bot.service wallpaper-4mon-slideshow.service || true
systemctl --user reset-failed openclaw-bot.service openclaw-telegram-bot.service wallpaper-4mon-slideshow.service || true

## Git

cd ~/openclaw_training
git status --short
git log -5 --oneline
git remote -v
shadowmaker-safe-push-now

## Freeze

shadowmaker-freeze-report
cat ~/openclaw_training/docs/status/latest_shadowmaker_freeze_report.md

## Timeshift

shadowmaker-timeshift-now
timeshift --list

## Memory-Wiki

shadowmaker-memory-wiki-now
cat ~/openclaw_training/docs/memory_wiki/latest_shadowmaker_memory_wiki.md

## Lokale Modelle

ollama list
curl -fsS http://127.0.0.1:11434/api/tags

## Portcheck

ss -lntp | grep -E ':(3000|18789|11434)\b' || true
curl -fsS http://127.0.0.1:11434/api/tags >/dev/null && echo OLLAMA_OK || echo OLLAMA_FAIL
curl -fsS http://127.0.0.1:3000 >/dev/null && echo WEBUI_OK || echo WEBUI_FAIL
curl -fsS http://127.0.0.1:18789 >/dev/null && echo OPENCLAW_GATEWAY_OK || echo OPENCLAW_GATEWAY_CHECK

## Stabiler Betriebsmodus

Keine neuen Services ohne Wartungsblock.
Keine Bot-Änderungen ohne Freeze davor.
Keine Git-History-Rewrites im produktiven Zustand.
Keine Token-Rotation spontan.
Nach jeder Änderung: Test, Timeshift, Freeze, Safe Push, Memory-Wiki.

## Token-Rotation Wartungsblock

1. Tokens/Webhooks/OAuth in den jeweiligen Anbieter-UIs neu erzeugen.
2. Master Env aktualisieren.
3. Telegram Webhooks löschen.
4. Services neu starten.
5. Discord /ask testen.
6. Telegram /ask testen.
7. /freeze_report testen.
8. Timeshift erstellen.
9. Freeze Report erstellen.
10. Safe Push ausführen.
11. Memory-Wiki Abschluss posten.

## Rollback-Prinzip

cp -a ~/.config/shadowmaker/backups/<backup-datei> ~/.config/shadowmaker/shadowmaker.env
chmod 600 ~/.config/shadowmaker/shadowmaker.env
systemctl --user daemon-reload
systemctl --user restart shadowmaker-discord-agent-router.service shadowmaker-control-bot.service shadowmaker-telegram-ask.service schatten-watch-bot.service schatten-backup-bot.service
