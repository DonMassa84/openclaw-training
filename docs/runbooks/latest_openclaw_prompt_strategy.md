# OpenClaw Prompt Strategy

Stand: Sa 2. Mai 05:20:37 CEST 2026

## Ziel

Die Inhalte aus OpenClaw Prompts.pdf werden nicht blind ausgeführt, sondern als kontrolliertes Prompt-Archiv in den bestehenden Shadowmaker/OpenClaw-Stack integriert.

## Grundsatz

Der Stack ist stabil. Fundament nicht verändern.

Nicht anfassen:
- OpenClaw Binding
- Docker-Port 18789
- Telegram-Grundsetup
- CrashBandicot-Core
- Timeshift-Konfiguration

## Reihenfolge

1. Prompt-Archiv anlegen.
2. Daily Brief produktiv nutzen.
3. Memory-Disziplin in SOUL.md / AGENTS.md dokumentieren.
4. Mission Control als Projekt planen.
5. Multi-Agent Crew erst entwerfen, dann einzeln bauen.
6. Security Audit zunächst nur als Report-Modul.
7. Erst nach Freeze + Timeshift produktiv automatisieren.

## Betriebsregel

Vor jeder größeren Änderung:

```text
/freeze_report
```

Danach lokal:

```bash
sudo timeshift --create --comments "Shadowmaker stable freeze before OpenClaw prompt integration"
```

## Aktueller nächster produktiver Schritt

Daily Brief weiterführen und Mission-Control-Datenmodell vorbereiten.

## Prompt-Pfade

```text
/home/schattenmacher/openclaw_training/prompts/openclaw_prompts
```

## Report

```text
/home/schattenmacher/openclaw_training/reports/integrate_openclaw_prompts_archive_20260502_052037.txt
```
