# OpenClaw Training Automation Candidates

Stand: Sa 2. Mai 13:51:41 CEST 2026

## 1 Situation

`openclaw_training` ist der produktive Kern für Mission Control, Multi-Agent Crew, IHK/MFP, Courier, Security, Dokumentation und lokale KI-Artefakte.

## 2 Ziel

Automatisierung nur dort vorbereiten, wo sie wiederkehrend, risikoarm und bereits stabil ist.

## 3 Automatisierbar nach Beobachtung

| Kandidat | Befehl | Frequenz | Risiko | Bedingung |
|---|---|---:|---|---|
| Winky System Monitor | `winky-run` | 2x täglich | niedrig | Reports stabil |
| Mnemosyne Memory | `mnemosyne-run` | täglich abends | niedrig-mittel | Memory sauber |
| Courier Brief | `courier-run` | morgens | mittel | Maildaten korrekt/privat |
| Security Audit | bereits Timer | 2x täglich | niedrig | behalten |
| OpenClaw Security Health | bereits Timer | 2x täglich | niedrig | behalten |

## 4 Bewusst manuell lassen

| Modul | Grund |
|---|---|
| Mentor | Lernstart bewusst, keine Autodrills |
| Strategist | Bewerbungs-/Recruiter-Kommunikation braucht Freigabe |
| Steward | Finanzen/Wohnen/Jobcenter braucht manuelle Kontrolle |
| Linky | Builder darf keine autonomen Module produzieren |
| Repair-/Patch-Skripte | können Systemzustand ändern |
| Docker-/Rebuild-Skripte | produktives Risiko |
| LoRA-/Training-Skripte | GPU-/Zeit-/Datenrisiko |
| ShadowOps | deaktiviert wegen Passphrase-Thema |

## 5 Nützliche stabile Betriebsbefehle

```bash
phase5-crew-status
winky-run
mnemosyne-run
courier-status
courier-run
mission-control-webui-status
deep-security-check
local-ai-docs
limited-drive-summary
home-useful-scripts
```

## 6 Nächste empfohlene Automatisierung

Noch nicht aktivieren. Erst drei manuelle Kontrollläufe:

```bash
winky-run
mnemosyne-run
courier-run
systemctl --user --failed
```

Wenn drei Läufe sauber sind:
1. Winky Timer
2. Mnemosyne Timer
3. Courier Timer nur morgens

