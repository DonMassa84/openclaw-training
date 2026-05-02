
# Multi-Agent Framework – Shadowmaker

## Prinzip

Ein großer Agent wird mit steigender Projektgröße instabil. Besser ist klare Rollenaufteilung.

## Rollenmodell

| Agent         | Rolle           | Output                |
| ------------- | --------------- | --------------------- |
| CrashBandicot | Control Bot     | Status, Diagnose      |
| Scout         | Recherche       | tägliche Beobachtung  |
| Analyst       | Bewertung       | Entscheidungsvorlagen |
| Builder       | Umsetzung       | Skripte, Patches      |
| Archivist     | Dokumentation   | Runbooks, Logs        |
| Watchdog      | Security/Health | Alerts                |
| Finance       | Kostenkontrolle | Budgetübersicht       |

## Delegationsregel

```text
Scout findet.
Analyst bewertet.
Builder setzt um.
Archivist dokumentiert.
Watchdog kontrolliert.
CrashBandicot berichtet.
```

