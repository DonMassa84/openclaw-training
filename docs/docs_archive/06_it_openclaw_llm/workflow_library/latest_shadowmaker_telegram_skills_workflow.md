# ShadowMaker Telegram Skills Workflow

## Zweck

Telegram kann lokale ShadowMaker-Skills starten, aber keine freie Shell ausführen.

## Sicherheitsmodell

Telegram → Allowlist → Skill → lokaler Befehl → Report → Antwort

## Befehle

```text
/skills
/run health
/run gitstatus
/run secret_scan
/run ask OpenClaw RAG Status
/run askhousing Hausenring 53 Zusicherung Jobcenter
/run askfinance Pfändung
/run askdocs OpenClaw Workflow Library
/run askihk Mitarbeiterführung Personalmanagement SA1
/run asksecurity Token Discord Security
/run discord_docs
/run commit_safe_report
Regeln
keine freie Shell
kein sudo
nur erlaubte Skills
nur konfigurierte TELEGRAM_CHAT_ID darf Befehle ausführen
jeder Skill schreibt Report nach ~/openclaw_training/reports
