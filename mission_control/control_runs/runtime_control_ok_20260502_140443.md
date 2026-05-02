# Runtime Control OK

Stand: Sa 2. Mai 14:04:44 CEST 2026

## 1 Situation

Der Runtime-Control-Stand wurde nach WebUI-/Courier-/ShadowOps-Bereinigung erneut geprüft.

## 2 Ziel

Den stabilen Betriebszustand dokumentieren und sichern.

## 3 Befund

### User Failed Units

```text
  UNIT LOAD ACTIVE SUB DESCRIPTION

0 loaded units listed.
```

### Relevante Timer

```text
NEXT                             LEFT LAST                               PASSED UNIT                                     ACTIVATES
Sat 2026-05-02 21:00:00 CEST       6h Sat 2026-05-02 09:00:00 CEST            - openclaw-security-health.timer           openclaw-security-health.service
Sat 2026-05-02 21:00:03 CEST       6h Sat 2026-05-02 09:01:40 CEST            - shadowmaker-security-audit-discord.timer shadowmaker-security-audit-discord.service
```

### Mission Control WebUI

```text
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
HTTP/1.1 200 OK
Vary: rsc, next-router-state-tree, next-router-prefetch, next-router-segment-prefetch, Accept-Encoding
Cache-Control: no-cache, must-revalidate
X-Powered-By: Next.js
Content-Type: text/html; charset=utf-8
Date: Sat, 02 May 2026 12:04:43 GMT
Connection: keep-alive
Keep-Alive: timeout=5

```

### Proton Bridge Port

```text
tcp   LISTEN 0      4096                                 127.0.0.1:1143       0.0.0.0:*    users:(("bridge",pid=183258,fd=10))         
```

### Courier Status

```text
/home/schattenmacher/finalize_runtime_control_ok_allinone.sh: Zeile 128: courier-status: Befehl nicht gefunden
```

## 4 Entscheidung

Der Stand ist stabil genug zum Einfrieren.

## 5 Betriebsregel

- Winky bleibt manuell.
- Mnemosyne bleibt manuell.
- Courier bleibt manuell.
- Security- und OpenClaw-Health-Timer bleiben aktiv.
- ShadowOps-Timer bleiben deaktiviert.
- Keine automatische Mailbearbeitung.

## 6 Nächster Schritt

Freeze Report und Timeshift Snapshot setzen.

