# Multi-Agent Framework

Ziel:
Eine Crew aus spezialisierten Agenten entwerfen.

Shadowmaker-Crew-Vorschlag:
1. CrashBandicot
   Rolle: Control Bot / Stack Monitor
   Modell: kein LLM nötig
   Kanal: Telegram

2. Sentinel
   Rolle: Security / Health / Risk Audit
   Modell: leicht bis mid
   Cadence: täglich 23:00

3. Archivist
   Rolle: Memory, Logs, Docs, Freeze Reports
   Modell: leicht
   Cadence: nach jedem Build / täglich

4. Builder
   Rolle: produktive Module bauen
   Modell: flagship für Planung, local/mid für Code

5. Strategist
   Rolle: Tagesprioritäten, IHK, Karriere, Finanzen
   Modell: mid bis flagship

6. Operator
   Rolle: n8n/Flowise/Automation
   Modell: mid

Regeln:
- Kein flagship Modell für Routine.
- Datenschutzrelevantes lokal halten.
- Koordination über Workspace-Dateien.
- Erst einen Agenten end-to-end beweisen, dann den nächsten bauen.
