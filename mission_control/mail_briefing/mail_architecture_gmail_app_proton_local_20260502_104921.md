# Phase 6 Mail Architecture – Gmail App + Proton Local

Stand: Sa 2. Mai 10:49:22 CEST 2026

## Entscheidung

Gmail wird nicht mehr lokal über Google Cloud OAuth erzwungen.

## Zielarchitektur

| Quelle | Zugriff | Modus | Zweck |
|---|---|---|---|
| Gmail | ChatGPT Gmail Connector / App | read-only in Chat | Gmail-Briefing, Prioritäten, Übersicht |
| Proton | Proton Bridge + lokaler Courier | read-only lokal | Proton-Briefing, Prioritäten, Übersicht |
| Discord | Kurzstatus | summary only | keine vollständigen Mailinhalte |
| Lokale Reports | Markdown | lokal | prüfbare Arbeitsliste |

## Begründung

Der Gmail Connector funktioniert bereits direkt über die App. Dadurch entfällt der lokale Google-OAuth-Aufwand mit Testnutzer, Credentials und Tokens.

## Sicherheitsgrenze

- keine Mails senden
- keine Mails löschen
- keine Mails archivieren
- keine Labels ändern
- keine Anhänge automatisch öffnen
- keine vollständigen Mailinhalte an Discord
- Proton-Passwort später neu generieren
- Gmail OAuth lokal optional, aber aktuell deaktiviert

## Lokale Courier-Rolle

Courier liest lokal nur Proton über Proton Bridge.

## Gmail-Rolle

Gmail wird bei Bedarf über die ChatGPT-App ausgewertet.

Beispiel-Anfrage:
Bitte Gmail der letzten 24 Stunden auswerten und nach P1/P2/P3 priorisieren.

## Relevante Befehle

```bash
courier-status
courier-run
courier-latest
```

## Freeze-Regel

Nach stabilem Test:
```text
/freeze_report
sudo timeshift --create --comments "Shadowmaker stable freeze after Phase 6 Gmail App Proton Local"
```
