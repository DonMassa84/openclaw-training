# Runtime Control Repair – WebUI / Courier / ShadowOps Text

Stand: Sa 2. Mai 14:01:37 CEST 2026

## 1 Situation

Nach dem manuellen Kontrolllauf waren drei Punkte sichtbar:

- Mission Control WebUI war nicht aktiv.
- Courier konnte Proton Bridge nicht erreichen.
- Winky/Mnemosyne enthielten noch alte ShadowOps-Hinweise.
- Alias-Aufrufe funktionieren nur im interaktiven Terminal, nicht zuverlässig in nicht-interaktiven Skripten.

## 2 Ziel

Kontrollbetrieb stabilisieren, ohne neue Autonomie oder produktive Dienste zu aktivieren.

## 3 Maßnahmen

- Mission Control WebUI wurde bei Bedarf im Hintergrund gestartet.
- Proton Bridge Port 1143 wurde geprüft.
- Falls möglich, wurde ein lokaler Proton Bridge Startversuch gemacht.
- Winky/Mnemosyne-Hinweise zu ShadowOps wurden aktualisiert.
- Kontrollläufe wurden über absolute Pfade ausgeführt.

## 4 Ergebnisse

### WebUI HTTP nachher

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

### Proton Bridge Port nachher

```text
tcp   LISTEN 0      4096       127.0.0.1:1143       0.0.0.0:*    users:(("bridge",pid=183258,fd=10))         
```

### User Failed Units nachher

```text
  UNIT LOAD ACTIVE SUB DESCRIPTION

0 loaded units listed.
```

### Relevante Timer nachher

```text
NEXT                             LEFT LAST                               PASSED UNIT                                     ACTIVATES
Sat 2026-05-02 21:00:00 CEST       6h Sat 2026-05-02 09:00:00 CEST            - openclaw-security-health.timer           openclaw-security-health.service
Sat 2026-05-02 21:00:03 CEST       6h Sat 2026-05-02 09:01:40 CEST            - shadowmaker-security-audit-discord.timer shadowmaker-security-audit-discord.service
```

## 5 Bewertung

- Keine Timer aktiviert.
- Keine Dienste über systemd aktiviert.
- Keine Secrets gelesen.
- Keine Mails verändert.
- Keine Löschung.
- Keine Docker-Rebuilds.
- Mission Control WebUI darf im Hintergrund laufen.
- Courier funktioniert nur, wenn Proton Bridge lokal läuft.

## 6 Entscheidung

Automatisierung bleibt deaktiviert. Für Skripte künftig absolute Pfade verwenden, keine Aliase.

## 7 Nächster Schritt

Wenn Proton Bridge weiter nicht läuft: Proton Bridge manuell öffnen und einloggen, danach:

```bash
courier-run
```

