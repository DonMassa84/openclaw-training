
# Mapping: Tina-Huang-OpenClaw-System → Shadowmaker-System

## 1. Hardware Selection

Video-Prinzip:

```text
OpenClaw nicht unkontrolliert auf dem persönlichen Hauptsystem betreiben.
Besser isoliert: alter Laptop, dedizierter Mini-PC/Mac Mini, VPS oder sauberer Container-/VM-Stack.
```

Shadowmaker-Umsetzung:

```text
Docker-basierter lokaler Stack
OpenClaw Gateway im Container
CrashBandicot als separater Telegram-Control-Bot
Flowise und n8n getrennt als eigene Container
Runbooks und Healthchecks
```

## 2. Download & Onboarding Wizard

Video-Prinzip:

```text
OpenClaw bewusst onboarden:
Modellstrategie
Skills
Kommunikation
Dashboard/Web UI
```

Shadowmaker-Umsetzung:

```text
OpenClaw läuft.
OpenClaw-Telegram-Plugin bleibt deaktiviert, um Token-/Polling-Konflikte zu vermeiden.
CrashBandicot übernimmt Telegram-Control.
```

## 3. Custom Mission Control

Video-Prinzip:

```text
Mission Control ist zentrale Übersicht für Agenten, Tasks, Projekte, Logs, Memory und Docs.
```

Shadowmaker-Umsetzung:

```text
~/openclaw_training/mission_control/
```

Module:

```text
agents/
daily_logs/
memory/
projects/
security/
tasks/
content/
finance/
```

## 4. Telegram

Video-Prinzip:

```text
Telegram ist der einfachste Kommunikationskanal.
```

Shadowmaker-Umsetzung:

```text
CrashBandicot Telegram Control Bot
```

Befehle:

```text
/start
/status
/openclaw
/telegramnet
/docker
/failed
/discordtest
```

## 5. Discord

Video-Prinzip:

```text
Discord ist stärker für mehrere Channels, parallele Projekte und strukturierte Alerts.
```

Shadowmaker-Umsetzung:

```text
Discord optional.
Webhook wird nur lokal in ~/shadowmaker_bots/.env gesetzt.
```

Empfohlene Channels:

```text
#general
#system-alerts
#daily-digest
#openclaw
#flowise
#n8n
#research
#build-log
#security
#memory
#projects
#finance
```

## 6. Build Projects

Video-Prinzip:

```text
OpenClaw soll proaktiv nützliche Dinge bauen.
```

Shadowmaker-Umsetzung:

```text
Daily Delight Build
Personal Digest Pipeline
Prompt-to-Code Stabilization
```

## 7. GitHub / Version Control

Video-Prinzip:

```text
Alle wichtigen Dateien versionieren, damit Fortschritt nicht verloren geht.
```

Shadowmaker-Umsetzung:

```bash
cd ~/openclaw_training
git status
git add docs prompts mission_control scripts
git commit -m "update shadowmaker control system"
```

## 8. Multi-Agent Framework

Video-Prinzip:

```text
Große Workflows auf mehrere Agentenrollen verteilen.
```

Shadowmaker-Rollen:

```text
Control     = CrashBandicot
Backup      = Shadowbot
Scout       = Recherche
Analyst     = Bewertung
Builder     = Umsetzung
Archivist   = Dokumentation
Watchdog    = Health/Security
Finance     = Kostenkontrolle
```

## 9. Security Check

Video-Prinzip:

```text
Security-/Healthcheck regelmäßig ausführen, ideal zweimal täglich.
```

Shadowmaker-Umsetzung:

```bash
~/openclaw_security_health_twice_daily.sh
systemctl --user list-timers | grep openclaw-security-health
```

## 10. Memory Fixes

Video-Prinzip:

```text
Agenten brauchen aggressive Notizen, Daily Logs, Memory-Dateien und konsolidierte Erinnerung.
```

Shadowmaker-Dateien:

```text
~/openclaw_training/mission_control/agents/soul.md
~/openclaw_training/mission_control/agents/user.md
~/openclaw_training/mission_control/agents/memory.md
~/openclaw_training/mission_control/agents/agents.md
~/openclaw_training/mission_control/agents/heartbeat.md
```

## 11. Advanced Workflows

Video-Prinzip:

```text
Funktionierende promptbasierte Workflows müssen in Code stabilisiert werden.
```

Shadowmaker-Umsetzung:

```text
All-in-one Bash
Python-Skripte
systemd Timer
n8n Workflows
Flowise Pipelines
Git-Versionierung
```

## Aktueller Betriebsstandard

```text
CrashBandicot: aktiv
OpenClaw Host HTTP: darf FAIL/Reset zeigen
OpenClaw container-intern: HTTP/1.1 200 OK
Flowise: OK
n8n: OK
```

