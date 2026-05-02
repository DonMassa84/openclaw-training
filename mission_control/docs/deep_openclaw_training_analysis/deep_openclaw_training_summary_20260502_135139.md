# Deep OpenClaw Training Analysis

Stand: Sa 2. Mai 13:51:41 CEST 2026

## 1 Situation

Das Verzeichnis `/home/schattenmacher/openclaw_training` wurde gezielt und read-only analysiert.

## 2 Ziel

Skripte, Reports, Agenten, Statusdateien, KI-Artefakte und Automatisierungskandidaten dokumentieren.

## 3 Sicherheitsmodus

- read-only
- keine Skripte ausgeführt
- keine Secrets gelesen
- keine Timer aktiviert
- keine Dienste gestartet
- keine Löschung

## 4 Dateizählung

| Typ | Anzahl | Index |
|---|---:|---|
| Alle Dateien | 2494 | /home/schattenmacher/openclaw_training/mission_control/docs/deep_openclaw_training_analysis/openclaw_training_all_files_20260502_135139.txt |
| Skripte | 108 | /home/schattenmacher/openclaw_training/mission_control/docs/deep_openclaw_training_analysis/openclaw_training_scripts_20260502_135139.txt |
| Python | 29 | /home/schattenmacher/openclaw_training/mission_control/docs/deep_openclaw_training_analysis/openclaw_training_python_20260502_135139.txt |
| Markdown | 240 | /home/schattenmacher/openclaw_training/mission_control/docs/deep_openclaw_training_analysis/openclaw_training_markdown_20260502_135139.txt |
| JSON/YAML | 116 | /home/schattenmacher/openclaw_training/mission_control/docs/deep_openclaw_training_analysis/openclaw_training_json_yaml_20260502_135139.txt |
| Reports | 224 | /home/schattenmacher/openclaw_training/mission_control/docs/deep_openclaw_training_analysis/openclaw_training_reports_index_20260502_135139.txt |
| Agent Runtime | 44 | /home/schattenmacher/openclaw_training/mission_control/docs/deep_openclaw_training_analysis/openclaw_training_agent_runtime_index_20260502_135139.txt |
| Statusdateien | 392 | /home/schattenmacher/openclaw_training/mission_control/docs/deep_openclaw_training_analysis/openclaw_training_status_index_20260502_135139.txt |
| Sensible Pfadtreffer | 650 | /home/schattenmacher/openclaw_training/mission_control/docs/deep_openclaw_training_analysis/openclaw_training_sensitive_paths_only_20260502_135139.txt |

## 5 Top-Verzeichnisse

```text
    517  mission_control/webui
    392  docs/status
    330  artifacts/extracted_text
    330  artifacts/structured_refined
    175  artifacts/structured
     48  artifacts/freezes
     44  mission_control/agent_runtime
     33  mission_control/docs
     32  artifacts/ihk_mfp_quality
     30  artifacts/lora_training
     20  artifacts/chroma_multi
     15  artifacts/wave1_debug_20260414_040714
     15  mission_control/projects
     12  artifacts/recovery_20260414_020341
     11  docs/runbooks
     11  mission_control/mail_briefing
     10  mission_control/agents
     10  prompts/openclaw_prompts
      8  mission_control/memory_wiki
      7  mission_control/career_it
      7  mission_control/discord
      7  mission_control/prompt_to_code
      6  artifacts/local_inventory
      6  mission_control/finance_housing_readonly
      6  mission_control/ihk_mfp
      5  mission_control/daily_briefs
      4  mission_control/security
      4  mission_control/tasks
      4  mission_control/workspace_audit
      3  artifacts/openclaw_env_fix_20260414_041014
      3  artifacts/reports
      3  extensions/agenteva
      3  mission_control/prompt_library
      2  artifacts/imports
      2  artifacts/openclaw_fix_wave1_commands_20260414_041708
      2  artifacts/openclaw_routerfix_20260414_042001
      2  artifacts/openclaw_smoke_20260414_020841
      2  artifacts/openclaw_wave1_safe_20260414_041234
      2  artifacts/router_probe_patch_20260414_042558
      2  artifacts/skill_rollout_v1_20260414_020618
      2  mission_control/daily_delight
      2  mission_control/daily_logs
      2  reports/archive
      1  artifacts/derived_tasks.jsonl
      1  artifacts/ihk_mfp_train.jsonl
      1  artifacts/inventory.jsonl
      1  artifacts/paste_docs.jsonl
      1  artifacts/paste_tasks.jsonl
      1  artifacts/paste.txt
      1  artifacts/quality_gate_result.txt
      1  artifacts/router_probe_20260414_042558.txt
      1  build_final_training.py
      1  config/patterns.yml
      1  .gitignore
      1  local_exam_ai_test.sh
      1  logs/step1_20260415_194427.log
      1  mission_control/automation_candidates
      1  mission_control/README.md
      1  pipeline/01_convert_to_jsonl.py
      1  pipeline/02_split_train_holdout.py
      1  pipeline/03_train_lora.py
      1  pipeline/04_run_holdout_inference.py
      1  pipeline/05_score_holdout.py
      1  pipeline/merge_lora.py
      1  pipeline/run_pipeline.sh
      1  prepare_final_dataset_split.sh
      1  prompts/tina_huang_prompt_placeholders.md
      1  README.md
      1  README_STEP1.txt
      1  reports/activate_shadowmaker_phase3_modules_allinone_20260502_070604.txt
      1  reports/add_daily_brief_to_crashbandicot_20260502_011856.txt
      1  reports/add_freeze_report_to_crashbandicot_20260502_010303.txt
      1  reports/add_freeze_report_to_crashbandicot_20260502_010316.txt
      1  reports/analyze_home_useful_scripts_openclaw_allinone_20260502_123832.txt
      1  reports/audit_all_drives_data_inventory_allinone_20260502_131446.txt
      1  reports/autonomous_mfp_training_report.json
      1  reports/autonomous_mfp_training_report.md
      1  reports/batch_score_20260413_093757.txt
      1  reports/batch_score_20260413_104247.txt
      1  reports/batch_score_20260413_104911.txt
```

## 6 Skript-Katalog

```text
/home/schattenmacher/openclaw_training/mission_control/docs/deep_openclaw_training_analysis/latest_openclaw_training_useful_scripts_catalog.md
```

## 7 Automatisierungskandidaten

```text
/home/schattenmacher/openclaw_training/mission_control/docs/deep_openclaw_training_analysis/latest_openclaw_training_automation_candidates.md
```

## 8 Aktuelle Kernaussage

`openclaw_training` enthält folgende produktive Bereiche:

- Mission Control
- Multi-Agent Crew
- Courier Mail Briefing
- IHK/MFP Training
- Security Audit
- Freeze/Status Reports
- lokale KI-/RAG-/LoRA-Artefakte
- Prompt Library
- Drive/Home Inventories

## 9 Wichtigste Betriebsregel

Nicht mehr global scannen. Nicht alles automatisieren. Nur stabile, wiederkehrende Module einzeln aktivieren.

## 10 Nächster Schritt

Prüfen:

```bash
deep-openclaw-status
deep-openclaw-summary
deep-openclaw-useful
deep-openclaw-automation
```

Danach entscheiden:
- Winky automatisieren?
- Mnemosyne automatisieren?
- Courier morgens automatisieren?

