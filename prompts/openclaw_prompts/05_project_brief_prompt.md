# First Project Brief Prompt

Ziel:
Das erste produktive OpenClaw-Projekt auswählen.

Shadowmaker-Entscheidung:
Das erste produktive Projekt ist bereits definiert:

Project Name:
Shadowmaker Daily Command Brief

Was es tun soll:
Der Daily Brief erstellt täglich ein kompaktes Lagebild über Systemstatus, OpenClaw, Flowise, n8n, Telegram, Freeze-Status, offene Risiken und Prioritäten.

Warum es wichtig ist:
Es verhindert ziellose Reparaturschleifen und zwingt das System in einen operativen Führungsrhythmus.

Wo es erscheint:
Telegram über CrashBandicot mit `/daily_brief`.
Lokal als Markdown-Datei unter mission_control/daily_briefs.

Build Size:
Small bis Medium.

Constraints:
- Kein freies Shell-Execution
- Kein sudo
- Nur Admin
- Internal only
- Muss autonom auswertbar sein
