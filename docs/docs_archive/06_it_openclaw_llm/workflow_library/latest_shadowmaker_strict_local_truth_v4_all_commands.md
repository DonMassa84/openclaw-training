# ShadowMaker Strict Local Truth v4 — All Commands

Stand: 2026-05-08T12:34:22+02:00

## Änderung

v4 behebt die letzten Test-Artefakte:

- askfinance gibt nie Manifest-Rohzeilen aus
- askfinance fällt robust auf find/Manifest-Dateipfade zurück
- asksecurity gibt keinen Prüf-Befehl mit Secret-Pattern-Literalen aus
- Testscan soll GREEN liefern
- kritische Befehle bleiben deterministic local-only

## Testbefehle

```bash
askhousing "Hausenring 53 Zusicherung Jobcenter"
askdocs "OpenClaw Workflow Library"
askmail "Thunderbird Discord Passwort"
askfinance "Pfändung"
asksecurity "Token Discord Security"
askihk "Mitarbeiterführung Personalmanagement SA1"
ask "OpenClaw RAG Status"
```
