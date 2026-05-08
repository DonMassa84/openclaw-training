# Discord Channel Doc — security-control

## Zweck

Security-, Secret-Scan- und Token-Hygiene für ShadowMaker/OpenClaw.

## Produktionsregeln

- Keine Secrets in Telegram, Discord, GitHub oder Reports.
- Keine Token-Werte ausgeben.
- Nur SET/len/hash-Status erlaubt.
- Vor Commit: Secret-Scan.
- Thunderbird niemals als Credential-Quelle verwenden.
- Keine freie Shell über Telegram.

## Prüfkommandos

Lokal:

- ~/.local/bin/shadowmaker-telegram-skill-bot-selfscan
- git status --short
- git diff --cached -- .

Telegram:

- /run secret_scan
- /run all_status

## Sollwert

OK_NO_SECRET_PATTERN
