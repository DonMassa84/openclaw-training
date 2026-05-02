# Security Audit Prompt

Ziel:
Regelmäßige Sicherheitsprüfung für OpenClaw/Gateway/Bots.

Prompt:
Use Sentinel to run a security audit based on OpenClaw gateway security documentation. Run it at 23:00 every day and report back to #alerts.

Shadowmaker-Anpassung:
Security Audit darf zunächst nur dokumentieren, nicht automatisch verändern.

Prüfpunkte:
- Offene Ports
- Docker Container
- Bot Tokens vorhanden, aber redacted
- Discord Webhook vorhanden
- OpenClaw Host-Binding dokumentiert
- Telegram IPv4/IPv6
- Failed Services
- Freeze Report vorhanden
- Timeshift Snapshot vorhanden
- Git-Status
- Keine Secrets in Reports

Nächster Schritt:
Erst als Report-Modul bauen, danach optional n8n-Schedule.
