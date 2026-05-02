# Lokale KI-Systemdokumentation – Shadowmaker/OpenClaw

Stand: Sa 2. Mai 12:13:52 CEST 2026

## 1 Gesamtstatus

Diese Dokumentation beschreibt den lokal aufgebauten KI-/Agenten-Stack auf diesem System.

Ziel:
- lokale KI-Komponenten erfassen
- funktionierende Module dokumentieren
- Befehle und Pfade zentral sichern
- OpenClaw/Mission Control als operative Steuerungsbasis nutzen
- keine Secrets dokumentieren
- keine produktiven Änderungen ausführen

## 2 Host

```text
Host: schattenmacher-D3161-B1
Linux schattenmacher-D3161-B1 6.17.0-23-generic #23~24.04.1-Ubuntu SMP PREEMPT_DYNAMIC Tue Apr 14 16:11:48 UTC 2 x86_64 x86_64 x86_64 GNU/Linux
 12:13:42 up  1:15,  1 user,  load average: 3,55, 4,72, 3,24
```

## 3 Hardware / Ressourcen

### RAM

```text
               gesamt       benutzt     frei      gemns.  Puffer/Cache verfügbar
Speicher:       31Gi        11Gi       3,8Gi       236Mi        17Gi        19Gi
Auslager:      2,0Gi          0B       2,0Gi
```

### Root Disk

```text
Dateisystem    Größe Benutzt Verf. Verw% Eingehängt auf
/dev/sda2       1,8T    1,1T  629G   64% /
```

### GPU

```text
NVIDIA GeForce RTX 3060, 12288 MiB, 580.142
```

## 4 Docker / lokale Dienste

```text
openclaw-openclaw-gateway-1 | openclaw:local | Up About an hour | 127.0.0.1:18789->18789/tcp
shadowmaker-agents | flowiseai/flowise:latest | Up About an hour | 0.0.0.0:3001->3000/tcp, [::]:3001->3000/tcp
shadow-command-hub | docker.n8n.io/n8nio/n8n:latest | Up About an hour | 0.0.0.0:5678->5678/tcp, [::]:5678->5678/tcp
shadow-postgres | postgres:16-alpine | Up About an hour (healthy) | 5432/tcp
shadow-redis | redis:7-alpine | Up About an hour (healthy) | 6379/tcp
open-webui | ghcr.io/open-webui/open-webui:main | Up About an hour (healthy) | 0.0.0.0:3000->8080/tcp, [::]:3000->8080/tcp
```

### Docker Images

```text
alpine/socat:latest | 9.74MB
n8nio/n8n:latest | 1.35GB
docker.n8n.io/n8nio/n8n:latest | 1.35GB
flowiseai/flowise:latest | 3.4GB
ghcr.io/open-webui/open-webui:cuda | 11GB
ghcr.io/open-webui/open-webui:main | 4.74GB
postgres:16-alpine | 276MB
redis:7-alpine | 41.4MB
openclaw:local | 4.66GB
biot-telegram-bot:latest | 145MB
shadow-agent:latest | 825MB
shadow-agent-shadowagent:latest | 157MB
ghcr.io/openclaw/openclaw:latest | 4.26GB
ghcr.io/berriai/litellm:main-latest | 1.87GB
docker.litellm.ai/berriai/litellm:main-stable | 1.87GB
litellm/litellm:v1.81.3-stable | 1.6GB
localai/localai:v3.11.0-gpu-nvidia-cuda-12 | 6.26GB
alpine:3.20 | 7.81MB
alpine:latest | 8.44MB
ghcr.io/open-webui/open-webui:v0.6.5 | 4.59GB
nvidia/cuda:12.4.1-base-ubuntu22.04 | 244MB
curlimages/curl:8.5.0 | 22.1MB
ghcr.io/berriai/litellm:main | 827MB
```

## 5 Relevante Ports

