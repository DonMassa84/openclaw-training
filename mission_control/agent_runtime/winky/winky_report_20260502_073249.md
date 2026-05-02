# Winky System Monitor Report

Stand: Sa 2. Mai 07:32:49 CEST 2026

## Rolle

Winky ist der read-only System-Monitor der Shadowmaker/OpenClaw-Crew.

## Kurzstatus

Host: schattenmacher-D3161-B1  
OpenClaw Host HTTP: WARN  
Flowise: YES  
n8n: YES  
Mission Control WebUI: YES  

## Uptime

```text
 07:32:49 up  8:35,  1 user,  load average: 2,57, 3,19, 3,18
```

## RAM

```text
               gesamt       benutzt     frei      gemns.  Puffer/Cache verfügbar
Speicher:       31Gi        13Gi       1,8Gi       559Mi        16Gi        17Gi
Auslager:      2,0Gi       1,6Gi       454Mi
```

## Disk Root

```text
Dateisystem    Größe Benutzt Verf. Verw% Eingehängt auf
/dev/sda2       1,8T    1,1T  630G   64% /
```

## Docker

```text
openclaw-openclaw-gateway-1 | Up 8 hours | 127.0.0.1:18789->18789/tcp
shadowmaker-agents | Up 9 hours | 0.0.0.0:3001->3000/tcp, [::]:3001->3000/tcp
shadow-command-hub | Up 9 hours | 0.0.0.0:5678->5678/tcp, [::]:5678->5678/tcp
shadow-postgres | Up 9 hours (healthy) | 5432/tcp
shadow-redis | Up 9 hours (healthy) | 6379/tcp
open-webui | Up 9 hours (healthy) | 0.0.0.0:3000->8080/tcp, [::]:3000->8080/tcp
```

## Relevante Ports

```text
tcp   LISTEN 0      4096       127.0.0.1:18789      0.0.0.0:*                                                
tcp   LISTEN 0      4096         0.0.0.0:3000       0.0.0.0:*                                                
tcp   LISTEN 0      4096         0.0.0.0:3001       0.0.0.0:*                                                
tcp   LISTEN 0      4096         0.0.0.0:5678       0.0.0.0:*                                                
tcp   LISTEN 0      511        127.0.0.1:4173       0.0.0.0:*    users:(("next-server (v1",pid=401134,fd=22))
tcp   LISTEN 0      4096            [::]:3000          [::]:*                                                
tcp   LISTEN 0      4096            [::]:3001          [::]:*                                                
tcp   LISTEN 0      4096            [::]:5678          [::]:*                                                
```

## User Failed Services

```text
  UNIT                        LOAD   ACTIVE SUB    DESCRIPTION
● shadowops-autopilot.service loaded failed failed ShadowOps autonomous encrypted log watchdog
● shadowops-log-push.service  loaded failed failed ShadowOps encrypted log push

Legend: LOAD   → Reflects whether the unit definition was properly loaded.
        ACTIVE → The high-level unit activation state, i.e. generalization of SUB.
        SUB    → The low-level unit activation state, values depend on unit type.

2 loaded units listed.
```

## System Failed Services

```text
  UNIT                    LOAD   ACTIVE SUB    DESCRIPTION
● casper-md5check.service loaded failed failed casper-md5check Verify Live ISO checksums

Legend: LOAD   → Reflects whether the unit definition was properly loaded.
        ACTIVE → The high-level unit activation state, i.e. generalization of SUB.
        SUB    → The low-level unit activation state, values depend on unit type.

1 loaded units listed.
```

## User Timer

```text
NEXT                             LEFT LAST                               PASSED UNIT                                     ACTIVATES
Sat 2026-05-02 07:33:20 CEST      31s Sat 2026-05-02 07:31:20 CEST 1min 28s ago monitor-apply-fixed.timer                monitor-apply-fixed.service
Sat 2026-05-02 07:35:56 CEST  3min 7s Sat 2026-05-02 07:30:56 CEST 1min 52s ago monitor-color-guard.timer                monitor-color-guard.service
Sat 2026-05-02 07:35:56 CEST  3min 7s Sat 2026-05-02 07:30:56 CEST 1min 52s ago shadowops-autopilot.timer                shadowops-autopilot.service
Sat 2026-05-02 08:00:00 CEST    27min Sat 2026-05-02 07:00:01 CEST    32min ago shadowops-log-push.timer                 shadowops-log-push.service
Sat 2026-05-02 08:30:00 CEST    57min Fri 2026-05-01 08:30:00 CEST            - monitor-color-neutral.timer              monitor-color@neutral.service
Sat 2026-05-02 09:00:00 CEST 1h 27min -                                       - openclaw-security-health.timer           openclaw-security-health.service
Sat 2026-05-02 09:01:39 CEST 1h 28min -                                       - shadowmaker-security-audit-discord.timer shadowmaker-security-audit-discord.service
Sat 2026-05-02 19:30:00 CEST      11h Fri 2026-05-01 19:30:00 CEST            - monitor-color-warm.timer                 monitor-color@warm.service
Sat 2026-05-02 23:02:21 CEST      15h Fri 2026-05-01 23:02:21 CEST       8h ago launchpadlib-cache-clean.timer           launchpadlib-cache-clean.service
9 timers listed.
```

## OpenClaw HTTP

```text
curl: (56) Recv failure: Die Verbindung wurde vom Kommunikationspartner zurückgesetzt
```

## Flowise HTTP

```text
HTTP/1.1 200 OK
Vary: Origin
Accept-Ranges: bytes
Cache-Control: public, max-age=0
Last-Modified: Tue, 14 Apr 2026 11:32:51 GMT
ETag: W/"c46-19d8bc3feb8"
Content-Type: text/html; charset=UTF-8
Content-Length: 3142
Date: Sat, 02 May 2026 05:32:49 GMT
Connection: keep-alive
```

## n8n HTTP

```text
HTTP/1.1 200 OK
Accept-Ranges: bytes
Cache-Control: public, max-age=86400
Last-Modified: Fri, 01 May 2026 20:57:50 GMT
ETag: W/"4066-19de5556084"
Content-Type: text/html; charset=utf-8
Content-Length: 16486
Vary: Accept-Encoding
Date: Sat, 02 May 2026 05:32:49 GMT
Connection: keep-alive
```

## Mission Control WebUI HTTP

```text
HTTP/1.1 200 OK
Vary: rsc, next-router-state-tree, next-router-prefetch, next-router-segment-prefetch, Accept-Encoding
Cache-Control: no-cache, must-revalidate
X-Powered-By: Next.js
Content-Type: text/html; charset=utf-8
Date: Sat, 02 May 2026 05:32:50 GMT
Connection: keep-alive
Keep-Alive: timeout=5

```

## Bewertung

- Read-only ausgeführt.
- Keine Secrets gelesen.
- Keine Reparatur durchgeführt.
- Kein sudo verwendet.
- Kein Fundament verändert.

## Nächste Entscheidung

shadowops-log-push.service separat entscheiden: reparieren oder deaktivieren.  
casper-md5check.service bleibt unkritisch, wenn es nur Live-ISO-Reststatus ist.
