# Shadowmaker Mission Control – Aufgabenliste

Stand: Sa 2. Mai 06:47:13 CEST 2026

## Betriebsregel

Keine ungeprüfte Autonomie. Jede produktive Änderung folgt:

1. Status prüfen
2. Änderung isoliert durchführen
3. Report schreiben
4. Git committen
5. /freeze_report ausführen
6. Timeshift bei stabilem Stand

## Aktive Aufgaben

| ID | Bereich | Aufgabe | Owner | Status | Priorität | Kontrolle |
|---|---|---|---|---|---:|---|
| MC-001 | Mission Control | Daily Brief produktiv nutzen | CrashBandicot | aktiv | 1 | daily-brief-discord |
| MC-002 | Security | Security Audit 2x täglich prüfen | Winky | aktiv/pruefen | 1 | sec-audit-list |
| MC-003 | Daily Delight | Tägliches Build-Idee-Modul aktivieren | Linky | vorbereitet | 1 | daily-delight-run |
| MC-004 | Memory | Memory-Wiki-Grundstruktur aufbauen | Mnemosyne | vorbereitet | 2 | memory-wiki-status |
| MC-005 | OpenClaw | Stackstatus nach Discord routen | Winky | aktiv | 1 | openclaw-status-discord |
| MC-006 | IHK/MFP | Lernsystem als Projektkanal pflegen | Mentor | vorbereitet | 2 | #ihk-mfp |
| MC-007 | Career | Bewerbungs-/CV-Material strukturieren | Strategist | offen | 3 | career-it |
| MC-008 | Finance | Finanz-/Jobcenter-Daten getrennt halten | Steward | offen | 3 | finance-control |
| MC-009 | Housing | WBS/Jobcenter/Wohnung nachweissicher führen | Steward | offen | 2 | housing-jobcenter |
| MC-010 | Prompt-to-Code | Wiederkehrende Prompts in Skripte stabilisieren | Linky | vorbereitet | 2 | prompt_to_code |

## Heute

- Daily Brief erzeugen
- Security Timer prüfen
- Daily Delight erstellen
- Memory-Wiki aktualisieren
- Phase-2-Status dokumentieren

## Keine Löschung

Duplikate, Cache, Browserdaten, Finanzdaten und Behördenunterlagen werden nicht automatisch gelöscht.

## 2026-05-02 – Lokale KI-Dokumentation

| ID | Bereich | Aufgabe | Owner | Status | Kontrolle |
|---|---|---|---|---|---|
| DOC-AI-001 | Local AI | Master-Dokumentation erstellt | Mnemosyne | erledigt | /home/schattenmacher/openclaw_training/mission_control/docs/local_ai_inventory/latest_local_ai_system_documentation.md |
| DOC-AI-002 | OpenClaw | OpenClaw-Brief erstellt | Mnemosyne | erledigt | /home/schattenmacher/openclaw_training/mission_control/docs/local_ai_inventory/latest_openclaw_local_ai_documentation_brief.md |
| DOC-AI-003 | Betrieb | Agenten weiter manuell beobachten | Winky | aktiv | phase5-crew-status |

## 2026-05-02 – Promptstandard

| ID | Bereich | Aufgabe | Owner | Status | Kontrolle |
|---|---|---|---|---|---|
| PROMPT-001 | OpenClaw | Tina-Huang-Master-Prompt erstellt | Mnemosyne | erledigt | /home/schattenmacher/openclaw_training/mission_control/prompt_library/tina_huang_style/latest_tina_huang_local_ai_master_prompt.md |
| PROMPT-002 | Betrieb | Korrigierten Operating Prompt erstellt | Mnemosyne | erledigt | /home/schattenmacher/openclaw_training/mission_control/prompt_library/tina_huang_style/latest_corrected_local_ai_operating_prompt.md |
| PROMPT-003 | OpenClaw | Execution Brief im Workspace bereitgestellt | Mnemosyne | erledigt | /home/schattenmacher/openclaw_training/mission_control/prompt_library/tina_huang_style/latest_openclaw_tina_huang_execution_brief.md |

## 2026-05-02 – Home Script Inventory

| ID | Bereich | Aufgabe | Owner | Status | Kontrolle |
|---|---|---|---|---|---|
| HOME-AUTO-001 | Inventory | Home-Skripte analysieren | Mnemosyne | erledigt | /home/schattenmacher/openclaw_training/mission_control/docs/home_script_inventory/latest_home_script_inventory.md |
| HOME-AUTO-002 | Automation | Kandidaten dokumentieren | Linky | erledigt | /home/schattenmacher/openclaw_training/mission_control/automation_candidates/latest_home_automation_candidates.md |
| HOME-AUTO-003 | Betrieb | Keine automatische Aktivierung ohne Freigabe | User | aktiv | systemctl --user list-timers --all |
