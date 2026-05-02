# Phase 4 Operating Rules – Mission Control Web-UI

## Ziel

Read-only Mission-Control-Weboberfläche für echte lokale Daten.

## Grundsatz

Keine Mockdaten. Das Dashboard liest vorhandene Dateien aus:

- openclaw_training/mission_control
- openclaw_training/docs/status
- openclaw_training/reports
- ~/.openclaw/workspace, falls vorhanden

## Grenzen

Nicht verändern:

- OpenClaw Binding
- Docker-Port 18789
- Telegram-Core
- Discord-Webhooks
- Timeshift-Konfiguration
- Secrets / .env / Tokens

## Sicherheit

- Keine Secret-Inhalte lesen
- Keine Schreibaktionen über UI
- Keine Löschung
- Kein sudo
- Keine externen Uploads
- Web-UI läuft lokal auf localhost
