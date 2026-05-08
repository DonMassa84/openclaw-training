# ShadowMaker Strict Local Truth v3 — Finance Clean

Stand: 2026-05-08T12:31:16+02:00

## Änderung

askfinance wurde final gehärtet:

- keine Manifest-Rohzeilen mehr
- nur saubere lokale Dateipfade
- keine Web-Claims
- keine allgemeine Rechtsbelehrung ohne lokalen Kontext
- strukturierte Ausgabe
- lokale Dokumente priorisiert

## Test

```bash
askfinance "Pfändung"
```

## Qualitätsziel

```text
Keine .tsv:Zeilennummer:Hash-Rohdaten
Keine Web-Quellen
Keine Secrets
Nur lokale Treffer
```
