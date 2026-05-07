# Discord Router Slash Status

Stand: Do 7. Mai 18:04:43 CEST 2026

## Ergebnis

Discord Agent Router wurde auf Slash Commands umgestellt.

## Grund

Der vorherige Bot nutzte Message Content Intent und scheiterte mit:

```text
PrivilegedIntentsRequired
```

## Neue Befehle

```text
/hilfe
/status
/winky
/mnemosyne
/courier
/mentor
/strategist
/steward
/linky
/latest agent:winky
```

## Vorteil

Slash Commands brauchen keinen Message Content Intent.

## Wichtig

Der Bot muss mit diesen OAuth2 Scopes eingeladen sein:

```text
bot
applications.commands
```

## Sicherheitsstatus

- keine freie Shell
- kein sudo
- keine Löschung
- keine Timer-Aktivierung
- keine Mail-Aktion
- Allowlist bleibt aktiv

## Report

/home/schattenmacher/openclaw_training/reports/repair_discord_router_slash_no_privileged_intent_allinone_20260507_180443.txt
