# Security Audit Discord Timer Status

Stand: Sa 2. Mai 06:33:57 CEST 2026

## Status

```text
Security Audit Discord Timer: OK
Service: shadowmaker-security-audit-discord.service
Timer: shadowmaker-security-audit-discord.timer
Cadence: täglich 09:00 und 21:00 Uhr
RandomizedDelaySec: 120 Sekunden
Persistent: true
Discord Channel: #security-audit
Runner: /home/schattenmacher/openclaw_training/scripts/run_security_audit_discord_timer.sh
Service File: /home/schattenmacher/.config/systemd/user/shadowmaker-security-audit-discord.service
Timer File: /home/schattenmacher/.config/systemd/user/shadowmaker-security-audit-discord.timer
Report: /home/schattenmacher/openclaw_training/reports/setup_security_audit_discord_timer_allinone_20260502_063352.txt
```

## Lokale Befehle

```bash
systemctl --user status shadowmaker-security-audit-discord.timer
systemctl --user status shadowmaker-security-audit-discord.service
systemctl --user list-timers --all | grep shadowmaker-security-audit
systemctl --user start shadowmaker-security-audit-discord.service
journalctl --user -u shadowmaker-security-audit-discord.service -n 80 --no-pager
```

## Betriebsregel

Der Security Audit berichtet nur. Er repariert nichts automatisch.

## Discord-Ziel

```text
#security-audit
```

## Nach erfolgreicher Einrichtung

```text
/freeze_report
```

Danach lokal:

```bash
sudo timeshift --create --comments "Shadowmaker stable freeze after automated Discord security audit timer"
```
