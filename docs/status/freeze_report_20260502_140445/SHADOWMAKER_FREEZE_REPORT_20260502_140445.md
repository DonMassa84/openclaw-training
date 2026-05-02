# Shadowmaker Freeze Report

Stand: Sa 2. Mai 14:04:56 CEST 2026

## 1. Kernstatus

| Bereich | Status |
|---|---:|
| CrashBandicot | OK |
| SchattenWatchBot | OK |
| BackupBot | OK |
| OpenClaw container-intern | YES |
| Flowise | YES |
| n8n | YES |
| Telegram IPv4 | YES |
| Telegram IPv6 | NO |

## 2. Betriebsstandard

OpenClaw gilt als funktionsfähig, wenn der container-interne Test `HTTP/1.1 200 OK` liefert.

Der Host-Test auf `http://127.0.0.1:18789` darf mit Reset/Fail reagieren und ist als Binding-Einschränkung dokumentiert.

## 3. Docker

```text
NAMES                         IMAGE                                STATUS                 PORTS
openclaw-openclaw-gateway-1   openclaw:local                       Up 3 hours             127.0.0.1:18789->18789/tcp
shadowmaker-agents            flowiseai/flowise:latest             Up 3 hours             0.0.0.0:3001->3000/tcp, [::]:3001->3000/tcp
shadow-command-hub            docker.n8n.io/n8nio/n8n:latest       Up 3 hours             0.0.0.0:5678->5678/tcp, [::]:5678->5678/tcp
shadow-postgres               postgres:16-alpine                   Up 3 hours (healthy)   5432/tcp
shadow-redis                  redis:7-alpine                       Up 3 hours (healthy)   6379/tcp
open-webui                    ghcr.io/open-webui/open-webui:main   Up 3 hours (healthy)   0.0.0.0:3000->8080/tcp, [::]:3000->8080/tcp
```

## 4. OpenClaw intern

```text
HTTP/1.1 200 OK
X-Content-Type-Options: nosniff
Referrer-Policy: no-referrer
X-Frame-Options: DENY
Content-Security-Policy: default-src 'self'; base-uri 'none'; object-src 'none'; frame-ancestors 'none'; script-src 'self'; style-src 'self' 'unsafe-inline'; img-src 'self' data: https:; font-src 'self'; connect-src 'self' ws: wss:
Content-Type: text/html; charset=utf-8
Cache-Control: no-cache
Date: Sat, 02 May 2026 12:04:45 GMT
Connection: keep-alive
Keep-Alive: timeout=5

```

## 5. Flowise

```text
HTTP/1.1 200 OK
Vary: Origin
Accept-Ranges: bytes
Cache-Control: public, max-age=0
Last-Modified: Tue, 14 Apr 2026 11:32:51 GMT
ETag: W/"c46-19d8bc3feb8"
Content-Type: text/html; charset=UTF-8
Content-Length: 3142
Date: Sat, 02 May 2026 12:04:45 GMT
Connection: keep-alive
```

## 6. n8n

```text
HTTP/1.1 200 OK
Accept-Ranges: bytes
Cache-Control: public, max-age=86400
Last-Modified: Sat, 02 May 2026 08:59:00 GMT
ETag: W/"4066-19de7e99c39"
Content-Type: text/html; charset=utf-8
Content-Length: 16486
Vary: Accept-Encoding
Date: Sat, 02 May 2026 12:04:45 GMT
Connection: keep-alive
```

## 7. Telegram IPv4

```text
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0  0   145    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
HTTP/2 302 
server: nginx/1.18.0
date: Sat, 02 May 2026 12:04:46 GMT
content-type: text/html
content-length: 145
location: https://core.telegram.org/bots
strict-transport-security: max-age=31536000; includeSubDomains; preload
access-control-allow-origin: *
access-control-allow-methods: GET, POST, OPTIONS
access-control-expose-headers: Content-Length,Content-Type,Date,Server,Connection

```

## 8. Telegram IPv6

```text
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0  0     0    0     0    0     0      0      0 --:--:--  0:00:01 --:--:--     0  0     0    0     0    0     0      0      0 --:--:--  0:00:02 --:--:--     0  0     0    0     0    0     0      0      0 --:--:--  0:00:03 --:--:--     0  0     0    0     0    0     0      0      0 --:--:--  0:00:04 --:--:--     0  0     0    0     0    0     0      0      0 --:--:--  0:00:05 --:--:--     0  0     0    0     0    0     0      0      0 --:--:--  0:00:06 --:--:--     0  0     0    0     0    0     0      0      0 --:--:--  0:00:07 --:--:--     0  0     0    0     0    0     0      0      0 --:--:--  0:00:08 --:--:--     0  0     0    0     0    0     0      0      0 --:--:--  0:00:09 --:--:--     0  0     0    0     0    0     0      0      0 --:--:--  0:00:10 --:--:--     0
curl: (28) Connection timed out after 10001 milliseconds
```

## 9. Failed Services User

```text
  UNIT LOAD ACTIVE SUB DESCRIPTION

0 loaded units listed.
```

## 10. Failed Services System

```text
  UNIT                    LOAD   ACTIVE SUB    DESCRIPTION
● casper-md5check.service loaded failed failed casper-md5check Verify Live ISO checksums

Legend: LOAD   → Reflects whether the unit definition was properly loaded.
        ACTIVE → The high-level unit activation state, i.e. generalization of SUB.
        SUB    → The low-level unit activation state, values depend on unit type.

1 loaded units listed.
```

## 11. Offene Punkte

```text
- ShadowOps Autopilot separat reparieren oder deaktivieren.
- ShadowOps Log Push separat reparieren oder deaktivieren.
- casper-md5check.service ist unkritisch.
- Telegram IPv6 FAIL bleibt dokumentiert, solange IPv4 OK ist.
- Discord Webhook nur produktiv, wenn echte Channel-Webhook-URL gesetzt ist.
```

## 12. Pfade

```text
Freeze Dir: /home/schattenmacher/openclaw_training/docs/status/freeze_report_20260502_140445
TXT Report: /home/schattenmacher/openclaw_training/reports/freeze_report_no_sudo_20260502_140445.txt
MD Report:  /home/schattenmacher/openclaw_training/docs/status/freeze_report_20260502_140445/SHADOWMAKER_FREEZE_REPORT_20260502_140445.md
Archive:    /home/schattenmacher/openclaw_training/artifacts/freezes/shadowmaker_freeze_report_20260502_140445.tar.gz
```
