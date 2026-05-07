# Security Audit Prompt

## Zweck

OpenClaw Security Audit auf Basis offizieller Gateway-Security-Dokumentation planen.

## Prompt

Use <INSERT AGENT NAME> to run a security audit based on this documentation https://docs.openclaw.ai/gateway/security. Run it at 11pm everyday and report back to #alerts channel.

## Lokale Shadowmaker-Anpassung

Nicht direkt täglich aktivieren, ohne vorherigen lokalen Dry Run.

Sichere Umsetzung:

1. Security Audit read-only.
2. Keine Secrets ausgeben.
3. Redacted config.
4. Discord nur Kurzstatus.
5. Timer nur nach Freigabe.
6. Aktuell sind bereits aktiv:
   - openclaw-security-health.timer
   - shadowmaker-security-audit-discord.timer

## Aktuelle Entscheidung

Keine neuen Security-Timer aktivieren, solange vorhandene Timer laufen.
