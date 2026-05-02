# Gmail OAuth Credentials fehlen

Zielpfad:

/home/schattenmacher/openclaw_training/mission_control/mail_briefing/config/gmail_credentials.json

Vorgehen:

1. Google Cloud Console öffnen.
2. Projekt erstellen oder vorhandenes Projekt wählen.
3. Gmail API aktivieren.
4. OAuth Consent Screen konfigurieren.
5. OAuth Client erstellen:
   Anwendungstyp: Desktop App
6. JSON herunterladen.
7. Datei umbenennen in:
   gmail_credentials.json
8. Datei speichern unter:
   /home/schattenmacher/openclaw_training/mission_control/mail_briefing/config/gmail_credentials.json
9. Dann ausführen:
   ~/configure_courier_gmail_oauth_allinone.sh

Sicherheitsregel:

Keine credentials.json, Tokens oder OAuth-Codes in Chat posten.
