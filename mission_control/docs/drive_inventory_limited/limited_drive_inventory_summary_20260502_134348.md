# Limited Drive Inventory Summary – Shadowmaker/OpenClaw

Stand: Sa 2. Mai 13:44:11 CEST 2026

## 1 Situation

Der vorherige Vollscan wurde wegen eines externen Laufwerks mit ca. 17,7 Mio. Dateien abgebrochen. Dieser Lauf nutzt eine sichere, begrenzte Analyse mit maxdepth und Dateilimits.

## 2 Ziel

PDFs, Texte, Skripte, Python-Dateien, Konfigurationen, Office-Dateien und sensible Pfadtreffer erfassen, ohne Laufwerke vollständig zu indexieren.

## 3 Sicherheitsmodus

- read-only
- keine Dateiänderung
- keine Löschung
- keine Secrets ausgegeben
- keine .env-/Token-/Credential-Inhalte
- keine Vollindexierung externer Laufwerke
- keine Dienste gestartet
- keine Timer aktiviert

## 4 Laufwerke

### df -hT

```text
Dateisystem    Typ      Größe Benutzt Verf. Verw% Eingehängt auf
tmpfs          tmpfs     3,2G    2,4M  3,2G    1% /run
efivarfs       efivarfs  128K     41K   83K   33% /sys/firmware/efi/efivars
/dev/sda2      ext4      1,8T    1,1T  628G   64% /
tmpfs          tmpfs      16G    2,4M   16G    1% /dev/shm
tmpfs          tmpfs     5,0M     16K  5,0M    1% /run/lock
/dev/sda1      vfat      511M     15M  497M    3% /boot/efi
tmpfs          tmpfs     3,2G    412K  3,2G    1% /run/user/1000
/dev/sdg1      vfat       29G    6,2G   23G   22% /media/schattenmacher/USB-STICK
/dev/sdf       vfat      1,9G    137M  1,8G    8% /media/schattenmacher/CAA9-512D
/dev/sde1      ext4      452G    340G   90G   80% /media/schattenmacher/USB-STICK1
/dev/sdh1      ext4      1,8T    1,5T  257G   86% /media/schattenmacher/ed37f2a2-0df8-44bc-aa1f-9ea6d1405cb7
/dev/sdb1      fuseblk   932G    696G  236G   75% /media/schattenmacher/C6C25F2BC25F1ECD
```

### lsblk -f

```text
NAME        FSTYPE  FSVER            LABEL                           UUID                                 FSAVAIL FSUSE% MOUNTPOINTS
sda                                                                                                                      
├─sda1      vfat    FAT32                                            C446-2E2A                             496,3M     3% /boot/efi
└─sda2      ext4    1.0                                              8d308721-4fcb-4b5d-8c66-e8932c9fd66b    628G    61% /
sdb                                                                                                                      
└─sdb1      ntfs                                                     C6C25F2BC25F1ECD                      235,6G    75% /media/schattenmacher/C6C25F2BC25F1ECD
sdc                                                                                                                      
├─sdc1      ntfs                     System-reserviert               4A10A3AB10A39C87                                    
├─sdc2      ntfs                                                     B4DCADF7DCADB450                                    
├─sdc3      ntfs                                                     5012429412427F4A                                    
├─sdc4                                                                                                                   
├─sdc5      vfat    FAT32                                            5885-973A                                           
└─sdc6      ext4    1.0                                              62e5982e-3753-423c-9fc2-3ea54f87a0fd                
sdd                                                                                                                      
└─sdd1      ext4    1.0                                              d51a4b61-cae4-47da-aa03-bd3bceb25279                
sde                                                                                                                      
└─sde1      ext4    1.0              USB-STICK                       9cc6ffd8-91f4-4525-aead-98f21b732771   89,7G    75% /media/schattenmacher/USB-STICK1
sdf         vfat    FAT16                                            CAA9-512D                               1,7G     7% /media/schattenmacher/CAA9-512D
sdg         iso9660 Joliet Extension Linux Mint 22.2 Cinnamon 64-bit 2025-08-28-08-52-38-00                              
└─sdg1      vfat    FAT32            USB-STICK                       F4BC-5CA0                              22,5G    22% /media/schattenmacher/USB-STICK
sdh                                                                                                                      
└─sdh1      ext4    1.0                                              ed37f2a2-0df8-44bc-aa1f-9ea6d1405cb7  256,5G    81% /media/schattenmacher/ed37f2a2-0df8-44bc-aa1f-9ea6d1405cb7
nvme0n1                                                                                                                  
├─nvme0n1p1 ext4    1.0              ROOT                            40c3e466-0f1d-4bc6-bd0e-6df56fb53f3c                
├─nvme0n1p2 ext4    1.0              HOME                            40263943-c193-49cf-bd23-56c1b5b4ee85                
└─nvme0n1p3 ext4    1.0              DATA                            b4469a55-bb63-491c-9ec1-bfee10915989                
```

## 5 Scan-Ziele

