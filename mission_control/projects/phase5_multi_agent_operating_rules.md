# Phase 5 Operating Rules – Multi-Agent Crew

## Ziel

Die Multi-Agent Crew wird schrittweise produktiv gemacht.

## Grundsatz

Nur ein Agent wird zuerst produktiv aktiviert: Winky als System-Monitor.

## Sicherheitsgrenzen

- kein sudo
- keine freie Shell-Ausführung
- keine Löschung
- keine Secrets ausgeben
- keine E-Mail-Automation
- keine Finanztransaktion
- keine destruktive Autonomie
- keine Änderung an OpenClaw Binding, Docker-Port, Telegram-Core, Discord-Webhooks oder Timeshift

## Aktivierungslogik

1. Agent definieren
2. Agent read-only ausführen
3. Output dokumentieren
4. Discord-Meldung senden
5. Git committen
6. Freeze Report
7. Timeshift

## Aktiver Agent

Winky – System Monitor

## Passive Rollen

- Mentor – IHK/MFP
- Strategist – Career IT
- Steward – Finance/Housing read-only
- Linky – Builder / Prompt-to-Code
- Mnemosyne – Memory Curator
- CrashBandicot – Control Agent
