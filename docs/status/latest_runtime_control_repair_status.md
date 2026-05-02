# Runtime Control Repair Status

Stand: Sa 2. Mai 14:01:37 CEST 2026

## Ergebnis

Runtime-Kontrolle wurde bereinigt.

## WebUI

Mission Control WebUI HTTP:

```text
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
HTTP/1.1 200 OK
Vary: rsc, next-router-state-tree, next-router-prefetch, next-router-segment-prefetch, Accept-Encoding
Cache-Control: no-cache, must-revalidate
X-Powered-By: Next.js
Content-Type: text/html; charset=utf-8
Date: Sat, 02 May 2026 12:01:37 GMT
Connection: keep-alive
Keep-Alive: timeout=5

```

## Proton Bridge

Status:
active

Port 1143:

```text
tcp   LISTEN 0      4096       127.0.0.1:1143       0.0.0.0:*    users:(("bridge",pid=183258,fd=10))         
```

## ShadowOps

- shadowops-autopilot.timer bleibt deaktiviert.
- shadowops-log-push.timer bleibt deaktiviert.
- alte Hinweise in Winky/Mnemosyne wurden korrigiert, soweit in Skripten vorhanden.

## Aliase

In nicht-interaktiven Skripten keine Aliase verwenden. Stattdessen:

```bash
"/home/schattenmacher/winky_system_monitor_agent.sh"
"/home/schattenmacher/mnemosyne_memory_curator_agent.sh"
"/home/schattenmacher/courier_mail_briefing_run.sh"
```

## Sicherheitsstatus

- kein sudo
- keine Timer aktiviert
- keine Löschung
- keine Secrets gelesen
- keine Mails verändert
- kein Docker-Rebuild

## Report

/home/schattenmacher/openclaw_training/reports/repair_control_runtime_webui_courier_shadowops_allinone_20260502_140126.txt

## Control Report

/home/schattenmacher/openclaw_training/mission_control/control_runs/latest_runtime_control_repair.md

## Nächste Prüfung

```bash
source ~/.bashrc
systemctl --user --failed
systemctl --user list-timers --all | grep -E 'winky|mnemosyne|courier|openclaw|shadowmaker|security|shadowops'
mission-control-webui-status
courier-status
```

