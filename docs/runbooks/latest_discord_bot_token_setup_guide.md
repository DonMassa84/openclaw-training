# Discord Bot Token Setup Guide

Webhook-URL ist nicht Bot-Token.

Webhook:
DISCORD_WEBHOOK_URL=***REDACTED***

Bot Token:
echter Token aus Discord Developer Portal, keine URL.

Bot erstellen:
1. https://discord.com/developers/applications
2. New Application
3. Bot
4. Add Bot oder Reset Token
5. Token kopieren
6. Nicht in Chat posten

Bot einladen:
OAuth2 -> URL Generator
Scopes: bot
Permissions:
- View Channels
- Send Messages
- Manage Channels
- Manage Webhooks
- Read Message History

Guild ID:
Discord Entwicklermodus aktivieren -> Rechtsklick Server -> Server-ID kopieren.
