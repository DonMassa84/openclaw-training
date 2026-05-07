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

## 2026-05-02 – Limited Drive Inventory

| ID | Bereich | Aufgabe | Owner | Status | Kontrolle |
|---|---|---|---|---|---|
| DRIVE-LIMIT-001 | Inventory | Begrenzten Laufwerksaudit durchführen | Mnemosyne | erledigt | /home/schattenmacher/openclaw_training/mission_control/docs/drive_inventory_limited/latest_limited_drive_inventory_summary.md |
| DRIVE-LIMIT-002 | Daten | nützliche Skripte prüfen | User | offen | /home/schattenmacher/openclaw_training/mission_control/docs/drive_inventory_limited/limited_useful_scripts_20260502_134348.txt |
| DRIVE-LIMIT-003 | Daten | nützliche PDFs prüfen | User | offen | /home/schattenmacher/openclaw_training/mission_control/docs/drive_inventory_limited/limited_useful_pdfs_20260502_134348.txt |
| DRIVE-LIMIT-004 | Datenschutz | sensible Pfadtreffer nur lokal prüfen | User | offen | /home/schattenmacher/openclaw_training/mission_control/docs/drive_inventory_limited/limited_sensitive_path_hits_20260502_134348.txt |

## 2026-05-02 – Deep OpenClaw Training Analysis

| ID | Bereich | Aufgabe | Owner | Status | Kontrolle |
|---|---|---|---|---|---|
| OCT-001 | Inventory | openclaw_training tief analysieren | Mnemosyne | erledigt | /home/schattenmacher/openclaw_training/mission_control/docs/deep_openclaw_training_analysis/latest_deep_openclaw_training_summary.md |
| OCT-002 | Automation | stabile Kandidaten dokumentieren | Winky/Linky | erledigt | /home/schattenmacher/openclaw_training/mission_control/docs/deep_openclaw_training_analysis/latest_openclaw_training_automation_candidates.md |
| OCT-003 | Betrieb | keine Timer ohne Freigabe | User | aktiv | systemctl --user list-timers --all |

## 2026-05-02 – Post Deep OpenClaw Control

| ID | Bereich | Aufgabe | Owner | Status | Kontrolle |
|---|---|---|---|---|---|
| CTRL-001 | Betrieb | Winky manuell prüfen | Winky | erledigt | /home/schattenmacher/openclaw_training/mission_control/control_runs/latest_post_deep_openclaw_control_run.md |
| CTRL-002 | Betrieb | Mnemosyne manuell prüfen | Mnemosyne | erledigt | /home/schattenmacher/openclaw_training/mission_control/control_runs/latest_post_deep_openclaw_control_run.md |
| CTRL-003 | Betrieb | Courier manuell prüfen | Courier | erledigt | /home/schattenmacher/openclaw_training/mission_control/control_runs/latest_post_deep_openclaw_control_run.md |
| CTRL-004 | Automation | Timer weiterhin nicht aktivieren | User | aktiv | systemctl --user list-timers --all |

## 2026-05-02 – Runtime Control Repair

| ID | Bereich | Aufgabe | Owner | Status | Kontrolle |
|---|---|---|---|---|---|
| RUNTIME-001 | WebUI | Mission Control WebUI prüfen/starten | Winky | erledigt | /home/schattenmacher/openclaw_training/docs/status/latest_runtime_control_repair_status.md |
| RUNTIME-002 | Courier | Proton Bridge Port prüfen | Courier | erledigt | /home/schattenmacher/openclaw_training/docs/status/latest_runtime_control_repair_status.md |
| RUNTIME-003 | ShadowOps | Veraltete Hinweise korrigieren | Mnemosyne | erledigt | /home/schattenmacher/openclaw_training/docs/status/latest_runtime_control_repair_status.md |
| RUNTIME-004 | Skripte | Absolute Pfade statt Aliase verwenden | Linky | aktiv | zukünftige Kontrollskripte |

## 2026-05-02 – Runtime Control OK

| ID | Bereich | Aufgabe | Owner | Status | Kontrolle |
|---|---|---|---|---|---|
| RUNTIME-OK-001 | WebUI | Statusausgabe bereinigen | Linky | erledigt | mission-control-webui-status |
| RUNTIME-OK-002 | Courier | Read-only Status dokumentieren | Courier | erledigt | courier-status |
| RUNTIME-OK-003 | Betrieb | Keine neuen Timer aktivieren | User | aktiv | systemctl --user list-timers --all |

## 2026-05-07 – OpenClaw Google Doc Prompt Pack

| ID | Bereich | Aufgabe | Owner | Status | Kontrolle |
|---|---|---|---|---|---|
| PROMPTPACK-001 | OpenClaw | Prompt-Pack importieren | Mnemosyne | erledigt | /home/schattenmacher/openclaw_training/mission_control/prompt_library/openclaw_google_doc_pack/latest_openclaw_google_doc_prompt_pack_index.md |
| PROMPTPACK-002 | Mission Control | Builder Prompt für Phase 7 vormerken | User | offen | /home/schattenmacher/openclaw_training/mission_control/prompt_library/openclaw_google_doc_pack/04_mission_control_builder_prompt.md |
| PROMPTPACK-003 | Memory | Memory Identity Prompt prüfen | Mnemosyne | offen | /home/schattenmacher/openclaw_training/mission_control/prompt_library/openclaw_google_doc_pack/07_memory_identity_prompt.md |
| PROMPTPACK-004 | Security | Keine zusätzliche Audit-Automation ohne Freigabe | User | aktiv | /home/schattenmacher/openclaw_training/mission_control/prompt_library/openclaw_google_doc_pack/09_security_audit_prompt.md |

## 2026-05-07 – Discord Agent Router

| ID | Bereich | Aufgabe | Owner | Status | Kontrolle |
|---|---|---|---|---|---|
| DISCORD-ROUTER-001 | Discord | Router installieren | Linky | erledigt | /home/schattenmacher/openclaw_training/docs/status/latest_discord_agent_router_status.md |
| DISCORD-ROUTER-002 | Security | Allowlist prüfen | User | aktiv | ENV-Datei |
| DISCORD-ROUTER-003 | Betrieb | Bot-Service testen | User | offen | !status |

## 2026-05-07 – Discord Router Slash Repair

| ID | Bereich | Aufgabe | Owner | Status | Kontrolle |
|---|---|---|---|---|---|
| DISCORD-SLASH-001 | Discord | Slash Commands aktivieren | Linky | erledigt | /status |
| DISCORD-SLASH-002 | Security | Message Content Intent vermeiden | Linky | erledigt | Logs READY |
