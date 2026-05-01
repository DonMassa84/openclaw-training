# Shadowmaker Control Stack Runbook

Stand: Fr 1. Mai 23:49:07 CEST 2026

## Zielzustand

Der Shadowmaker Control Stack läuft stabil mit Telegram-Control über CrashBandicot.

## Komponenten

| Komponente | Statuslogik |
|---|---|
| CrashBandicot Telegram Control Bot | systemd user service: shadowmaker-control-bot.service |
| OpenClaw Gateway | Docker Container: openclaw-openclaw-gateway-1 |
| Flowise | Docker Container: shadowmaker-agents |
| n8n | Docker Container: shadow-command-hub |

## Wichtige Erkenntnis

OpenClaw ist im aktuellen Docker-/Loopback-Setup container-intern erreichbar, aber der Host-HTTP-Test auf `http://127.0.0.1:18789` kann mit `Server disconnected` fehlschlagen.

Das ist derzeit als dokumentierte Einschränkung akzeptiert.

Korrekte Bewertung:

```text
Host HTTP: FAIL
Container intern: OK
Bewertung: OK - OpenClaw läuft container-intern. Host-Binding ist eingeschränkt.
```

## Telegram-Befehle CrashBandicot

```text
/start
/status
/openclaw
/telegramnet
/docker
/failed
/discordtest
```

## Lokale Befehle

```bash
~/shadowmaker_stack_status.sh
~/shadowmaker_stack_healthcheck.sh
~/shadowmaker_stack_start.sh
~/shadowmaker_stack_logs.sh
~/shadowmaker_stack_stop_controlbot_only.sh
```

## Nicht weiter anfassen

Solange OpenClaw container-intern `HTTP/1.1 200 OK` liefert:

- kein erneuter Proxy-Fix
- kein weiteres OpenClaw-Binding-Experiment
- kein Löschen von OpenClaw
- kein blindes Rebuild
- kein Telegram-Plugin in OpenClaw aktivieren, solange CrashBandicot aktiv ist

## Telegram-Token-Regel

Ein Token darf nur einem laufenden Bot-Service zugeordnet sein.

CrashBandicot nutzt den Token aus:

```text
~/shadowmaker_bots/.env
```

Token nicht in Chats posten.

## Bekannte offene Punkte

- Discord Webhook optional, aktuell leer möglich
- Telegram IPv6 kann FAIL sein, IPv4 ist relevant
- ShadowOps failed services separat reparieren, nicht mit OpenClaw mischen
- casper-md5check.service ist unkritisch

## Standardprüfung

```bash
~/shadowmaker_stack_healthcheck.sh
```

Erwartung:

```text
CrashBandicot: active/running
OpenClaw Host-Test: darf FAIL/Reset zeigen
OpenClaw container-intern: HTTP/1.1 200 OK
Flowise: erreichbar
n8n: erreichbar
```
