# Gmail OAuth Setup Note

Stand: Sa 2. Mai 09:44:44 CEST 2026

Ziel:
Gmail read-only Zugriff für Courier.

Benötigte lokale Datei:
/home/schattenmacher/openclaw_training/mission_control/mail_briefing/config/gmail_credentials.json

Ablauf:
1. Google Cloud Projekt erstellen oder bestehendes nutzen.
2. Gmail API aktivieren.
3. OAuth Client für Desktop App erstellen.
4. credentials.json herunterladen.
5. Datei lokal speichern als:
   /home/schattenmacher/openclaw_training/mission_control/mail_briefing/config/gmail_credentials.json
6. Dann ausführen:
   courier-gmail-oauth

Scope:
https://www.googleapis.com/auth/gmail.readonly

Sicherheitsregel:
Kein Senden.
Kein Löschen.
Kein Archivieren.
Kein Labeln.
Nur Lesen und lokaler Bericht.
