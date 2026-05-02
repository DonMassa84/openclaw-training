# Security Audit Plan

Ziel:
Tägliche Sicherheitsprüfung vorbereiten, zunächst ohne automatische Änderungen.

Cadence:
23:00 täglich, später über n8n oder systemd timer.

Report-Ziel:
Discord #alerts oder Telegram CrashBandicot.

Prüfpunkte:
- Docker Container
- OpenClaw intern
- Flowise
- n8n
- Telegram IPv4/IPv6
- Failed Services
- Secrets redacted
- Git Status
- Freeze Report vorhanden
- Timeshift Snapshot vorhanden

Regel:
Security Audit darf initial nur berichten, nicht reparieren.
