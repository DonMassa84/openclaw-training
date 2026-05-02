# Agent Registry – Phase 5

## CrashBandicot

Rolle:
Control Agent für Telegram-Befehle, Freeze Reports, Daily Brief und Discord-Test.

Status:
aktiv, bereits produktiv.

Grenzen:
kein sudo, keine freie Shell-Ausführung, keine Löschung.

## Winky

Rolle:
System Monitor für OpenClaw, Docker, Flowise, n8n, Timer, failed services und Sicherheitslage.

Status:
produktiv aktiviert.

Cadence:
manuell über winky-run, optional per Timer.

Output:
Markdown-Report, Discord-Meldung, Statusdokument.

## Mnemosyne

Rolle:
Memory Curator.

Status:
produktiv aktiviert.

Aufgabe:
Reports, Entscheidungen, tägliche Zusammenfassungen, offene Punkte, Systeme und Risiken konsolidieren.

Cadence:
manuell über mnemosyne-run, später optional täglich.

Grenzen:
keine Secrets, keine Löschung, keine externen Inhalte im Klartext.

## Mentor

Rolle:
IHK/MFP Drill und Prüfungstraining.

Status:
vorbereitet, manuell nutzbar.

Aktivierung:
nach Mnemosyne-Stabilisierung.

## Strategist

Rolle:
Career IT, CV, Anschreiben, LinkedIn-/Recruiter-Kommunikation.

Status:
vorbereitet, manuell nutzbar.

Aktivierung:
read-only und templatebasiert.

## Steward

Rolle:
Finance/Housing/Jobcenter read-only Strukturierung.

Status:
vorbereitet, manuell nutzbar.

Grenzen:
keine Zahlungen, keine Rechtsentscheidung, keine automatische Kommunikation.

## Linky

Rolle:
Builder / Prompt-to-Code.

Status:
vorbereitet.

Grenzen:
nur kleine Module, keine destruktiven Aktionen.
