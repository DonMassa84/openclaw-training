# Shadowmaker Freeze Report

Stand: Sa 2. Mai 01:00:03 CEST 2026

## 1. Kernstatus

| Bereich | Status |
|---|---:|
| CrashBandicot / shadowmaker-control-bot.service | OK |
| SchattenWatchBot / schatten-watch-bot.service | OK |
| BackupBot / schatten-backup-bot.service | OK |
| OpenClaw container-intern | YES |
| Flowise | YES |
| n8n | YES |
| Telegram IPv4 | YES |
| Telegram IPv6 | NO |

## 2. Betriebsstandard

OpenClaw gilt als funktionsfähig, wenn der container-interne Test `HTTP/1.1 200 OK` liefert.

Der Host-Test auf `http://127.0.0.1:18789` darf mit Reset/Fail reagieren und ist als Binding-Einschränkung dokumentiert.

## 3. Aktive Soll-Dienste

```text
shadowmaker-control-bot.service = OK
schatten-watch-bot.service      = OK
schatten-backup-bot.service     = OK
```

## 4. Health-Auszüge

### OpenClaw intern

```text
HTTP/1.1 200 OK
X-Content-Type-Options: nosniff
Referrer-Policy: no-referrer
X-Frame-Options: DENY
Content-Security-Policy: default-src 'self'; base-uri 'none'; object-src 'none'; frame-ancestors 'none'; script-src 'self'; style-src 'self' 'unsafe-inline'; img-src 'self' data: https:; font-src 'self'; connect-src 'self' ws: wss:
Content-Type: text/html; charset=utf-8
Cache-Control: no-cache
Date: Fri, 01 May 2026 22:59:52 GMT
Connection: keep-alive
Keep-Alive: timeout=5

```

### Flowise

```text
HTTP/1.1 200 OK
Vary: Origin
Accept-Ranges: bytes
Cache-Control: public, max-age=0
Last-Modified: Tue, 14 Apr 2026 11:32:51 GMT
ETag: W/"c46-19d8bc3feb8"
Content-Type: text/html; charset=UTF-8
Content-Length: 3142
Date: Fri, 01 May 2026 22:59:52 GMT
Connection: keep-alive
```

### n8n

```text
HTTP/1.1 200 OK
Accept-Ranges: bytes
Cache-Control: public, max-age=86400
Last-Modified: Fri, 01 May 2026 20:57:50 GMT
ETag: W/"4066-19de5556084"
Content-Type: text/html; charset=utf-8
Content-Length: 16486
Vary: Accept-Encoding
Date: Fri, 01 May 2026 22:59:52 GMT
Connection: keep-alive
```

### Telegram IPv4

```text
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0  0   145    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
HTTP/2 302 
server: nginx/1.18.0
date: Fri, 01 May 2026 22:59:53 GMT
content-type: text/html
content-length: 145
location: https://core.telegram.org/bots
strict-transport-security: max-age=31536000; includeSubDomains; preload
access-control-allow-origin: *
access-control-allow-methods: GET, POST, OPTIONS
access-control-expose-headers: Content-Length,Content-Type,Date,Server,Connection

```

### Telegram IPv6

```text
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0  0     0    0     0    0     0      0      0 --:--:--  0:00:01 --:--:--     0  0     0    0     0    0     0      0      0 --:--:--  0:00:02 --:--:--     0  0     0    0     0    0     0      0      0 --:--:--  0:00:03 --:--:--     0  0     0    0     0    0     0      0      0 --:--:--  0:00:04 --:--:--     0  0     0    0     0    0     0      0      0 --:--:--  0:00:05 --:--:--     0  0     0    0     0    0     0      0      0 --:--:--  0:00:06 --:--:--     0  0     0    0     0    0     0      0      0 --:--:--  0:00:07 --:--:--     0  0     0    0     0    0     0      0      0 --:--:--  0:00:08 --:--:--     0  0     0    0     0    0     0      0      0 --:--:--  0:00:09 --:--:--     0  0     0    0     0    0     0      0      0 --:--:--  0:00:10 --:--:--     0
curl: (28) Connection timed out after 10001 milliseconds
```

## 5. Offene Punkte

```text
- ShadowOps Autopilot separat reparieren oder deaktivieren.
- ShadowOps Log Push separat reparieren oder deaktivieren.
- casper-md5check.service ist unkritisch.
- Telegram IPv6 FAIL bleibt dokumentiert, solange IPv4 OK ist.
- Discord Webhook nur dann produktiv, wenn echte Channel-Webhook-URL gesetzt ist.
```

## 6. Standardbefehle

```bash
oc-loop
sm-health
sm-status
sm-logs
watch-status
watch-logs
discord-status
discord-stack
```

## 7. Telegram-Befehle

```text
/status
/openclaw
/docker
/stack
/ping
/whoami
/discordtest
```

## 8. Freeze-Pfade

```text
Freeze Dir: /home/schattenmacher/openclaw_training/docs/status/freeze_20260502_005952
TXT Report: /home/schattenmacher/openclaw_training/reports/freeze_shadowmaker_state_timeshift_20260502_005952.txt
MD Report:  /home/schattenmacher/openclaw_training/docs/status/freeze_20260502_005952/SHADOWMAKER_FREEZE_REPORT_20260502_005952.md
Archive:    /home/schattenmacher/openclaw_training/artifacts/freezes/shadowmaker_freeze_20260502_005952.tar.gz
```
