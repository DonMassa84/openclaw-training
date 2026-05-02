# Shadowmaker Discord Channel Plan

Stand: automatisch erstellt

## Ziel

Discord wird als strukturierter Alert-, Daily-Brief-, Projekt- und Agenten-Kanal genutzt. Telegram bleibt operative Steuerung. Discord ersetzt Telegram nicht.

## Kategorie: 00-command-center

### #system-alerts
Zweck: Kritische Systemmeldungen, Discord-Test, Stack-Warnungen.

### #daily-brief
Zweck: täglicher Shadowmaker Daily Brief.

### #freeze-reports
Zweck: Freeze-Report-Ausgaben, Archivpfade, SHA256.

### #openclaw-status
Zweck: OpenClaw intern, Flowise, n8n, Docker, Host-Binding-Hinweise.

## Kategorie: 10-operations

### #mission-control
Zweck: zentrale Übersicht, Aufgaben, Projektsteuerung, Betriebsentscheidungen.

### #agent-logs
Zweck: Agentenaktivitäten, Laufzeitlogs, Aktionen.

### #security-audit
Zweck: Security-/Healthcheck, offene Ports, Services, Secrets redacted.

### #incident-review
Zweck: Fehleranalyse, Maßnahmen, Postmortem.

## Kategorie: 20-projects

### #daily-delight
Zweck: tägliche produktive Build-Idee / Ergebnis.

### #openclaw-projects
Zweck: OpenClaw-Module, Prompt-to-Code, Integrationen.

### #automation-n8n-flowise
Zweck: n8n, Flowise, Automationspläne.

### #memory-wiki
Zweck: Memory, Wiki, Soul, Agents, Daily Logs.

## Kategorie: 30-personal-strategy

### #ihk-mfp
Zweck: IHK Mitarbeiterführung & Personalmanagement, SA1/SA2, Lernsystem.

### #career-it
Zweck: Bewerbungen, IT-Rollen, AI-Agent-Portfolio.

### #finance-control
Zweck: Budget, Rücklagen, Schulden, leiser Wohlstand.

### #housing-jobcenter
Zweck: WBS, Wohnung, Jobcenter, Nachweise.

## Betriebsregel

Telegram:
- /status
- /openclaw
- /daily_brief
- /discordtest
- /freeze_report

Discord:
- Alerts und Reports
- tägliche Übersicht
- Projekt- und Memory-Struktur

Vor jeder größeren Änderung:
1. /freeze_report
2. lokaler Timeshift-Snapshot
3. Git-Commit