```text
tcp   LISTEN 0      4096                                 127.0.0.1:18789      0.0.0.0:*                                            
tcp   LISTEN 0      4096                                   0.0.0.0:3001       0.0.0.0:*                                            
tcp   LISTEN 0      4096                                   0.0.0.0:3000       0.0.0.0:*                                            
tcp   LISTEN 0      4096                                   0.0.0.0:5678       0.0.0.0:*                                            
tcp   LISTEN 0      4096                                      [::]:3001          [::]:*                                            
tcp   LISTEN 0      4096                                      [::]:3000          [::]:*                                            
tcp   LISTEN 0      4096                                      [::]:5678          [::]:*                                            
```

## 6 HTTP-Checks

### OpenClaw Gateway – 127.0.0.1:18789

```text
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
curl: (56) Recv failure: Die Verbindung wurde vom Kommunikationspartner zurückgesetzt
```

Bewertung:
OpenClaw gilt als lokal vorhanden, wenn Container und Port aktiv sind. Ein Host-HTTP-Warnsignal wird als bekannter Prüfpunkte geführt, sofern containerseitig der Dienst läuft.

### Mission Control WebUI – 127.0.0.1:4173

```text
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
curl: (7) Failed to connect to 127.0.0.1 port 4173 after 0 ms: Couldn't connect to server
```

### Open WebUI – 127.0.0.1:3000

```text
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0  0  7480    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
HTTP/1.1 200 OK
date: Sat, 02 May 2026 10:13:42 GMT
server: uvicorn
content-type: text/html; charset=utf-8
accept-ranges: bytes
content-length: 7480
last-modified: Fri, 27 Mar 2026 00:30:19 GMT
etag: "e167a58a1baf907f55a2925a2e8665d1"
x-process-time: 0

```

### Flowise – 127.0.0.1:3001

```text
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0  0  3142    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
HTTP/1.1 200 OK
Vary: Origin
Accept-Ranges: bytes
Cache-Control: public, max-age=0
Last-Modified: Tue, 14 Apr 2026 11:32:51 GMT
ETag: W/"c46-19d8bc3feb8"
Content-Type: text/html; charset=UTF-8
Content-Length: 3142
Date: Sat, 02 May 2026 10:13:42 GMT
Connection: keep-alive
Keep-Alive: timeout=5

```

### n8n – 127.0.0.1:5678

```text
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0  0 16486    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
HTTP/1.1 200 OK
Accept-Ranges: bytes
Cache-Control: public, max-age=86400
Last-Modified: Sat, 02 May 2026 08:59:00 GMT
ETag: W/"4066-19de7e99c39"
Content-Type: text/html; charset=utf-8
Content-Length: 16486
Vary: Accept-Encoding
Date: Sat, 02 May 2026 10:13:42 GMT
Connection: keep-alive
Keep-Alive: timeout=5

```

## 7 Funktionierende lokale KI-Komponenten

### 7.1 OpenClaw

Pfad:
```text
/home/schattenmacher/.openclaw
/home/schattenmacher/.openclaw/workspace
```

Bekannte Rolle:
- lokaler Agenten-/Gateway-Kern
- Steuerung über Mission Control und Shadowmaker-Struktur
- Status über Winky und Security Health prüfbar

Aktueller Betriebsstatus:
- Port 18789 wird überwacht
- Docker-Container wird durch Winky geprüft
- Host-HTTP kann Warnungen erzeugen und bleibt ein Beobachtungspunkt

### 7.2 Mission Control WebUI

Pfad:
```text
/home/schattenmacher/openclaw_training/mission_control/webui
```

URL:
```text
http://127.0.0.1:4173
```

Rolle:
- lokale read-only Oberfläche
- echte Workspace-/Mission-Control-Daten
- keine Secrets
- keine Schreibaktionen

Befehle:
```bash
mission-control-webui-status
mission-control-webui-start
mc4-status
```

### 7.3 Multi-Agent Crew