```text
/home/schattenmacher/AEVO_AD
/home/schattenmacher/AEVO_App
/home/schattenmacher/bots
/home/schattenmacher/ComfyUI
/home/schattenmacher/Desktop
/home/schattenmacher/Documents
/home/schattenmacher/Dokumente
/home/schattenmacher/Downloads
/home/schattenmacher/eva-agent-template
/home/schattenmacher/EVA_IntelligentAgent
/home/schattenmacher/ihk_training_system
/home/schattenmacher/local_llm_pipeline
/home/schattenmacher/.openclaw
/home/schattenmacher/openclaw_training
/home/schattenmacher/Schreibtisch
/home/schattenmacher/shadow-letta
/home/schattenmacher/shadowmaker-ai-stack
/home/schattenmacher/telegram-chatgpt-bot
/home/schattenmacher/usb-llm-data-pipeline
/media/schattenmacher
/media/schattenmacher/62e5982e-3753-423c-9fc2-3ea54f87a0fd
/media/schattenmacher/B4DCADF7DCADB450
/media/schattenmacher/d51a4b61-cae4-47da-aa03-bd3bceb25279
/media/schattenmacher/ed37f2a2-0df8-44bc-aa1f-9ea6d1405cb7
/media/schattenmacher/ed37f2a2-0df8-44bc-aa1f-9ea6d1405cb7/2025-06-18-1745-img-rescuezilla
/media/schattenmacher/ed37f2a2-0df8-44bc-aa1f-9ea6d1405cb7/AI_MODELS
/media/schattenmacher/ed37f2a2-0df8-44bc-aa1f-9ea6d1405cb7/AI-Models-backup
/media/schattenmacher/ed37f2a2-0df8-44bc-aa1f-9ea6d1405cb7/ai_moves
/media/schattenmacher/ed37f2a2-0df8-44bc-aa1f-9ea6d1405cb7/ATTACHMENTS_LARGE
/media/schattenmacher/ed37f2a2-0df8-44bc-aa1f-9ea6d1405cb7/Backup_EMERGENCY
/media/schattenmacher/ed37f2a2-0df8-44bc-aa1f-9ea6d1405cb7/Baraka.1992.BluRay.1080p.DTS.x264.dxva-EuReKA
/media/schattenmacher/ed37f2a2-0df8-44bc-aa1f-9ea6d1405cb7/deepface_data
/media/schattenmacher/ed37f2a2-0df8-44bc-aa1f-9ea6d1405cb7/EMERGENCY_BACKUP_20250610
/media/schattenmacher/ed37f2a2-0df8-44bc-aa1f-9ea6d1405cb7/EML_RAW_ARCHIVE
/media/schattenmacher/ed37f2a2-0df8-44bc-aa1f-9ea6d1405cb7/EVA-Models-backup
/media/schattenmacher/ed37f2a2-0df8-44bc-aa1f-9ea6d1405cb7/EVA-System-backup
/media/schattenmacher/ed37f2a2-0df8-44bc-aa1f-9ea6d1405cb7/EVA-System-backup_20250610_201920
/media/schattenmacher/ed37f2a2-0df8-44bc-aa1f-9ea6d1405cb7/FULL_BACKUP_20250610
/media/schattenmacher/ed37f2a2-0df8-44bc-aa1f-9ea6d1405cb7/GPT4All
/media/schattenmacher/ed37f2a2-0df8-44bc-aa1f-9ea6d1405cb7/ki_backups
/media/schattenmacher/ed37f2a2-0df8-44bc-aa1f-9ea6d1405cb7/LOGS_HISTORICAL
/media/schattenmacher/ed37f2a2-0df8-44bc-aa1f-9ea6d1405cb7/Medien
/media/schattenmacher/ed37f2a2-0df8-44bc-aa1f-9ea6d1405cb7/multi_ai_agent
/media/schattenmacher/ed37f2a2-0df8-44bc-aa1f-9ea6d1405cb7/OCR_HISTORICAL
/media/schattenmacher/ed37f2a2-0df8-44bc-aa1f-9ea6d1405cb7/ollama_backup
/media/schattenmacher/ed37f2a2-0df8-44bc-aa1f-9ea6d1405cb7/PYTHON_ENVIRONMENTS
/media/schattenmacher/ed37f2a2-0df8-44bc-aa1f-9ea6d1405cb7/shadow_backup
/media/schattenmacher/ed37f2a2-0df8-44bc-aa1f-9ea6d1405cb7/shadow_data
/media/schattenmacher/ed37f2a2-0df8-44bc-aa1f-9ea6d1405cb7/shadowmaker
/media/schattenmacher/ed37f2a2-0df8-44bc-aa1f-9ea6d1405cb7/stable-diffusion-webui
/media/schattenmacher/ed37f2a2-0df8-44bc-aa1f-9ea6d1405cb7/usb_archiv
/media/schattenmacher/ed37f2a2-0df8-44bc-aa1f-9ea6d1405cb7/USB_SORTED
/media/schattenmacher/ed37f2a2-0df8-44bc-aa1f-9ea6d1405cb7/USER_DATA
/media/schattenmacher/HOME
/media/schattenmacher/ROOT
/media/schattenmacher/USB-STICK
/media/schattenmacher/USB-STICK/03-JAN-2026
/media/schattenmacher/USB-STICK/03-MAR-2026
/media/schattenmacher/USB-STICK/03-OCT-2025
/media/schattenmacher/USB-STICK/06-FEB-2026
/media/schattenmacher/USB-STICK/07-NOV-2025
/media/schattenmacher/USB-STICK/08-NOV-2025
/media/schattenmacher/USB-STICK/09-OCT-2025
/media/schattenmacher/USB-STICK1
/media/schattenmacher/USB-STICK1/03-OCT-2025
/media/schattenmacher/USB-STICK1/09-OCT-2025
/media/schattenmacher/USB-STICK/10-JAN-2026
/media/schattenmacher/USB-STICK1/24-SEP-2025
/media/schattenmacher/USB-STICK1/27-SEP-2025
/media/schattenmacher/USB-STICK1/30-SEP-2025
/media/schattenmacher/USB-STICK/13-NOV-2025
/media/schattenmacher/USB-STICK/14-FEB-2026
/media/schattenmacher/USB-STICK/16-DEC-2025
/media/schattenmacher/USB-STICK/17-NOV-2025
/media/schattenmacher/USB-STICK/19-NOV-2025
/media/schattenmacher/USB-STICK1/AEVO_2025_Prüfung
/media/schattenmacher/USB-STICK1/AEVO_Backup_20251217
/media/schattenmacher/USB-STICK1/Antrag
/media/schattenmacher/USB-STICK1/bilder
/media/schattenmacher/USB-STICK1/data
/media/schattenmacher/USB-STICK1/exports
/media/schattenmacher/USB-STICK1/ihk-shadowmaker
/media/schattenmacher/USB-STICK1/LinuxMint22.2
/media/schattenmacher/USB-STICK1/transcripts_package
/media/schattenmacher/USB-STICK1/usb 07.11.25
/media/schattenmacher/USB-STICK1/USB_SORTED
/media/schattenmacher/USB-STICK1/Zero-Trust-Sicherheitskonzept mit GitHub-Integration_Massa
/media/schattenmacher/USB-STICK/20-NOV-2025
/media/schattenmacher/USB-STICK/24-SEP-2025
/media/schattenmacher/USB-STICK/27-FEB-2026
/media/schattenmacher/USB-STICK/27-SEP-2025
/media/schattenmacher/USB-STICK/28-FEB-2026
/media/schattenmacher/USB-STICK/30-SEP-2025
/media/schattenmacher/USB-STICK/31-DEC-2025
/media/schattenmacher/USB-STICK/Antrag
/media/schattenmacher/USB-STICK/crash_snapshots
/media/schattenmacher/USB-STICK/openclaw_backup_2026-04-14_014714
/media/schattenmacher/USB-STICK/openclaw_shadow_20260414_062334
/media/schattenmacher/USB-STICK/shadow_final_20260414_062801
```

## 6 Dateitypen

| Typ | Anzahl | Index |
|---|---:|---|
| Alle begrenzten Dateien | 35632 | /home/schattenmacher/openclaw_training/mission_control/docs/drive_inventory_limited/limited_all_files_20260502_134348.txt |
| PDFs | 3285 | /home/schattenmacher/openclaw_training/mission_control/docs/drive_inventory_limited/limited_pdf_files_20260502_134348.txt |
| Texte/Markdown/Logs | 5227 | /home/schattenmacher/openclaw_training/mission_control/docs/drive_inventory_limited/limited_text_markdown_files_20260502_134348.txt |
| Shell-Skripte | 585 | /home/schattenmacher/openclaw_training/mission_control/docs/drive_inventory_limited/limited_script_files_20260502_134348.txt |
| Python | 1709 | /home/schattenmacher/openclaw_training/mission_control/docs/drive_inventory_limited/limited_python_files_20260502_134348.txt |
| Configs | 1149 | /home/schattenmacher/openclaw_training/mission_control/docs/drive_inventory_limited/limited_config_files_20260502_134348.txt |
| Office | 196 | /home/schattenmacher/openclaw_training/mission_control/docs/drive_inventory_limited/limited_office_files_20260502_134348.txt |
| Archive | 193 | /home/schattenmacher/openclaw_training/mission_control/docs/drive_inventory_limited/limited_archive_files_20260502_134348.txt |
| Sensible Pfadtreffer | 1000 | /home/schattenmacher/openclaw_training/mission_control/docs/drive_inventory_limited/limited_sensitive_path_hits_20260502_134348.txt |

## 7 Top-Ordner

