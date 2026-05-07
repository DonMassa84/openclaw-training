# Winky System Monitor Report

Stand: Do 7. Mai 18:45:05 CEST 2026

## Rolle

Winky ist der read-only System-Monitor der Shadowmaker/OpenClaw-Crew.

## Kurzstatus

Host: schattenmacher-D3161-B1  
OpenClaw Host HTTP: WARN  
Flowise: YES  
n8n: YES  
Mission Control WebUI: WARN  

## Uptime

```text
 18:45:05 up  6:02,  1 user,  load average: 3,95, 7,21, 7,80
```

## RAM

```text
               gesamt       benutzt     frei      gemns.  Puffer/Cache verfügbar
Speicher:       31Gi        12Gi       5,4Gi       319Mi        14Gi        18Gi
Auslager:      2,0Gi       8,0Ki       2,0Gi
```

## Disk Root

```text
Dateisystem    Größe Benutzt Verf. Verw% Eingehängt auf
/dev/sda2       1,8T    1,1T  625G   65% /
```

## Docker

```text
openclaw-openclaw-gateway-1 | Up 5 hours | 127.0.0.1:18789->18789/tcp
shadowmaker-agents | Up 5 hours | 0.0.0.0:3001->3000/tcp, [::]:3001->3000/tcp
shadow-command-hub | Up 5 hours | 0.0.0.0:5678->5678/tcp, [::]:5678->5678/tcp
shadow-postgres | Up 5 hours (healthy) | 5432/tcp
shadow-redis | Up 5 hours (healthy) | 6379/tcp
open-webui | Up 5 hours (healthy) | 0.0.0.0:3000->8080/tcp, [::]:3000->8080/tcp
```

## Relevante Ports

```text
tcp   LISTEN 0      4096       127.0.0.1:18789      0.0.0.0:*                                         
tcp   LISTEN 0      4096         0.0.0.0:3000       0.0.0.0:*                                         
tcp   LISTEN 0      4096         0.0.0.0:3001       0.0.0.0:*                                         
tcp   LISTEN 0      4096         0.0.0.0:5678       0.0.0.0:*                                         
tcp   LISTEN 0      4096            [::]:3000          [::]:*                                         
tcp   LISTEN 0      4096            [::]:3001          [::]:*                                         
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
Thu 2026-05-07 18:46:15 CEST 1min 10s Thu 2026-05-07 18:41:15 CEST 3min 49s ago monitor-color-guard.timer                monitor-color-guard.service
Thu 2026-05-07 18:47:03 CEST 1min 58s Thu 2026-05-07 18:45:03 CEST       1s ago monitor-apply-fixed.timer                monitor-apply-fixed.service
Thu 2026-05-07 19:30:00 CEST    44min Wed 2026-05-06 19:30:00 CEST            - monitor-color-warm.timer                 monitor-color@warm.service
Thu 2026-05-07 21:00:00 CEST 2h 14min Thu 2026-05-07 09:00:01 CEST            - openclaw-security-health.timer           openclaw-security-health.service
Thu 2026-05-07 21:01:38 CEST 2h 16min Thu 2026-05-07 09:01:24 CEST            - shadowmaker-security-audit-discord.timer shadowmaker-security-audit-discord.service
Fri 2026-05-08 08:30:00 CEST      13h Thu 2026-05-07 08:30:01 CEST            - monitor-color-neutral.timer              monitor-color@neutral.service
Fri 2026-05-08 12:48:16 CEST      18h Thu 2026-05-07 12:48:16 CEST 5h 56min ago launchpadlib-cache-clean.timer           launchpadlib-cache-clean.service
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
Date: Thu, 07 May 2026 16:45:05 GMT
Connection: keep-alive
```

## n8n HTTP

```text
HTTP/1.1 200 OK
Accept-Ranges: bytes
Cache-Control: public, max-age=86400
Last-Modified: Thu, 07 May 2026 11:18:44 GMT
ETag: W/"4066-19e02295994"
Content-Type: text/html; charset=utf-8
Content-Length: 16486
Vary: Accept-Encoding
Date: Thu, 07 May 2026 16:45:05 GMT
Connection: keep-alive
```

## Mission Control WebUI HTTP

```text
curl: (7) Failed to connect to 127.0.0.1 port 4173 after 0 ms: Couldn't connect to server
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
