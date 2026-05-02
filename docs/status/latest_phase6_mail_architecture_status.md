# Phase 6 Mail Architecture Status

Stand: Sa 2. Mai 10:49:23 CEST 2026

## Ergebnis

Mail-Architektur wurde umgestellt.

## Aktiv

- Gmail über ChatGPT Gmail Connector/App
- Proton lokal über Proton Bridge + Courier
- Courier read-only
- Discord nur Kurzstatus

## Deaktiviert lokal

- lokales Gmail OAuth in Courier
- GMAIL_ENABLED=0

## Pfade

Courier ENV:
/home/schattenmacher/openclaw_training/mission_control/mail_briefing/config/courier.env

Architektur:
/home/schattenmacher/openclaw_training/mission_control/mail_briefing/latest_mail_architecture.md

Latest Courier Brief:
/home/schattenmacher/openclaw_training/mission_control/mail_briefing/briefs/latest_courier_mail_brief.md

Report:
/home/schattenmacher/openclaw_training/reports/phase6_set_gmail_app_proton_local_allinone_20260502_104921.txt

## Nächste Befehle

```bash
source ~/.bashrc
courier-status
courier-run
courier-latest
```

## Nach stabilem Test

```text
/freeze_report
sudo timeshift --create --comments "Shadowmaker stable freeze after Phase 6 Gmail App Proton Local"
sudo timeshift --list
```