Aktiv produktiv, aber manuell steuerbar:

```bash
winky-run
mnemosyne-run
mentor-run
strategist-run
steward-run
linky-run
```

Agenten:
- Winky: System Monitor
- Mnemosyne: Memory Curator
- Mentor: IHK/MFP Drill Agent
- Strategist: Career/CV/Recruiter Agent
- Steward: Finance/Housing/Jobcenter read-only Agent
- Linky: Builder/Prompt-to-Code Agent
- CrashBandicot: Control/Telegram/Freeze/Status

Wichtige Pfade:
```text
/home/schattenmacher/openclaw_training/mission_control/agent_runtime
/home/schattenmacher/openclaw_training/mission_control/agents
/home/schattenmacher/openclaw_training/mission_control/tasks
/home/schattenmacher/openclaw_training/mission_control/memory_wiki
```

### 7.4 Courier Mail Briefing

Aktuelle Architektur:
- Gmail über ChatGPT Gmail Connector/App
- Proton lokal über Proton Bridge + Courier
- Courier lokal: Proton-only
- lokales Gmail OAuth: deaktiviert

Befehle:
```bash
courier-status
courier-run
courier-latest
```

Pfade:
```text
/home/schattenmacher/openclaw_training/mission_control/mail_briefing/config/courier.env
/home/schattenmacher/openclaw_training/mission_control/mail_briefing/briefs/latest_courier_mail_brief.md
```

Sicherheitsmodus:
- read-only
- keine Mails senden
- keine Mails löschen
- keine Mails archivieren
- keine Anhänge öffnen
- Discord nur Kurzstatus

### 7.5 RAG / IHK Training

Bekannte Rolle:
- IHK/MFP-Training
- SA1/SA2/SA3-Drills
- Prüfungssimulation
- 10-Punkte-Struktur
- lokale RAG-/Scoring-Artefakte

Pfade:
```text
/home/schattenmacher/openclaw_training/src
/home/schattenmacher/openclaw_training/artifacts
/home/schattenmacher/openclaw_training/reports
/home/schattenmacher/openclaw_training/artifacts/chroma_multi
```

### 7.6 LoRA / lokale Trainingspipeline

Bekannte lokale KI-Pfade:
```text
/home/schattenmacher/usb-llm-data-pipeline
/home/schattenmacher/local_llm_pipeline
/home/schattenmacher/openclaw_training/artifacts/lora_training
```

Bekannte Funktionen:
- JSONL-Datenvorbereitung
- Train/Val/Test-Splits
- LoRA-Testläufe
- lokale Adaptertests
- RAG-/Benchmark-Workflows

### 7.7 Open WebUI

Rolle:
- lokale LLM-Weboberfläche
- Docker-basiert
- Port 3000

### 7.8 Flowise

Rolle:
- visuelle KI-/Agentenflows
- Port 3001
- Docker-basiert

### 7.9 n8n

Rolle:
- Workflow-Automatisierung
- Port 5678
- Docker-basiert

## 8 Autostart / Timer

```text
NEXT                             LEFT LAST                               PASSED UNIT                                     ACTIVATES
Sat 2026-05-02 21:00:00 CEST       8h Sat 2026-05-02 09:00:00 CEST            - openclaw-security-health.timer           openclaw-security-health.service
Sat 2026-05-02 21:00:03 CEST       8h Sat 2026-05-02 09:01:40 CEST            - shadowmaker-security-audit-discord.timer shadowmaker-security-audit-discord.service
```

Aktuell gewollter Zustand:
- Security Health automatisch aktiv
- Security Audit Discord automatisch aktiv
- Phase-5-Agenten manuell
- Courier manuell
- defekte ShadowOps Timer deaktiviert

## 9 Failed Units

### User

```text
  UNIT LOAD ACTIVE SUB DESCRIPTION

0 loaded units listed.
```

### System

