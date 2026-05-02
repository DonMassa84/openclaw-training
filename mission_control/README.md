
# Shadowmaker Mission Control

## Zweck

Mission Control ist die zentrale Kontrollschicht für den lokalen OpenClaw-/CrashBandicot-/Flowise-/n8n-Stack.

## Zielzustand

```text
Telegram Control: CrashBandicot
OpenClaw Runtime: container-intern OK
Flowise: Workflow Builder
n8n: Automation Hub
Mission Control: Dokumentation, Logs, Projekte, Agentenrollen, Memory
```

## OpenClaw-Sonderregel

```text
OpenClaw Host HTTP kann FAIL/Reset zeigen.
OpenClaw gilt als OK, wenn container-intern HTTP/1.1 200 OK geliefert wird.
```

## Standardbefehle lokal

```bash
sm-health
sm-status
sm-logs
oc-loop
oc-sec
```

## Telegram-Befehle

```text
/status
/openclaw
/telegramnet
/docker
/failed
/discordtest
```

## Nicht tun

```text
Kein blindes Rebuild
Keine weiteren Binding-Experimente
Keine Token im Chat
Keine parallele Telegram-Nutzung desselben Tokens
Kein Löschen ohne Backup
```