```text
   5011  /media/schattenmacher/USB-STICK1/usb 07.11.25
   5000  /media/schattenmacher/ed37f2a2-0df8-44bc-aa1f-9ea6d1405cb7/EML_RAW_ARCHIVE
   5000  /media/schattenmacher/USB-STICK1/USB_SORTED
   3829  /home/schattenmacher/Dokumente/USB_SORTED
   2056  /media/schattenmacher/USB-STICK1/bilder
   1845  /media/schattenmacher/ed37f2a2-0df8-44bc-aa1f-9ea6d1405cb7/USER_DATA
   1024  /home/schattenmacher/openclaw_training/artifacts
   1010  /media/schattenmacher/USB-STICK1/data
    934  /home/schattenmacher/shadowmaker-ai-stack/flowise-data
    694  /home/schattenmacher/Schreibtisch/Zusammenfassungen
    492  /media/schattenmacher/ed37f2a2-0df8-44bc-aa1f-9ea6d1405cb7/shadow_backup
    482  /media/schattenmacher/USB-STICK1/AEVO_Backup_20251217
    469  /media/schattenmacher/ed37f2a2-0df8-44bc-aa1f-9ea6d1405cb7/stable-diffusion-webui
    466  /media/schattenmacher/ed37f2a2-0df8-44bc-aa1f-9ea6d1405cb7/EMERGENCY_BACKUP_20250610
    466  /media/schattenmacher/ed37f2a2-0df8-44bc-aa1f-9ea6d1405cb7/FULL_BACKUP_20250610
    437  /home/schattenmacher/openclaw_training/mission_control
    421  /home/schattenmacher/ComfyUI/ComfyUI
    389  /media/schattenmacher/USB-STICK/shadow_final_20260414_062801
    388  /home/schattenmacher/openclaw_training/docs
    388  /media/schattenmacher/USB-STICK/openclaw_shadow_20260414_062334
    386  /home/schattenmacher/Dokumente/frs-on-air
    241  /home/schattenmacher/Dokumente/Geprüfte Operative IT Professionals - Teilnehmerunterlagen -
    219  /home/schattenmacher/openclaw_training/reports
    169  /home/schattenmacher/ComfyUI/comfy
    146  /home/schattenmacher/Dokumente/transkripte
    130  /home/schattenmacher/Downloads/Geprüfte Operative IT Professionals  - Teilnehmerunterlagen -
    130  /home/schattenmacher/Downloads/Programme
    129  /media/schattenmacher/ed37f2a2-0df8-44bc-aa1f-9ea6d1405cb7/Backup_EMERGENCY
    118  /media/schattenmacher/USB-STICK1/AEVO_2025_Prüfung
    115  /media/schattenmacher/ed37f2a2-0df8-44bc-aa1f-9ea6d1405cb7/GPT4All
    111  /home/schattenmacher/Downloads/frsapp
    106  /home/schattenmacher/Downloads/files
     98  /home/schattenmacher/Downloads/MFP_90_Schattenmacher_Slides
     98  /home/schattenmacher/Downloads/slides_monitor
     90  /home/schattenmacher/Downloads/MFP_90_Slides
     90  /media/schattenmacher/USB-STICK1/Zero-Trust-Sicherheitskonzept mit GitHub-Integration_Massa
     89  /home/schattenmacher/Downloads/Geprüfte Operative IT Professionals Prüfungen
     89  /media/schattenmacher/USB-STICK/openclaw_backup_2026-04-14_014714
     87  /home/schattenmacher/Downloads/Notebook LM Videos und Audios
     77  /home/schattenmacher/ComfyUI/comfy_extras
     76  /home/schattenmacher/AEVO_App/dist
     67  /media/schattenmacher/ed37f2a2-0df8-44bc-aa1f-9ea6d1405cb7/ollama_backup
     60  /home/schattenmacher/openclaw_training/scripts
     56  /home/schattenmacher/Dokumente/shadow-learn
     55  /home/schattenmacher/openclaw_training/src
     48  /home/schattenmacher/ComfyUI/comfy_api_nodes
     38  /home/schattenmacher/Downloads/freies-radio-stuttgart-web
     38  /home/schattenmacher/usb-llm-data-pipeline/psa_work_v2
     36  /home/schattenmacher/Downloads/SA_Dark_Mode_Slides_Part1
     35  /home/schattenmacher/local_llm_pipeline/runs
     35  /media/schattenmacher/ed37f2a2-0df8-44bc-aa1f-9ea6d1405cb7/PYTHON_ENVIRONMENTS
     34  /home/schattenmacher/Dokumente/Belege_Vermittlungsbudget_BG621A289912
     33  /home/schattenmacher/ComfyUI/comfy_api
     33  /home/schattenmacher/.openclaw/workspace
     32  /home/schattenmacher/usb-llm-data-pipeline/psa_work
     31  /media/schattenmacher/ed37f2a2-0df8-44bc-aa1f-9ea6d1405cb7/AI_MODELS
     30  /home/schattenmacher/ComfyUI/models
     30  /home/schattenmacher/Downloads/Transkripte_VFB_Videos
     29  /media/schattenmacher/ed37f2a2-0df8-44bc-aa1f-9ea6d1405cb7/USB_SORTED
     28  /media/schattenmacher/ed37f2a2-0df8-44bc-aa1f-9ea6d1405cb7/2025-06-18-1745-img-rescuezilla
     27  /home/schattenmacher/usb-llm-data-pipeline/qwen25-15b-lora-clean
     26  /home/schattenmacher/ComfyUI/tests-unit
     22  /home/schattenmacher/ComfyUI/.github
     22  /home/schattenmacher/Dokumente/Personal
     19  /home/schattenmacher/Dokumente/FINANZEN_ARCHIV_2026-03-03
     18  /media/schattenmacher/ed37f2a2-0df8-44bc-aa1f-9ea6d1405cb7/EVA-System-backup_20250610_201920
     17  /home/schattenmacher/Dokumente/Kontoauszüge
     17  /home/schattenmacher/Downloads/_bg_from_video_gpu
     17  /home/schattenmacher/Schreibtisch/Freies Radio Stuttgart 20-11-25
     16  /home/schattenmacher/Dokumente/ShadowLearn App v1.2 (Passive Mode)
     16  /home/schattenmacher/Downloads/AEVO
     16  /media/schattenmacher/ed37f2a2-0df8-44bc-aa1f-9ea6d1405cb7/EVA-System-backup
     15  /home/schattenmacher/local_llm_pipeline/03_training
     15  /home/schattenmacher/.openclaw/agents
     15  /media/schattenmacher/ed37f2a2-0df8-44bc-aa1f-9ea6d1405cb7/multi_ai_agent
     14  /home/schattenmacher/Dokumente/OP_Kurs_Upload
     14  /home/schattenmacher/EVA_IntelligentAgent/_stack_rebuild_reports
     12  /home/schattenmacher/ComfyUI/.ci
     12  /home/schattenmacher/ComfyUI/tests
     12  /home/schattenmacher/Dokumente/prüfungen
```

## 8 Nützliche Kandidaten

### Skripte

Index:

```text
/home/schattenmacher/openclaw_training/mission_control/docs/drive_inventory_limited/limited_useful_scripts_20260502_134348.txt
```

Auszug:

```text
/home/schattenmacher/AEVO_App/create_icon.sh
/home/schattenmacher/ComfyUI/comfyui_install.sh
/home/schattenmacher/ComfyUI/ComfyUI/utils/install_util.py
/home/schattenmacher/ComfyUI/utils/install_util.py
/home/schattenmacher/Dokumente/openclaw_task_booster_v1.sh
/home/schattenmacher/Dokumente/shadow-learn/shadowlearn_fix_and_deploy.sh
/home/schattenmacher/Dokumente/shadow-learn/shadowlearn_fix_pages.sh
/home/schattenmacher/Dokumente/shadow-learn/shadowlearn_full_setup.sh
/home/schattenmacher/Dokumente/shadow-learn/shadowlearn_git_fix.sh
/home/schattenmacher/Dokumente/shadow-learn/shadowlearn_install_app.sh
/home/schattenmacher/Dokumente/shadow-learn/shadowlearn_setup.sh
/home/schattenmacher/Dokumente/transkripte/ihk-operative-professionals-2024-25/backup.sh
/home/schattenmacher/Dokumente/transkripte/ihk-operative-professionals-2024-25/cf_ai_deploy.sh
/home/schattenmacher/Dokumente/transkripte/ihk-operative-professionals-2024-25/complete_move.sh
/home/schattenmacher/Dokumente/transkripte/ihk-operative-professionals-2024-25/deploy_workers_ai.sh
/home/schattenmacher/Dokumente/transkripte/ihk-operative-professionals-2024-25/fix_organization.sh
/home/schattenmacher/Dokumente/transkripte/ihk-operative-professionals-2024-25/monitor_live.sh
/home/schattenmacher/Dokumente/transkripte/ihk-operative-professionals-2024-25/organize_videos.sh
/home/schattenmacher/Dokumente/transkripte/ihk-operative-professionals-2024-25/scripts/organize_videos.sh
/home/schattenmacher/Dokumente/transkripte/ihk-operative-professionals-2024-25/SHADOW_SCHEDULE_INTEGRATION.sh
/home/schattenmacher/Dokumente/transkripte/ihk-operative-professionals-2024-25/tools/check_stripe_links.py
/home/schattenmacher/Dokumente/transkripte/ihk-operative-professionals-2024-25/tools/patch_actions.sh
/home/schattenmacher/Dokumente/transkripte/ihk-operative-professionals-2024-25/tools/pin_actions.sh
/home/schattenmacher/Dokumente/transkripte/ihk-operative-professionals-2024-25/update_videos.sh
/home/schattenmacher/Dokumente/USB_SORTED/2025-06-10/eva_integration_fix.sh
/home/schattenmacher/Dokumente/USB_SORTED/2025-06-10/eva_shadow_storage_optimization.sh
/home/schattenmacher/Downloads/freies-radio-stuttgart-web/frs_fix.sh
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG /_AEVO_LOGS/content_undo_20260114_000334.sh
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG /_AEVO_LOGS/content_undo_20260114_000336.sh
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG /_AEVO_LOGS/content_undo_20260114_000434.sh
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG /_AEVO_LOGS/content_undo_20260114_000755.sh
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG /_AEVO_LOGS/content_undo_20260114_000811.sh
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG /_AEVO_LOGS/content_undo_20260114_001306.sh
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG /_AEVO_LOGS/content_undo_20260114_001342.sh
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG /_AEVO_LOGS/content_undo_20260114_001444.sh
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG /_AEVO_LOGS/content_undo_20260114_001558.sh
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG /_AEVO_LOGS/content_undo_20260114_001619.sh
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG /_AEVO_LOGS/content_undo_20260114_001719.sh
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG /_AEVO_LOGS/content_undo_20260114_001813.sh
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG/_AEVO_LOGS/merge_undo_20260114_004546.sh
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG/_AEVO_LOGS/merge_undo_20260114_004555.sh
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG /_AEVO_LOGS/rename_undo_20260113_234623.sh
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG /_AEVO_LOGS/rename_undo_20260113_234921.sh
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG /_AEVO_LOGS/rename_undo_20260113_235014.sh
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG /_AEVO_LOGS/rename_undo_20260113_235115.sh
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG /_AEVO_LOGS/rename_undo_20260113_235233.sh
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG /_AEVO_LOGS/rename_undo_20260113_235252.sh
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG /_AEVO_LOGS/rename_undo_20260113_235609.sh
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG /_AEVO_LOGS/rename_undo_20260113_235714.sh
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG /_AEVO_LOGS/rename_undo_20260113_235730.sh
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG /_AEVO_LOGS/rename_undo_20260114_000134.sh
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG /_AEVO_LOGS/rename_undo_20260114_000140.sh
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG /aevo_make_folders.sh
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG/aevo_merge_categories.sh
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG /_AEVO_TOOLS/aevo_analyze_and_rename.sh
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG /_AEVO_TOOLS/aevo_rename_all.sh
/home/schattenmacher/Downloads/openclaw/openclaw_NO_DOCKER.sh
/home/schattenmacher/Downloads/openclaw/openclaw_quickstart.sh
/home/schattenmacher/Downloads/Programme/setup_magicdisc.exe
/home/schattenmacher/Downloads/run_pipeline/03_train_lora.py
/home/schattenmacher/Downloads/run_pipeline/merge_lora.py
/home/schattenmacher/Downloads/shadowmaker_stack_allinone/shadowmaker_stack_allinone.sh
/home/schattenmacher/eva-agent-template/eva-switch.sh
/home/schattenmacher/EVA_IntelligentAgent/eva_live_dashboard.sh
/home/schattenmacher/EVA_IntelligentAgent/eva_n8n_all_in_one.sh
/home/schattenmacher/EVA_IntelligentAgent/openclaw_all_in_one_repro_restore.sh
/home/schattenmacher/EVA_IntelligentAgent/openclaw_all_in_one_repro_restore_v4.sh
/home/schattenmacher/local_llm_pipeline/09_logs/run_20260413_143819.log
/home/schattenmacher/local_llm_pipeline/09_logs/run_20260413_144108.log
/home/schattenmacher/local_llm_pipeline/09_logs/run_20260413_144555.log
/home/schattenmacher/local_llm_pipeline/09_logs/run_20260413_150032.log
/home/schattenmacher/local_llm_pipeline/09_logs/run_20260413_150100.log
/home/schattenmacher/local_llm_pipeline/09_logs/run_20260413_151823.log
/home/schattenmacher/local_llm_pipeline/09_logs/run_20260413_152830.log
/home/schattenmacher/local_llm_pipeline/09_logs/run_20260413_153616.log
/home/schattenmacher/local_llm_pipeline/run_all.sh
/home/schattenmacher/local_llm_pipeline/run_pipeline.sh
/home/schattenmacher/local_llm_pipeline/run_pipeline.sh.bak_20260413_152829
/home/schattenmacher/local_llm_pipeline/runs/20260413_150032/run_summary.md
/home/schattenmacher/local_llm_pipeline/runs/20260413_150100/run_summary.md
/home/schattenmacher/local_llm_pipeline/runs/20260413_151823/run_summary.md
/home/schattenmacher/local_llm_pipeline/runs/20260413_152830/run_summary.md
/home/schattenmacher/local_llm_pipeline/runs/20260413_153616/run_summary.md
/home/schattenmacher/.openclaw/completions/openclaw.bash
/home/schattenmacher/.openclaw/completions/openclaw.zsh
/home/schattenmacher/openclaw_training/local_exam_ai_test.sh
/home/schattenmacher/openclaw_training/pipeline/run_pipeline.sh
/home/schattenmacher/openclaw_training/prepare_final_dataset_split.sh
/home/schattenmacher/openclaw_training/reports/audit_all_drives_data_inventory_allinone_20260502_131446.txt
/home/schattenmacher/openclaw_training/reports/check_security_audit_timer_phase2_20260502_064713.txt
/home/schattenmacher/openclaw_training/reports/check_security_audit_timer_phase2_20260502_065313.txt
/home/schattenmacher/openclaw_training/reports/check_security_audit_timer_phase2_20260502_065330.txt
/home/schattenmacher/openclaw_training/reports/fix_daily_brief_today_variable_20260502_011954.txt
/home/schattenmacher/openclaw_training/reports/fix_freeze_report_patch_crashbandicot_20260502_010431.txt
/home/schattenmacher/openclaw_training/reports/fix_gmail_oauth_testuser_and_retry_allinone_20260502_104545.txt
/home/schattenmacher/openclaw_training/reports/fix_openclaw_gateway_bind_localhost_20260501_234103.txt
/home/schattenmacher/openclaw_training/reports/fix_openclaw_loopback_proxy_20260501_234202.txt
/home/schattenmacher/openclaw_training/reports/install_tina_huang_prompt_style_local_ai_allinone_20260502_122327.txt
/home/schattenmacher/openclaw_training/reports/patch_crashbandicot_openclaw_internal_check_20260501_234423.txt
/home/schattenmacher/openclaw_training/reports/repair_bashrc_after_bad_paste_20260502_055410.txt
/home/schattenmacher/openclaw_training/reports/repair_bashrc_tina_aliases_20260502_000002.txt
/home/schattenmacher/openclaw_training/reports/repair_courier_aliases_and_runner_allinone_20260502_095123.txt
/home/schattenmacher/openclaw_training/reports/repair_courier_proton_starttls_selfsigned_allinone_20260502_095804.txt
/home/schattenmacher/openclaw_training/reports/repair_courier_proton_starttls_selfsigned_allinone_20260502_095851.txt
/home/schattenmacher/openclaw_training/reports/repair_crashbandicot_full_rewrite_20260501_234619.txt
/home/schattenmacher/openclaw_training/reports/repair_discord_scripts_from_existing_env_20260502_005527.txt
/home/schattenmacher/openclaw_training/reports/repair_discord_scripts_from_existing_env_20260502_005650.txt
/home/schattenmacher/openclaw_training/reports/repair_local_inventory_aliases_and_status_20260502_064118.txt
/home/schattenmacher/openclaw_training/reports/repair_mentor_today_var_safe_20260502_074730.txt
/home/schattenmacher/openclaw_training/reports/repair_mission_control_phase2_allinone_20260502_065313.txt
/home/schattenmacher/openclaw_training/reports/repair_mission_control_phase4_webui_allinone_20260502_072136.txt
/home/schattenmacher/openclaw_training/reports/repair_mission_control_webui_tailwind_20260502_072653.txt
/home/schattenmacher/openclaw_training/reports/repair_mnemosyne_today_var_allinone_20260502_073901.txt
/home/schattenmacher/openclaw_training/reports/repair_mnemosyne_today_var_safe_20260502_073949.txt
/home/schattenmacher/openclaw_training/reports/repair_phase3_deep_security_allinone_20260502_070753.txt
/home/schattenmacher/openclaw_training/reports/repair_phase4_webui_final_safe_20260502_072307.txt
/home/schattenmacher/openclaw_training/reports/repair_shadowmaker_control_bot_20260501_233353.txt
/home/schattenmacher/openclaw_training/reports/setup_discord_shadowmaker_wizard_20260502_001801.txt
/home/schattenmacher/openclaw_training/reports/setup_mission_control_phase2_allinone_20260502_064713.txt
/home/schattenmacher/openclaw_training/reports/setup_mission_control_phase4_webui_allinone_20260502_071917.txt
```