```text
  UNIT                    LOAD   ACTIVE SUB    DESCRIPTION
● casper-md5check.service loaded failed failed casper-md5check Verify Live ISO checksums

Legend: LOAD   → Reflects whether the unit definition was properly loaded.
        ACTIVE → The high-level unit activation state, i.e. generalization of SUB.
        SUB    → The low-level unit activation state, values depend on unit type.

1 loaded units listed.
```

## 10 ShadowOps Entscheidung

ShadowOps Autopilot und ShadowOps Log Push wurden deaktiviert, weil SHADOWOPS_PASSPHRASE fehlte und dadurch wiederkehrende Fehler entstanden.

Bewertung:
- richtige Stabilitätsentscheidung
- weniger Autostart-Lärm
- weniger CPU-Verbrauch
- Security Audit bleibt erhalten

## 11 Git-Status

### Letzte Commits

```text
15e61946 Freeze report via Telegram command 20260502_110557
208385f4 Freeze report via Telegram command 20260502_105021
8c7300f0 Set Phase 6 mail architecture Gmail app Proton local 20260502_104921
26d8ce65 Freeze report via Telegram command 20260502_100002
0d1a5a78 Prepare Phase 6 Courier mail briefing read-only 20260502_094411
48267dc6 Freeze report via Telegram command 20260502_093428
ddc7fe37 Activate Linky builder prompt-to-code agent 20260502_081321
91a8c9b2 Freeze report via Telegram command 20260502_080905
d9d6bab5 Activate Steward finance housing read-only agent 20260502_080609
5c7edfad Freeze report via Telegram command 20260502_075725
1ef8b50b Activate Strategist career agent 20260502_075509
0cbd03bf Freeze report via Telegram command 20260502_074840
4c766085 Repair Mentor TODAY variable and activate agent 20260502_074730
500cfa17 Freeze report via Telegram command 20260502_074105
b944010f Repair Mnemosyne TODAY variable safe 20260502_073949
b13c3c69 Activate Mnemosyne memory curator agent 20260502_073747
a6045c53 Freeze report via Telegram command 20260502_073347
9ce982e5 Start Phase 5 multi-agent crew with Winky 20260502_073235
34d4e255 Freeze report via Telegram command 20260502_072817
82ebe98f Repair Mission Control WebUI Tailwind config 20260502_072653
7fd93376 Finalize Mission Control Phase 4 WebUI 20260502_072307
29146e0c Freeze report via Telegram command 20260502_070907
e77a6951 Repair Phase 3 deep security module 20260502_070753
da3c23e9 Freeze report via Telegram command 20260502_065448
93ccd73e Repair and finalize Mission Control Phase 2 20260502_065313
```

### Working Tree

