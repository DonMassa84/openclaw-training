# Discord Agent Router Status

Stand: Do 7. Mai 17:52:56 CEST 2026

## Ergebnis

Discord Agent Router wurde installiert.

## Funktion

Discord-Befehl führt nur fest erlaubte lokale Agenten aus.

## Befehle

```text
!help
!status
!winky
!mnemosyne
!courier
!mentor
!strategist
!steward
!linky
!latest winky
!latest courier
```

## Sicherheitsgrenzen

- keine freie Shell
- kein sudo
- keine Löschung
- keine Timer-Aktivierung
- keine Mail-Sendung
- keine Mail-Löschung
- keine Archivierung
- keine Labels
- nur erlaubte Discord User IDs
- optional nur erlaubte Channel IDs

## Pfade

Bot:
/home/schattenmacher/openclaw_training/mission_control/discord_agent_router/discord_agent_router.py

ENV:
/home/schattenmacher/openclaw_training/mission_control/discord_agent_router/config/discord_agent_router.env

Service:
/home/schattenmacher/.config/systemd/user/shadowmaker-discord-agent-router.service

Report:
/home/schattenmacher/openclaw_training/reports/setup_discord_agent_router_allinone_20260507_175127.txt

## Steuerung

```bash
systemctl --user status shadowmaker-discord-agent-router.service --no-pager
systemctl --user restart shadowmaker-discord-agent-router.service
journalctl --user -u shadowmaker-discord-agent-router.service -n 80 --no-pager
```
