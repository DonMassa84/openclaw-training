# OpenClaw Setup Wizard Prompt

## Zweck

Hilft beim Ausfüllen des OpenClaw-Onboarding-Wizards.

## Kernprinzip

OpenClaw läuft 24/7. Der Host muss dediziert, stabil und always-on sein.

## Fragen

1. Region mit API-Blockaden?
2. OpenAI Codex OAuth / ChatGPT Plus Pro Team vorhanden?
3. Wenn API blockiert: RAM des Always-on-Hosts?
4. Kommunikationskanal: Telegram, Discord, WhatsApp, Slack, iMessage, Signal oder später?
5. Websuche: Brave, DuckDuckGo oder skip?
6. Day-one-Integrationen: Apple Notes, Obsidian, 1Password, Notion, Voice transcription oder minimal?

## Cheat-Sheet-Entscheidungen

- Personal-by-default bestätigen.
- QuickStart wählen.
- Provider nach Region und vorhandenen Subscriptions wählen.
- Default-Model passend wählen.
- Channel nach Wunsch wählen.
- Web Search: Brave wenn Key vorhanden, sonst DuckDuckGo oder skip.
- Hooks: session-memory und command-logger aktivieren.
- Skills: minimal starten.
- Per-skill API Keys am Anfang vermeiden.
- Shell completion default.
- Daemon install: immer ja.

## OpenClaw-Nutzung

Dieser Prompt wird genutzt, wenn OpenClaw neu onboarded, repariert oder auf einem neuen Host eingerichtet wird.