### Dokumente

Index:

```text
/home/schattenmacher/openclaw_training/mission_control/docs/drive_inventory_limited/limited_useful_docs_20260502_134348.txt
```

Auszug:

```text
/home/schattenmacher/AEVO_App/dist/linux-unpacked/LICENSE.electron.txt
/home/schattenmacher/Desktop/AEVO_APP_README.txt
/home/schattenmacher/Desktop/AEVO_Cheatsheet.txt
/home/schattenmacher/Desktop/AEVO_Complete_Guide.txt
/home/schattenmacher/Desktop/AEVO_SCHATTENMACHER_COMMANDS.txt
/home/schattenmacher/Dokumente/Everlast/openclaw_projekt_konsolidiert.md
/home/schattenmacher/Dokumente/transkripte/2025_Technical_Module/2025_05_23_IHK_Session_IHK.txt
/home/schattenmacher/Dokumente/transkripte/ihk-operative-professionals-2024-25/PROJECT_STATUS.md
/home/schattenmacher/Dokumente/transkripte/ihk-operative-professionals-2024-25/README.md
/home/schattenmacher/Dokumente/transkripte/ihk-operative-professionals-2024-25/STATUS.md
/home/schattenmacher/Dokumente/USB_SORTED/2025-04-15/ihk_presentation_with_code.log
/home/schattenmacher/Dokumente/USB_SORTED/2025-06-10/notes-joining-proton_2.png
/home/schattenmacher/Dokumente/USB_SORTED/2025-06-10/notes-joining-proton.png
/home/schattenmacher/Dokumente/USB_SORTED/2025-06-10/shadow_workflow_20250610.log
/home/schattenmacher/Dokumente/USB_SORTED/2025-06-10/workflow_test_20250610_144103.log
/home/schattenmacher/Dokumente/USB_SORTED/2025-06-10/workflow_test_20250610_144420.log
/home/schattenmacher/Dokumente/USB_SORTED/2025-08-20/1_IT_MfPm_H2017_Sit1_P_Anl1zuallen.pdf.txt
/home/schattenmacher/Dokumente/USB_SORTED/2025-08-20/2_IT_MfPm_H2017_Sit2_P_Anl1zuallen.pdf.txt
/home/schattenmacher/Dokumente/USB_SORTED/2025-08-20/2_IT_MfPm_H2017_Sit2_P_Anl2zuallen.pdf.txt
/home/schattenmacher/Dokumente/USB_SORTED/2025-08-20/Arbeitsrecht für SCADA & IHK-Prüfung.pdf.txt
/home/schattenmacher/Dokumente/USB_SORTED/2025-08-20/DIHK 2019 Frühjahr (Mitarbeiterführung Aufgaben _ Lösungshinweise Situation 1 _ 2)01.pdf.txt
/home/schattenmacher/Dokumente/USB_SORTED/2025-08-20/DIHK 2019 Frühjahr (Mitarbeiterführung Aufgaben _ Lösungshinweise Situation 1 _ 2).pdf.txt
/home/schattenmacher/Dokumente/USB_SORTED/2025-08-20/DIHK 2019 Herbst (Mitarbeiterführung Aufgaben _ Lösungshinweise Situation 1 _ 2)01.pdf.txt
/home/schattenmacher/Dokumente/USB_SORTED/2025-08-20/DIHK 2019 Herbst (Mitarbeiterführung Aufgaben _ Lösungshinweise Situation 1 _ 2).pdf.txt
/home/schattenmacher/Dokumente/USB_SORTED/2025-08-20/Gesetzesmarkierung_IHK_Pruefung_DanielMassa.pdf.txt
/home/schattenmacher/Downloads/01_AEVO_Complete_FULL.csv
/home/schattenmacher/Downloads/02_Arbeitsrecht_ParagraphDeck_FULL.csv
/home/schattenmacher/Downloads/AEVO/30min_Vorbereitung_Zeitplan_Template.md
/home/schattenmacher/Downloads/ihk_usb_llm_projektdoku_allinone/ihk_usb_llm_projektdoku_allinone.txt
/home/schattenmacher/Downloads/MFP_Lernplan_52_Tage_Dominanz.md
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG /00_Sonstiges/analysis_map_20260114_002548.tsv
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG /_AEVO_LOGS/content_map_20260114_000334.tsv
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG /_AEVO_LOGS/content_map_20260114_000336.tsv
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG /_AEVO_LOGS/content_map_20260114_000434.tsv
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG /_AEVO_LOGS/content_map_20260114_000755.tsv
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG /_AEVO_LOGS/content_map_20260114_000811.tsv
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG /_AEVO_LOGS/content_map_20260114_001306.tsv
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG /_AEVO_LOGS/content_map_20260114_001342.tsv
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG /_AEVO_LOGS/content_map_20260114_001444.tsv
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG /_AEVO_LOGS/content_map_20260114_001558.tsv
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG /_AEVO_LOGS/content_map_20260114_001619.tsv
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG /_AEVO_LOGS/content_map_20260114_001719.tsv
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG /_AEVO_LOGS/content_map_20260114_001813.tsv
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG /_AEVO_LOGS/rename_map_20260113_234623.tsv
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG /_AEVO_LOGS/rename_map_20260113_234921.tsv
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG /_AEVO_LOGS/rename_map_20260113_235014.tsv
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG /_AEVO_LOGS/rename_map_20260113_235115.tsv
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG /_AEVO_LOGS/rename_map_20260113_235233.tsv
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG /_AEVO_LOGS/rename_map_20260113_235252.tsv
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG /_AEVO_LOGS/rename_map_20260113_235609.tsv
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG /_AEVO_LOGS/rename_map_20260113_235714.tsv
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG /_AEVO_LOGS/rename_map_20260113_235730.tsv
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG /_AEVO_LOGS/rename_map_20260114_000134.tsv
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG /_AEVO_LOGS/rename_map_20260114_000140.tsv
/home/schattenmacher/Downloads/Notebook LM Videos und Audios/AEVO-UNTERWEISUNG/index.md
/home/schattenmacher/Downloads/openclaw/setup.log
/home/schattenmacher/Downloads/SKILL_Jobcenter_Nachweise_Stuttgart.md
/home/schattenmacher/Downloads/Transkripte_VFB_Videos/2025-05-23_IHK_ZoomSession_Unbekannt.txt
/home/schattenmacher/eva-agent-template/logs/agent.log
/home/schattenmacher/eva-agent-template/qa_py.log
/home/schattenmacher/eva-agent-template/README.md
/home/schattenmacher/eva-agent-template/requirements.txt
/home/schattenmacher/EVA_IntelligentAgent/agents/core/README.md
/home/schattenmacher/EVA_IntelligentAgent/AGENTS.md
/home/schattenmacher/EVA_IntelligentAgent/agents/voice/README.md
/home/schattenmacher/EVA_IntelligentAgent/apps/admin/README.md
/home/schattenmacher/EVA_IntelligentAgent/apps/api/README.md
/home/schattenmacher/EVA_IntelligentAgent/apps/web/README.md
/home/schattenmacher/EVA_IntelligentAgent/BOOTSTRAP.md
/home/schattenmacher/EVA_IntelligentAgent/docs/architecture/SYSTEM_BLUEPRINT.md
/home/schattenmacher/EVA_IntelligentAgent/docs/operations/CONTROL_MODEL.md
/home/schattenmacher/EVA_IntelligentAgent/docs/PRODUCT_POSITIONING.md
/home/schattenmacher/EVA_IntelligentAgent/docs/roadmap/ROADMAP_V1.md
/home/schattenmacher/EVA_IntelligentAgent/HEARTBEAT.md
/home/schattenmacher/EVA_IntelligentAgent/IDENTITY.md
/home/schattenmacher/EVA_IntelligentAgent/prompts/eva_system_prompt.md
/home/schattenmacher/EVA_IntelligentAgent/README.md
/home/schattenmacher/EVA_IntelligentAgent/scripts/next_steps.txt
/home/schattenmacher/EVA_IntelligentAgent/SOUL.md
/home/schattenmacher/EVA_IntelligentAgent/_stack_rebuild_reports/20260415_130602/00_inventory.txt
```

