
# memory.md – Langzeitgedächtnis

## Systemstand

```text
CrashBandicot Telegram Control Bot läuft als systemd user service:
shadowmaker-control-bot.service

OpenClaw Gateway Container:
openclaw-openclaw-gateway-1

OpenClaw Host HTTP:
FAIL/Reset möglich und dokumentiert

OpenClaw container-intern:
HTTP/1.1 200 OK = maßgeblicher OK-Zustand

Flowise:
http://127.0.0.1:3001

n8n:
http://127.0.0.1:5678
```

## Wichtige Regel

Nicht weiter am OpenClaw-Binding drehen, solange container-intern OK ist.

## Telegram

CrashBandicot ist Control Bot.

Befehle:

```text
/status
/openclaw
/telegramnet
/docker
/failed
/discordtest
```

## Tokens

Ein Telegram-Token darf nur einem laufenden Bot-Service zugeordnet sein.

## 2026-05-02 - OpenClaw Prompt Archiv integriert

Die Inhalte aus OpenClaw Prompts.pdf wurden als lokales Prompt-Archiv unter `/home/schattenmacher/openclaw_training/prompts/openclaw_prompts` integriert.

Wichtige Entscheidungen:
- Hardware-Entscheidung abgeschlossen: vorhandene dedizierte 32GB+ Maschine verwenden.
- Daily Brief ist erstes produktives Projekt.
- Mission Control wird phasenweise geplant.
- Multi-Agent-System wird erst entworfen, dann einzeln gebaut.
- Security Audit zunächst nur als Report-Modul.
- Vor jeder größeren Änderung: /freeze_report + lokaler Timeshift-Snapshot.
