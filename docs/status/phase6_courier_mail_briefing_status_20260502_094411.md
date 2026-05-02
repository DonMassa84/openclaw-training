# Phase 6 – Courier Mail Briefing Status

Stand: Sa 2. Mai 09:44:44 CEST 2026

## Ergebnis

Courier Mail Briefing wurde lokal vorbereitet.

## Funktionen

- Gmail OAuth read-only vorbereitet
- Proton Bridge IMAP read-only vorbereitet
- lokaler Markdown-Bericht
- Prioritätenliste P1/P2/P3
- Kategorien
- Discord-Kurzstatus
- optionaler Timer vorbereitet, nicht aktiviert

## Sicherheitsstatus

- kein sudo im Courier-Lauf
- keine Mails senden
- keine Mails löschen
- keine Mails archivieren
- keine Labels ändern
- keine Anhänge öffnen
- keine vollständigen sensiblen Inhalte nach Discord
- Token/Passwörter bleiben lokal

## Pfade

Config:
/home/schattenmacher/openclaw_training/mission_control/mail_briefing/config/courier.env

Gmail Credentials Ziel:
/home/schattenmacher/openclaw_training/mission_control/mail_briefing/config/gmail_credentials.json

Gmail Token:
/home/schattenmacher/openclaw_training/mission_control/mail_briefing/config/gmail_token.json

Briefs:
/home/schattenmacher/openclaw_training/mission_control/mail_briefing/briefs

Runner:
/home/schattenmacher/openclaw_training/scripts/courier_mail_briefing_run.sh

## Lokale Befehle

courier-status  
courier-gmail-oauth  
courier-run  
install-courier-timer-optional  

## Nächste Schritte

1. Gmail credentials.json lokal ablegen.
2. courier-gmail-oauth ausführen.
3. Proton Bridge starten und IMAP-Daten in courier.env eintragen.
4. PROTON_ENABLED=1 setzen, wenn Proton aktiv genutzt werden soll.
5. courier-run testen.
6. Erst danach optional Timer aktivieren.

## Report

/home/schattenmacher/openclaw_training/reports/setup_phase6_courier_mail_briefing_allinone_20260502_094411.txt
