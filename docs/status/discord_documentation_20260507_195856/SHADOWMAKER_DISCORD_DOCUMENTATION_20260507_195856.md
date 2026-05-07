# Shadowmaker Abschlussdokumentation – Discord Agent Router

## Datum

Do 7. Mai 19:58:58 CEST 2026

## GitHub-Stand

- Repository: https://github.com/DonMassa84/openclaw-training.git
- Branch: main
- HEAD: 9783f6c
- Commit: chore: ignore discord router local config backups
- Push-Status: erfolgreich auf GitHub übertragen

## Discord-Agent

- Service: shadowmaker-discord-agent-router.service
- Status: active
- Discord Gateway: verbunden
- Bot: Shadowmaker Control Bot
- Befehle:
  - /status: OK
  - /winky: OK
  - /courier: OK
  - /ask: OK

## Lokales ASK-Backend

- Datei: mission_control/discord_agent_router/ask_backend.sh
- Standardmodell: qwen2.5:3b
- Backend-Test: DISCORD_DOC_OK
- Ziel: schnelle lokale Discord-Antworten ohne API-Kosten

## Lokale Modelle

```text
NAME                       ID              SIZE      MODIFIED     
qwen2.5:3b                 357c53fb659c    1.9 GB    3 weeks ago     
nomic-embed-text:latest    0a109f422b47    274 MB    3 weeks ago     
llama3.1:8b                46e0c10c039e    4.9 GB    3 weeks ago     
mistral:7b                 6577803aa9a0    4.4 GB    3 weeks ago     
qwen2.5-coder:14b          9ec8897f747e    9.0 GB    3 weeks ago     
qwen2.5:7b                 845dbda0ea48    4.7 GB    2 months ago    
```

## Dienste und Ports

```text
LISTEN 0      4096         0.0.0.0:3000       0.0.0.0:*                                        
LISTEN 0      4096       127.0.0.1:18789      0.0.0.0:*                                        
LISTEN 0      4096       127.0.0.1:11434      0.0.0.0:*    users:(("ollama",pid=1375,fd=3))    
LISTEN 0      4096            [::]:3000          [::]:*                                        
```

## Freeze- und Sicherungsstand

- ASK_OK-Freeze erstellt
- ASK_FAST_OK-Freeze erstellt
- Timeshift-Snapshot erstellt
- Timeshift-Automation installiert
- Safe-Git-Push-Automation installiert

## Automatisierung

- shadowmaker-timeshift-now: verfügbar
- shadowmaker-timeshift-auto.timer: enabled
- shadowmaker-safe-push-now: verfügbar
- shadowmaker-safe-push-auto.timer: enabled

## Git-History-Bereinigung

Entfernt wurden:

- node_modules
- große Dateien über GitHub-Limit
- Discord Bot Token aus History
- Discord Webhooks aus History
- Telegram Tokens aus History
- Google OAuth Credentials aus History
- gmail_credentials.json
- lokale .env/.bak-Konfigurationen
- home_script_inventory
- config_redacted Snapshots
- bashrc.snapshot / lokale System-Snapshots

## Sicherheitsstatus

GitHub Push Protection wurde erfolgreich passiert.  
Der finale Push wurde angenommen.

Wichtig: Bereits sichtbare oder historisch gefundene Zugangsdaten gelten als kompromittiert und müssen rotiert werden:

- Discord Bot Token
- Discord Webhooks
- Telegram Tokens
- Google OAuth Client Secret

## Operativer Endstatus

Shadowmaker Discord Agent ist produktiv nutzbar.

Primärer Bedienweg:

```text
/status
/winky
/courier
/ask prompt: ...
```

Empfohlener Standardtest:

```text
/ask prompt: Antworte exakt nur mit ASK_FAST_OK
```

## Ergebnis

System ist dokumentiert, lokal gesichert, per Timeshift abgesichert und auf GitHub gepusht.

