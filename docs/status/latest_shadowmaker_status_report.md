# Shadowmaker Statusbericht

Stand: Sa 2. Mai 00:13:38 CEST 2026

## 1. Gesamtbewertung

| Bereich | Status |
|---|---:|
| CrashBandicot | OK |
| SchattenWatchBot | OK |
| BackupBot | OK |
| OpenClaw Container Up | YES |
| OpenClaw container-intern | YES |
| Flowise | YES |
| n8n | YES |
| Telegram IPv4 | YES |
| Telegram IPv6 | NO |

## 2. Betriebsstandard

OpenClaw gilt als funktionsfähig, wenn der container-interne Test `HTTP/1.1 200 OK` liefert.

Der Host-Test auf `http://127.0.0.1:18789` darf mit Reset/Fail reagieren und ist als Binding-Einschränkung dokumentiert.

## 3. Aktive Soll-Dienste

```text
shadowmaker-control-bot.service = OK
schatten-watch-bot.service      = OK
schatten-backup-bot.service     = OK
```

## 4. Alte Telegram-Konfliktdienste

```text
openclaw-telegram-bot.service = MISSING_OR_DISABLED
telegram-chatgpt-bot.service  = MISSING_OR_DISABLED
```

## 5. Container

```text
openclaw-openclaw-gateway-1   openclaw:local                       Up 30 minutes                127.0.0.1:18789->18789/tcp
shadowmaker-agents            flowiseai/flowise:latest             Up About an hour             0.0.0.0:3001->3000/tcp, [::]:3001->3000/tcp
shadow-command-hub            docker.n8n.io/n8nio/n8n:latest       Up About an hour             0.0.0.0:5678->5678/tcp, [::]:5678->5678/tcp
```

## 6. Health-Ergebnisse

```text
OpenClaw container-intern: YES
Flowise: YES
n8n: YES
Telegram IPv4: YES
Telegram IPv6: NO
```

## 7. Offene Punkte

1. ShadowOps Autopilot separat reparieren oder deaktivieren.
2. ShadowOps Log Push separat reparieren oder deaktivieren.
3. casper-md5check.service ist unkritisch; optional reset-failed oder ignorieren.
4. Telegram IPv6 FAIL bleibt dokumentiert; kein Eingriff nötig, solange IPv4 OK ist.

## 8. Empfohlene nächste Schritte

1. OpenClaw-Binding nicht weiter verändern.
2. CrashBandicot, SchattenWatchBot und BackupBot getrennt halten.
3. ShadowOps-Dienste separat entscheiden: reparieren oder deaktivieren.
4. Discord Webhook optional später eintragen.
5. Daily Delight Build als nächstes produktives Modul definieren.

## 9. Standardbefehle

```bash
oc-loop
sm-health
sm-status
sm-logs
watch-status
watch-logs
```

Telegram:

```text
/status
/openclaw
/docker
/stack
/ping
/whoami
```

## 10. Report-Dateien

```text
TXT: /home/schattenmacher/openclaw_training/reports/shadowmaker_status_report_20260502_001327.txt
MD:  /home/schattenmacher/openclaw_training/docs/status/shadowmaker_status_report_20260502_001327.md
```
