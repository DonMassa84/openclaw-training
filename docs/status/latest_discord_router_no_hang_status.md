# Discord Router No-Hang Status

Stand: Do 7. Mai 18:28:20 CEST 2026

## Ergebnis

Discord Agent Router wurde auf No-Hang-Modus gepatcht.

## Änderungen

- Slash Commands bleiben aktiv.
- Kein Message Content Intent.
- /status wird in Thread ausgelagert.
- Agentenläufe haben Timeout.
- Fehler werden als Discord-Follow-up zurückgegeben.
- Alte "denkt nach"-Hänger sollen vermieden werden.

## Test in Discord

```text
/status
/winky
/latest agent:winky
```

## Service

shadowmaker-discord-agent-router.service

## Report

/home/schattenmacher/openclaw_training/reports/repair_discord_router_no_hang_allinone_20260507_182814.txt
