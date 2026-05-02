# OpenClaw Brief – Lokale KI-Systemdokumentation

Stand: Sa 2. Mai 12:13:52 CEST 2026

## Mission

Dokumentiere und pflege den lokalen KI-/Agenten-Stack als operatives System.

## Aktueller Stand

Die lokale KI-Infrastruktur besteht aus:
- OpenClaw
- Mission Control WebUI
- Open WebUI
- Flowise
- n8n
- Multi-Agent Crew
- Courier Mail Briefing
- RAG-/IHK-Trainingssystem
- LoRA-/Datenpipeline
- Freeze-/Timeshift-Sicherungslogik

## Regeln

- Keine Secrets lesen.
- Keine .env-Inhalte ausgeben.
- Keine Tokens kopieren.
- Keine Mails senden.
- Keine Löschung.
- Kein sudo.
- Keine Timer aktivieren ohne separate Freigabe.
- Erst dokumentieren, dann entscheiden.

## Relevante lokale Dokumentation

```text
/home/schattenmacher/openclaw_training/mission_control/docs/local_ai_inventory/latest_local_ai_system_documentation.md
/home/schattenmacher/openclaw_training/mission_control/docs/local_ai_inventory/local_ai_paths_20260502_121342.txt
/home/schattenmacher/openclaw_training/docs/status/latest_local_ai_openclaw_documentation_status.md
```

## Operative Befehle

```bash
winky-run
mnemosyne-run
mentor-run
strategist-run
steward-run
linky-run
courier-run
mission-control-webui-status
deep-security-check
```

## Erwartetes Verhalten für OpenClaw

Bei Fragen zum lokalen KI-System:
1. zuerst diese Dokumentation lesen
2. dann aktuellen Status über Winky/Statusdateien prüfen
3. keine Reparatur ohne Freigabe
4. keine Secrets in Reports
5. Änderungen immer mit Report, Git Commit, Freeze Report und Timeshift absichern

