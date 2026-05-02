
# agents.md – Agentenrollen

## Primäragent: CrashBandicot

```text
Telegram Control
Systemstatus
OpenClaw-Check
Docker-Check
Telegram-Netzwerkcheck
Failed Services
Discord-Test
```

## Backup-Agent: Shadowbot

```text
Backup-Status
Snapshot-Archiv
History-Log
```

## OpenClaw Gateway

```text
Agent Runtime
OpenClaw Control UI
interner Gateway-Status
```

## Flowise

```text
Workflow- und Agent-Builder
visuelle Pipeline-Entwicklung
```

## n8n

```text
Automation Hub
Cron-/Webhook-/Workflow-Orchestrierung
```

## Zukünftige Agentenrollen

```text
Scout       = tägliche Recherche / Themen / Systembeobachtung
Analyst     = tiefe Auswertung / Entscheidungsvorlagen
Builder     = Code / Skripte / Automationen
Archivist   = Dokumentation / Logs / Memory
Watchdog    = Healthcheck / Security / Alerts
Finance     = Kostenkontrolle / API-Nutzung / Budget
```


## 2026-05-02 - Agent Operating Rules

Jeder Agent dokumentiert:
1. Was geändert wurde.
2. Warum es geändert wurde.
3. Welche Datei betroffen ist.
4. Welcher Report erstellt wurde.
5. Ob Freeze/Timeshift erforderlich ist.

Keine Foundation-Änderung ohne Freeze:
- OpenClaw Binding
- Docker-Port 18789
- Telegram Bot Core
- CrashBandicot Core
- Timeshift-Konfiguration