```text
 M src/pruefungssimulator.py
?? build_final_training.py
?? local_exam_ai_test.sh
?? pipeline/
?? prepare_final_dataset_split.sh
?? run_final_scorer_test.sh
?? src/autonomous_mfp_training_workflow.py
?? src/autonomous_silver_workflow.py
?? src/autonomous_silver_workflow_v2.py
?? src/autonomous_silver_workflow_v2.py.bak.heading_detection.20260425_032418
?? src/final_scorer_test.py
?? src/generate_silver_from_bronze.py
?? src/generate_silver_ollama.py
?? src/generate_silver_ollama.py.bak.input_gate.20260425_011911
?? src/generate_silver_ollama.py.bak.quality_gate.20260425_005800
?? src/hermes_agent.py
?? src/hermes_agent.py.bak.20260424_223602
?? src/hermes_agent.py.bak.intent_batch.20260424_224300
?? src/hermes_agent.py.bak.scorer_menu.20260424_223722
?? src/hermes_agent.py.bak.timeout_modes.20260424_224122
?? src/local_exam_ai_test.py
?? src/local_exam_ai_test.py.bak.auto_mfp.20260425_045643
?? src/local_exam_ai_test.py.bak.local_exam_v2.20260425_044223
?? src/local_exam_ai_test.py.bak.local_exam_v2_1.20260425_044455
?? src/local_exam_ai_test.py.bak.muster_scorer_v2.20260425_045241
?? src/local_exam_ai_test.py.bak.musterloesung_mode.20260425_045111
?? src/pruefungssimulator.py.bak.20260415_182548
?? src/pruefungssimulator.py.bak.20260415_184011
?? src/pruefungssimulator.py.bak.20260415_193434
?? src/pruefungssimulator.py.bak.avg_norm.20260424_225354
?? src/pruefungssimulator.py.bak.batch_full_output.20260424_230327
?? src/pruefungssimulator.py.bak.broken_full_output.20260424_230400
?? src/pruefungssimulator.py.bak.fstring_final.20260424_230522
?? src/pruefungssimulator.py.bak.full_output.20260424_225727
?? src/pruefungssimulator.py.bak.indent_repair.20260424_224920
?? src/pruefungssimulator.py.bak.regex_full_final.20260424_230445
?? src/pruefungssimulator.py.bak.score_norm.20260424_224744
?? src/pruefungssimulator.py.bak.timer_indent.20260424_224953
?? src/test_mfp_lora_adapter.py
?? src/test_mfp_lora_adapter.py.bak.inference_v2.20260425_052910
?? src/train_mfp_lora.py
?? src/train_mfp_lora.py.bak.compat.20260425_050108
?? test_hermes_agent.sh
?? triage_task_types.py
```

## 12 Timeshift / Freeze

Letzter dokumentierter stabiler Stand aus Terminalverlauf:
```text
2026-05-02_11-06-37
Shadowmaker stable freeze after disabling broken ShadowOps timers
```

Timeshift-List, falls ohne Passwort abrufbar:

```text
Nicht ohne sudo abrufbar
```

## 13 Relevante lokale KI-Pfade

Details:
```text
/home/schattenmacher/openclaw_training/mission_control/docs/local_ai_inventory/local_ai_paths_20260502_121342.txt
```

## 14 Master-Befehle

### Gesamtlage

```bash
phase5-status
phase5-crew-status
mission-control-webui-status
courier-status
deep-security-check
```

### Agenten

```bash
winky-run
mnemosyne-run
mentor-run
strategist-run
steward-run
linky-run
```

### Mail

```bash
courier-run
courier-latest
```

### WebUI

```bash
mission-control-webui-start
```

### Sicherheit

```bash
systemctl --user list-timers --all | grep -E 'openclaw|shadowmaker|security|shadowops'
systemctl --user --failed
```

## 15 Bewertung

Das lokale KI-System besteht aus mehreren funktionierenden Schichten:

1. Infrastruktur: Docker, Postgres, Redis, lokale Ports
2. KI-Oberflächen: Open WebUI, Flowise, Mission Control WebUI
3. Agenten: Winky, Mnemosyne, Mentor, Strategist, Steward, Linky
4. Mail-Intelligence: Courier Proton lokal und Gmail über App
5. Lernsystem: IHK/MFP Drill-/Scoring-/RAG-Struktur
6. Sicherheit: Security Audit, Freeze Reports, Timeshift
7. Dokumentation: Memory Wiki und lokale Reports

Operativer Status:
Das System ist produktiv nutzbar, aber kontrolliert. Autonomie bleibt begrenzt. Kritische Aktionen bleiben manuell.

## 16 Nächste sinnvolle Schritte

1. Keine neuen Timer aktivieren.
2. Winky und Mnemosyne weiter manuell nutzen.
3. Courier morgens manuell laufen lassen.
4. OpenClaw Host-HTTP-Warnung separat prüfen, aber nicht während stabiler Phase anfassen.
5. Master-Inventur regelmäßig aktualisieren.
6. Nach jeder größeren Änderung Freeze Report und Timeshift.

