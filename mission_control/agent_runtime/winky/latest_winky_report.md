# Winky System Monitor Report

Stand: Sa 2. Mai 14:01:31 CEST 2026

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
 14:01:31 up  3:03,  1 user,  load average: 3,13, 2,60, 2,97
```

## RAM

```text
               gesamt       benutzt     frei      gemns.  Puffer/Cache verfügbar
Speicher:       31Gi        13Gi       3,8Gi       207Mi        15Gi        18Gi
Auslager:      2,0Gi        32Ki       2,0Gi
```

## Disk Root

```text
Dateisystem    Größe Benutzt Verf. Verw% Eingehängt auf
/dev/sda2       1,8T    1,1T  628G   64% /
```

## Docker

```text
openclaw-openclaw-gateway-1 | Up 3 hours | 127.0.0.1:18789->18789/tcp
shadowmaker-agents | Up 3 hours | 0.0.0.0:3001->3000/tcp, [::]:3001->3000/tcp
shadow-command-hub | Up 3 hours | 0.0.0.0:5678->5678/tcp, [::]:5678->5678/tcp
shadow-postgres | Up 3 hours (healthy) | 5432/tcp
shadow-redis | Up 3 hours (healthy) | 6379/tcp
open-webui | Up 3 hours (healthy) | 0.0.0.0:3000->8080/tcp, [::]:3000->8080/tcp
```

## Relevante Ports

```text
tcp   LISTEN 0      511        127.0.0.1:4173       0.0.0.0:*    users:(("next-server (v1",pid=183816,fd=22))
tcp   LISTEN 0      4096       127.0.0.1:18789      0.0.0.0:*                                                
tcp   LISTEN 0      4096         0.0.0.0:3001       0.0.0.0:*                                                
tcp   LISTEN 0      4096         0.0.0.0:3000       0.0.0.0:*                                                
tcp   LISTEN 0      4096         0.0.0.0:5678       0.0.0.0:*                                                
tcp   LISTEN 0      4096            [::]:3001          [::]:*                                                
tcp   LISTEN 0      4096            [::]:3000          [::]:*                                                
tcp   LISTEN 0      4096            [::]:5678          [::]:*                                                
```

## User Failed Services

```text
  UNIT LOAD ACTIVE SUB DESCRIPTION

0 loaded units listed.
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
Sat 2026-05-02 14:02:33 CEST  1min 1s Sat 2026-05-02 14:00:33 CEST      58s ago monitor-apply-fixed.timer                monitor-apply-fixed.service
Sat 2026-05-02 14:06:09 CEST 4min 37s Sat 2026-05-02 14:01:09 CEST      22s ago monitor-color-guard.timer                monitor-color-guard.service
Sat 2026-05-02 19:30:00 CEST 5h 28min Fri 2026-05-01 19:30:00 CEST            - monitor-color-warm.timer                 monitor-color@warm.service
Sat 2026-05-02 21:00:00 CEST       6h Sat 2026-05-02 09:00:00 CEST            - openclaw-security-health.timer           openclaw-security-health.service
Sat 2026-05-02 21:00:03 CEST       6h Sat 2026-05-02 09:01:40 CEST            - shadowmaker-security-audit-discord.timer shadowmaker-security-audit-discord.service
Sun 2026-05-03 08:30:00 CEST      18h Sat 2026-05-02 08:30:01 CEST            - monitor-color-neutral.timer              monitor-color@neutral.service
Sun 2026-05-03 11:03:41 CEST      21h Sat 2026-05-02 11:03:41 CEST 2h 57min ago launchpadlib-cache-clean.timer           launchpadlib-cache-clean.service
7 timers listed.
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
Date: Sat, 02 May 2026 12:01:31 GMT
Connection: keep-alive
```

## n8n HTTP

```text
HTTP/1.1 200 OK
Accept-Ranges: bytes
Cache-Control: public, max-age=86400
Last-Modified: Sat, 02 May 2026 08:59:00 GMT
ETag: W/"4066-19de7e99c39"
Content-Type: text/html; charset=utf-8
Content-Length: 16486
Vary: Accept-Encoding
Date: Sat, 02 May 2026 12:01:31 GMT
Connection: keep-alive
```

## Mission Control WebUI HTTP

```text
HTTP/1.1 200 OK
Vary: rsc, next-router-state-tree, next-router-prefetch, next-router-segment-prefetch, Accept-Encoding
Cache-Control: no-cache, must-revalidate
X-Powered-By: Next.js
Content-Type: text/html; charset=utf-8
Date: Sat, 02 May 2026 12:01:31 GMT
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

shadowops-log-push.timer ist deaktiviert.  
casper-md5check.service bleibt unkritisch, wenn es nur Live-ISO-Reststatus ist.