### PDFs

Index:

```text
/home/schattenmacher/openclaw_training/mission_control/docs/drive_inventory_limited/limited_useful_pdfs_20260502_134348.txt
```

Auszug:

```text
/home/schattenmacher/AEVO_AD/AEVO_Unterweisung_Active_Directory.pdf
/home/schattenmacher/Dokumente/Ablehnung Ihres Antrages auf einen Laptop/Ablehnung Antrag auf Laptop 23,02,2026.PDF
/home/schattenmacher/Dokumente/Ablehnung Ihres Antrages auf einen Laptop/Ablehnung Ihres Antrages auf einen Laptop.pdf
/home/schattenmacher/Dokumente/Ablehnung Ihres Antrages auf einen Laptop/Widerspruch Laptop-Ablehnung.pdf
/home/schattenmacher/Dokumente/ALL_IN_ONE_OP/00_Rahmenplan_und_Pruefung/ITWB_Rahmenlehrplan.pdf
/home/schattenmacher/Dokumente/ALL_IN_ONE_OP/00_Rahmenplan_und_Pruefung/Prüfungen_Frühjahr_2024.pdf
/home/schattenmacher/Dokumente/Antrag auf Gewährung einer Förderung Vermittlungsbudget ausgefüllt 2/2026-03-09_Antrag-Vermittlungsbudget_IHK-Pruefungsgebuehren_Daniel-Massa_ausgefuellt.pdf
/home/schattenmacher/Dokumente/Antrag auf Gewährung einer Förderung Vermittlungsbudget ausgefüllt 2/2026-03-09_Antrag-Vermittlungsbudget_IHK-Pruefungsgebuehren_Nachweise_Daniel-Massa_Final_korrigiert.pdf
/home/schattenmacher/Dokumente/Antrag auf Gewährung einer Förderung Vermittlungsbudget ausgefüllt 2/2026-03-09_Antrag-Vermittlungsbudget_IHK-Pruefungsgebuehren_Nachweise_Daniel-Massa_Final.pdf
/home/schattenmacher/Dokumente/Antrag auf Gewährung einer Förderung Vermittlungsbudget ausgefüllt 2/2026-03-09_Antrag-Vermittlungsbudget_IHK-Pruefungsgebuehren_Nachweise_Daniel-Massa_korrigiert.pdf
/home/schattenmacher/Dokumente/Antrag auf Gewährung einer Förderung Vermittlungsbudget ausgefüllt 2/2026-03-09_Antrag-Vermittlungsbudget_IHK-Pruefungsgebuehren_Nachweise_Daniel-Massa_leer.PDF
/home/schattenmacher/Dokumente/Antrag auf Gewährung einer Förderung Vermittlungsbudget ausgefüllt 2/2026-03-09_Antrag-Vermittlungsbudget_IHK-Pruefungsgebuehren_Nachweise_Daniel-Massa-merged.pdf
/home/schattenmacher/Dokumente/Antrag auf Gewährung einer Förderung Vermittlungsbudget ausgefüllt 2/2026-03-09_Antrag-Vermittlungsbudget_IHK-Pruefungsgebuehren_Nachweise_Daniel-Massa.pdf
/home/schattenmacher/Dokumente/Antrag auf Gewährung einer Förderung Vermittlungsbudget ausgefüllt 2/2026-03-09_Antrag-Vermittlungsbudget_IHK-Pruefungsgebuehren_Nachweise_Kontoauszuege-3-Monate_Daniel-Massa.pdf
/home/schattenmacher/Dokumente/Antrag auf Gewährung einer Förderung Vermittlungsbudget ausgefüllt 2/Antrag auf Gewährung einer Förderung Vermittlungsbudget 09.03.2026.pdf
/home/schattenmacher/Dokumente/Antrag auf Gewährung einer Förderung Vermittlungsbudget ausgefüllt 2/Antrag auf Gewährung einer Förderung Vermittlungsbudge tleer.pdf
/home/schattenmacher/Dokumente/Antrag auf Gewährung einer Förderung Vermittlungsbudget ausgefüllt 2.pdf
/home/schattenmacher/Dokumente/Arbeitszeugnisse.pdf
/home/schattenmacher/Dokumente/ARCHIV_2026-03-03/01_IHK/Zulassung zur Fortbildung Geprüfter IT - Projektleiter.pdf
/home/schattenmacher/Dokumente/ARCHIV_2026-03-03/02_Karriere_Bewerbung/Bewerbungsunterlagen_Daniel_Massa_2025.pdf
/home/schattenmacher/Dokumente/ARCHIV_2026-03-03/02_Karriere_Bewerbung/Erweiterte Aufgabenliste für das Arbeitszeugnis von Daniel Massa (mit Integration der IT-Service-Desk-Knowledge-Base)_latedst.pdf
/home/schattenmacher/Dokumente/ARCHIV_2026-03-03/04_Finanzen_Behoerden/2025-04-30_Mitwirkung_DanielMassa_Wohngeld_Jobcenter_Stuttgart.pdf
/home/schattenmacher/Dokumente/Bestätigung Prüfungsabsage_Massa.pdf
/home/schattenmacher/Dokumente/Bewerbung als IT Systemadministrator_VRM IT GmbH - 72135 Dettenhausen.pdf
/home/schattenmacher/Dokumente/Bewerbung Datenanalytik PP Stuttgart.pdf
/home/schattenmacher/Dokumente/Bewerbung_PPStuttgart_Datenanalytik_Pers-T-172_Daniel_Massa_FINAL01.pdf
/home/schattenmacher/Dokumente/Bewerbung_PPStuttgart_Datenanalytik_Pers-T-172_Daniel_Massa_FINAL_jobangepasst_ohne_Seite8_v3.pdf
/home/schattenmacher/Dokumente/bewerbung_somi_system_engineer.pdf
/home/schattenmacher/Dokumente/Daniel_Massa_Bewerbung_FINAL_mit_Anhaengen.pdf
/home/schattenmacher/Dokumente/Daniel_Massa_Lebenslauf_Indeed_1Seite.pdf
/home/schattenmacher/Dokumente/Daniel_Massa_Lebenslauf.pdf
/home/schattenmacher/Dokumente/EinLadung Schriftliche Prüfung Geprüfter IT - Projektleiter/EinLadung Schriftliche Prüfung Geprüfter IT - Projektleiter.pdf
/home/schattenmacher/Dokumente/Erinnerung – Antrag vom 08.09.2025 auf Übernahme bzw. Darlehen für Weiterbildungskosten/Erinnerung – Antrag vom 08.09.2025 auf Übernahme bzw. Darlehen für Weiterbildungskosten.pdf
/home/schattenmacher/Dokumente/Erinnerung_Antrag_Weiterbildungskosten_Massa/Erinnerung_Antrag_Weiterbildungskosten_Massa.pdf
/home/schattenmacher/Dokumente/Erweitertes_Führungszeugnis_Massa_03072025.pdf
/home/schattenmacher/Dokumente/FINANZEN_ARCHIV_2026-03-03/FINANZEN_ARCHIV_2026-03-03/01_PFAENDUNG_P-KONTO_RECHT/Antrag auf Ausstellung einer Bescheinigung zur Erhöhung des Pfändungsfreibetrags.pdf
/home/schattenmacher/Dokumente/FINANZEN_ARCHIV_2026-03-03/FINANZEN_ARCHIV_2026-03-03/05_BEHOERDEN_BESCHEIDE/2025-04-30_Mitwirkung_DanielMassa_Wohngeld_Jobcenter_Stuttgart.pdf
/home/schattenmacher/Dokumente/FINANZEN_ARCHIV_2026-03-03/FINANZEN_ARCHIV_2026-03-03/06_KRANKENKASSE_AOK/Befreiung AOK_Antrag 12.03.2025.pdf
/home/schattenmacher/Dokumente/Geprüfte Operative IT Professionals - Teilnehmerunterlagen -/Geprüfte Operative IT Professionals Prüfungen/DIHK Handreichung Operative Prof.pdf
/home/schattenmacher/Dokumente/Geprüfte Operative IT Professionals - Teilnehmerunterlagen -/Geprüfte Operative IT Professionals Prüfungen/Freistellung_Antrag.pdf
/home/schattenmacher/Dokumente/Geprüfte Operative IT Professionals - Teilnehmerunterlagen -/Geprüfte Operative IT Professionals Prüfungen/Frühjahrsprüfung 2016/0 Hilfsmittelliste/HL2016_IT.pdf
/home/schattenmacher/Dokumente/Geprüfte Operative IT Professionals - Teilnehmerunterlagen -/Geprüfte Operative IT Professionals Prüfungen/Frühjahrsprüfung 2016/1 Mitarbeiterführung und Personalmanagement/Aufgaben/Sit1_Anlage1_zu_allen_Aufgaben.pdf
/home/schattenmacher/Dokumente/Geprüfte Operative IT Professionals - Teilnehmerunterlagen -/Geprüfte Operative IT Professionals Prüfungen/Frühjahrsprüfung 2016/1 Mitarbeiterführung und Personalmanagement/Aufgaben/Situationsaufgabe1.pdf
/home/schattenmacher/Dokumente/Geprüfte Operative IT Professionals - Teilnehmerunterlagen -/Geprüfte Operative IT Professionals Prüfungen/Frühjahrsprüfung 2016/1 Mitarbeiterführung und Personalmanagement/Aufgaben/Situationsaufgabe2.pdf
/home/schattenmacher/Dokumente/Geprüfte Operative IT Professionals - Teilnehmerunterlagen -/Geprüfte Operative IT Professionals Prüfungen/Frühjahrsprüfung 2016/1 Mitarbeiterführung und Personalmanagement/Lösungen/Situationsaufgabe1_L.pdf
/home/schattenmacher/Dokumente/Geprüfte Operative IT Professionals - Teilnehmerunterlagen -/Geprüfte Operative IT Professionals Prüfungen/Frühjahrsprüfung 2016/1 Mitarbeiterführung und Personalmanagement/Lösungen/Situationsaufgabe2_L.pdf
/home/schattenmacher/Dokumente/Geprüfte Operative IT Professionals - Teilnehmerunterlagen -/Geprüfte Operative IT Professionals Prüfungen/Frühjahrsprüfung 2016/2 Geprüfter IT-Entwickler (Certified IT Systems Manager)/Aufgaben/Sit1_Anl1_zu_allen_Aufgaben.pdf
/home/schattenmacher/Dokumente/Geprüfte Operative IT Professionals - Teilnehmerunterlagen -/Geprüfte Operative IT Professionals Prüfungen/Frühjahrsprüfung 2016/2 Geprüfter IT-Entwickler (Certified IT Systems Manager)/Aufgaben/Sit2_Anl1_zu_allen_Aufgaben.pdf
/home/schattenmacher/Dokumente/Geprüfte Operative IT Professionals - Teilnehmerunterlagen -/Geprüfte Operative IT Professionals Prüfungen/Frühjahrsprüfung 2016/2 Geprüfter IT-Entwickler (Certified IT Systems Manager)/Aufgaben/Sit3_Anl1_zu_allen_Aufgaben.pdf
/home/schattenmacher/Dokumente/Geprüfte Operative IT Professionals - Teilnehmerunterlagen -/Geprüfte Operative IT Professionals Prüfungen/Frühjahrsprüfung 2016/2 Geprüfter IT-Entwickler (Certified IT Systems Manager)/Aufgaben/Situationsaufgabe1.pdf
/home/schattenmacher/Dokumente/Geprüfte Operative IT Professionals - Teilnehmerunterlagen -/Geprüfte Operative IT Professionals Prüfungen/Frühjahrsprüfung 2016/2 Geprüfter IT-Entwickler (Certified IT Systems Manager)/Aufgaben/Situationsaufgabe2.pdf
/home/schattenmacher/Dokumente/Geprüfte Operative IT Professionals - Teilnehmerunterlagen -/Geprüfte Operative IT Professionals Prüfungen/Frühjahrsprüfung 2016/2 Geprüfter IT-Entwickler (Certified IT Systems Manager)/Aufgaben/Situationsaufgabe3.pdf
/home/schattenmacher/Dokumente/Geprüfte Operative IT Professionals - Teilnehmerunterlagen -/Geprüfte Operative IT Professionals Prüfungen/Frühjahrsprüfung 2016/2 Geprüfter IT-Entwickler (Certified IT Systems Manager)/Lösungen/Situationsaufgabe1_L.pdf
/home/schattenmacher/Dokumente/Geprüfte Operative IT Professionals - Teilnehmerunterlagen -/Geprüfte Operative IT Professionals Prüfungen/Frühjahrsprüfung 2016/2 Geprüfter IT-Entwickler (Certified IT Systems Manager)/Lösungen/Situationsaufgabe2_L.pdf
/home/schattenmacher/Dokumente/Geprüfte Operative IT Professionals - Teilnehmerunterlagen -/Geprüfte Operative IT Professionals Prüfungen/Frühjahrsprüfung 2016/2 Geprüfter IT-Entwickler (Certified IT Systems Manager)/Lösungen/Situationsaufgabe3_L.pdf
/home/schattenmacher/Dokumente/Geprüfte Operative IT Professionals - Teilnehmerunterlagen -/Geprüfte Operative IT Professionals Prüfungen/Frühjahrsprüfung 2016/3 Geprüfter IT-Projektleiter (Certified IT Business Manager)/Aufgaben/Sit1_Anl1_zu_allen_Aufggaben.pdf
/home/schattenmacher/Dokumente/Geprüfte Operative IT Professionals - Teilnehmerunterlagen -/Geprüfte Operative IT Professionals Prüfungen/Frühjahrsprüfung 2016/3 Geprüfter IT-Projektleiter (Certified IT Business Manager)/Aufgaben/Sit2_Anl1_zu_allen_Aufgaben.pdf
/home/schattenmacher/Dokumente/Geprüfte Operative IT Professionals - Teilnehmerunterlagen -/Geprüfte Operative IT Professionals Prüfungen/Frühjahrsprüfung 2016/3 Geprüfter IT-Projektleiter (Certified IT Business Manager)/Aufgaben/Sit3_Anl1_zu_allen_Aufgaben.pdf
/home/schattenmacher/Dokumente/Geprüfte Operative IT Professionals - Teilnehmerunterlagen -/Geprüfte Operative IT Professionals Prüfungen/Frühjahrsprüfung 2016/3 Geprüfter IT-Projektleiter (Certified IT Business Manager)/Aufgaben/Situationsaufgabe1.pdf
/home/schattenmacher/Dokumente/Geprüfte Operative IT Professionals - Teilnehmerunterlagen -/Geprüfte Operative IT Professionals Prüfungen/Frühjahrsprüfung 2016/3 Geprüfter IT-Projektleiter (Certified IT Business Manager)/Aufgaben/Situationsaufgabe2.pdf
/home/schattenmacher/Dokumente/Geprüfte Operative IT Professionals - Teilnehmerunterlagen -/Geprüfte Operative IT Professionals Prüfungen/Frühjahrsprüfung 2016/3 Geprüfter IT-Projektleiter (Certified IT Business Manager)/Aufgaben/Situationsaufgabe3.pdf
/home/schattenmacher/Dokumente/Geprüfte Operative IT Professionals - Teilnehmerunterlagen -/Geprüfte Operative IT Professionals Prüfungen/Frühjahrsprüfung 2016/3 Geprüfter IT-Projektleiter (Certified IT Business Manager)/Lösungen/Situationsaufgabe1_L.pdf
/home/schattenmacher/Dokumente/Geprüfte Operative IT Professionals - Teilnehmerunterlagen -/Geprüfte Operative IT Professionals Prüfungen/Frühjahrsprüfung 2016/3 Geprüfter IT-Projektleiter (Certified IT Business Manager)/Lösungen/Situationsaufgabe2_L.pdf
/home/schattenmacher/Dokumente/Geprüfte Operative IT Professionals - Teilnehmerunterlagen -/Geprüfte Operative IT Professionals Prüfungen/Frühjahrsprüfung 2016/3 Geprüfter IT-Projektleiter (Certified IT Business Manager)/Lösungen/Situationsaufgabe3_L.pdf
/home/schattenmacher/Dokumente/Geprüfte Operative IT Professionals - Teilnehmerunterlagen -/Geprüfte Operative IT Professionals Prüfungen/Frühjahrsprüfung 2016/4 Geprüfter IT-Berater (Certified IT Business Consultant)/Aufgaben/Sit1_Anl1_zu_allen_Aufgaben.pdf
/home/schattenmacher/Dokumente/Geprüfte Operative IT Professionals - Teilnehmerunterlagen -/Geprüfte Operative IT Professionals Prüfungen/Frühjahrsprüfung 2016/4 Geprüfter IT-Berater (Certified IT Business Consultant)/Aufgaben/Sit1_Anl2_zu_Aufgabe5.pdf
/home/schattenmacher/Dokumente/Geprüfte Operative IT Professionals - Teilnehmerunterlagen -/Geprüfte Operative IT Professionals Prüfungen/Frühjahrsprüfung 2016/4 Geprüfter IT-Berater (Certified IT Business Consultant)/Aufgaben/Sit2_Anl1_zu_allen_Aufgaben.pdf
/home/schattenmacher/Dokumente/Geprüfte Operative IT Professionals - Teilnehmerunterlagen -/Geprüfte Operative IT Professionals Prüfungen/Frühjahrsprüfung 2016/4 Geprüfter IT-Berater (Certified IT Business Consultant)/Aufgaben/Sit3_Anl1_zu_allen_Aufgaben.pdf
/home/schattenmacher/Dokumente/Geprüfte Operative IT Professionals - Teilnehmerunterlagen -/Geprüfte Operative IT Professionals Prüfungen/Frühjahrsprüfung 2016/4 Geprüfter IT-Berater (Certified IT Business Consultant)/Aufgaben/Situationsaufgabe1.pdf
/home/schattenmacher/Dokumente/Geprüfte Operative IT Professionals - Teilnehmerunterlagen -/Geprüfte Operative IT Professionals Prüfungen/Frühjahrsprüfung 2016/4 Geprüfter IT-Berater (Certified IT Business Consultant)/Aufgaben/Situationsaufgabe2.pdf
/home/schattenmacher/Dokumente/Geprüfte Operative IT Professionals - Teilnehmerunterlagen -/Geprüfte Operative IT Professionals Prüfungen/Frühjahrsprüfung 2016/4 Geprüfter IT-Berater (Certified IT Business Consultant)/Aufgaben/Situationsaufgabe3.pdf
/home/schattenmacher/Dokumente/Geprüfte Operative IT Professionals - Teilnehmerunterlagen -/Geprüfte Operative IT Professionals Prüfungen/Frühjahrsprüfung 2016/4 Geprüfter IT-Berater (Certified IT Business Consultant)/Lösungen/Situationsaufgabe1_L.pdf
/home/schattenmacher/Dokumente/Geprüfte Operative IT Professionals - Teilnehmerunterlagen -/Geprüfte Operative IT Professionals Prüfungen/Frühjahrsprüfung 2016/4 Geprüfter IT-Berater (Certified IT Business Consultant)/Lösungen/Situationsaufgabe2_L.pdf
/home/schattenmacher/Dokumente/Geprüfte Operative IT Professionals - Teilnehmerunterlagen -/Geprüfte Operative IT Professionals Prüfungen/Frühjahrsprüfung 2016/4 Geprüfter IT-Berater (Certified IT Business Consultant)/Lösungen/Situationsaufgabe3_L.pdf
/home/schattenmacher/Dokumente/Geprüfte Operative IT Professionals - Teilnehmerunterlagen -/Geprüfte Operative IT Professionals Prüfungen/Herbstprüfung 2016/0 Hilfsmittelliste/HL2016_IT.pdf
/home/schattenmacher/Dokumente/Geprüfte Operative IT Professionals - Teilnehmerunterlagen -/Geprüfte Operative IT Professionals Prüfungen/Herbstprüfung 2016/1 Mitarbeiterführung und Personalmanagement/Aufgaben/Sit1_Anl1_zu_allen_Aufgaben.pdf
/home/schattenmacher/Dokumente/Geprüfte Operative IT Professionals - Teilnehmerunterlagen -/Geprüfte Operative IT Professionals Prüfungen/Herbstprüfung 2016/1 Mitarbeiterführung und Personalmanagement/Aufgaben/Sit2_Anl1_zu_allen_Aufgaben.pdf
/home/schattenmacher/Dokumente/Geprüfte Operative IT Professionals - Teilnehmerunterlagen -/Geprüfte Operative IT Professionals Prüfungen/Herbstprüfung 2016/1 Mitarbeiterführung und Personalmanagement/Aufgaben/Situationsaufgabe1.pdf
/home/schattenmacher/Dokumente/Geprüfte Operative IT Professionals - Teilnehmerunterlagen -/Geprüfte Operative IT Professionals Prüfungen/Herbstprüfung 2016/1 Mitarbeiterführung und Personalmanagement/Aufgaben/Situationsaufgabe2.pdf
/home/schattenmacher/Dokumente/Geprüfte Operative IT Professionals - Teilnehmerunterlagen -/Geprüfte Operative IT Professionals Prüfungen/Herbstprüfung 2016/1 Mitarbeiterführung und Personalmanagement/Lösungen/Situationsaufgabe1_L.pdf
```

## 9 Sensible Pfadtreffer

Nur Pfade, keine Inhalte:

```text
/home/schattenmacher/openclaw_training/mission_control/docs/drive_inventory_limited/limited_sensitive_path_hits_20260502_134348.txt
```

Nicht ungeprüft extern teilen.

## 10 Bewertung

Die begrenzte Analyse ist geeignet für Kontrolle und Planung. Für tiefe Inhaltsanalyse sollten gezielte Ordner gewählt werden.

Priorität für nächste Tiefenanalyse:

1. openclaw_training
2. usb-llm-data-pipeline
3. local_llm_pipeline
4. Dokumente / Documents
5. AEVO / IHK
6. EVA / AgentEva
7. ausgewählte externe Laufwerke nur nach Bedarf

## 11 Nicht automatisieren

- Vollscan externer Laufwerke
- ungeprüfte PDF-Inhaltsanalyse
- sensible Dateiinhalte
- Repair-/Docker-/Patch-Skripte
- Timer-Aktivierung

## 12 Nächster Schritt

Kandidaten prüfen:

```bash
limited-drive-status
limited-drive-summary
limited-drive-useful-scripts
limited-drive-useful-pdfs
limited-drive-sensitive
```

