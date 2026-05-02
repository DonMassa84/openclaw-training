# OpenClaw Prompt Archiv

Quelle: OpenClaw Prompts.pdf

Zweck:
Dieses Archiv sammelt die OpenClaw-Prompts als lokale, versionierte Arbeitsbasis für den Shadowmaker/OpenClaw-Stack.

Enthaltene Module:
1. Hardware Selector
2. OpenClaw Setup Wizard
3. About Me Prompt
4. Mission Control Builder
5. Project Brief Prompt
6. Multi-Agent Framework
7. Note Taking / Memory Fix
8. Karpathy LLM Wiki Memory
9. Security Audit

Betriebsregel:
Vor jeder produktiven Umsetzung zuerst `/freeze_report` ausführen und danach lokal einen Timeshift-Snapshot erstellen.

Aktueller Stack-Standard:
Telegram = operative Steuerung
CrashBandicot = Control Bot
Discord = Alerts / Reports
OpenClaw = Agent-/Gateway-System
Flowise = Workflow-Ebene
n8n = Scheduling / Automation
Git = Versionierung
Timeshift = Rollback
