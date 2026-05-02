# Gmail OAuth Credentials herunterladen

Zielpfad lokal:

/home/schattenmacher/openclaw_training/mission_control/mail_briefing/config/gmail_credentials.json

## Google Cloud Schritte

1. Google Cloud Console öffnen:
   https://console.cloud.google.com/

2. Projekt erstellen oder vorhandenes Projekt auswählen.

3. Gmail API aktivieren:
   https://console.cloud.google.com/apis/library/gmail.googleapis.com

4. OAuth Consent Screen konfigurieren:
   https://console.cloud.google.com/apis/credentials/consent

   Wichtig:
   - User Type: External, falls kein Workspace
   - App Name: Shadowmaker Courier
   - User Support Email: deine Gmail-Adresse
   - Developer Contact: deine Gmail-Adresse
   - Test User: deine Gmail-Adresse hinzufügen
   - Scope: Gmail readonly

5. Credentials erstellen:
   https://console.cloud.google.com/apis/credentials

   Create Credentials -> OAuth client ID
   Application type: Desktop app
   Name: Shadowmaker Courier Desktop

6. JSON herunterladen.

7. Datei bleibt im Downloads-Ordner. Dieses Script erkennt sie automatisch und kopiert sie nach:

   /home/schattenmacher/openclaw_training/mission_control/mail_briefing/config/gmail_credentials.json

## Sicherheit

Keine credentials.json, Tokens oder OAuth-Codes in Chat posten.
