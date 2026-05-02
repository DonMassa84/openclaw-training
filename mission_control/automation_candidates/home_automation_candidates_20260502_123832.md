# Home Automation Candidates – Shadowmaker/OpenClaw

Stand: Sa 2. Mai 12:46:17 CEST 2026

## 1 Situation

Das Home-Verzeichnis enthält viele funktionale Skripte. Nicht alles soll automatisiert werden. Automatisierung braucht Nutzen, Stabilität und geringe Risiken.

## 2 Ziel

Nützliche Skripte in Gruppen aufnehmen und entscheiden, was später automatisierbar ist.

## 3 Sofort nützlich, aber manuell lassen

| Bereich | Typische Befehle/Skripte | Empfehlung |
|---|---|---|
| Status | winky-run, phase5-crew-status, courier-status | manuell oder später Winky-Timer |
| Memory | mnemosyne-run | später optional täglich |
| Mail | courier-run | morgens manuell, später optional |
| IHK | mentor-run | bewusst manuell |
| Karriere | strategist-run | bewusst manuell |
| Finanzen/Wohnen | steward-run | bewusst manuell |
| Builder | linky-run | bewusst manuell |
| Doku | local-ai-docs, useful-scripts | manuell |

## 4 Automatisierbar nach Beobachtung

| Kandidat | Frequenz | Bedingung |
|---|---|---|
| Winky | 2x täglich | nur wenn Reports stabil bleiben |
| Mnemosyne | täglich abends | nur wenn Memory sauber bleibt |
| Courier | täglich morgens | nur wenn Maildaten korrekt und privat bleiben |
| Security Audit | bereits aktiv | beibehalten |
| OpenClaw Security Health | bereits aktiv | beibehalten |

## 5 Nicht automatisieren

| Bereich | Grund |
|---|---|
| Strategist | Bewerbungs-/Recruiter-Kommunikation braucht Freigabe |
| Steward | Jobcenter/Finanzen/Wohnen braucht manuelle Kontrolle |
| Linky | Builder darf nicht autonom produktiv werden |
| Mentor | Lernen braucht bewussten Start |
| Repair/Fix/Patch Skripte | können System verändern |
| Docker/Rebuild Skripte | produktives Risiko |
| Audio/VPN Reparatur | nur bei konkretem Fehler |
| ShadowOps Autopilot/Log Push | deaktiviert wegen fehlender Passphrase |

## 6 Nützliche lokale Skriptgruppen aus deiner Struktur

### OpenClaw / Gateway / Router

Relevant für Setup, Reparatur und Status. Nur bei konkretem OpenClaw-Problem nutzen.

### Mission Control / Phasen

Relevant für dokumentierten Ausbau. Neue Phasen nur nach Freeze.

### Discord / Telegram

Relevant für Routing und Statusmeldungen. Keine Tokens posten.

### Courier / Mail

Relevant für Proton lokal und Gmail-App-Architektur.

### IHK / MFP / LoRA / RAG

Relevant für Prüfungstraining und lokale KI-Lernsysteme.

### AEVO / Medien / Whisper

Relevant für Präsentation, Transkription, Lernmaterial und Medienautomatisierung.

### ShadowLearn / EVA / AgentEva

Relevant als ältere/zusätzliche Agenten- und Lernsysteme. Erst inventarisieren, dann konsolidieren.

## 7 Nächster Schritt

Nicht automatisieren. Erst prüfen:

```bash
home-useful-scripts
home-automation-candidates
home-script-inventory-status
```

Danach gezielt entscheiden:
- Winky automatisch?
- Mnemosyne automatisch?
- Courier morgens automatisch?

