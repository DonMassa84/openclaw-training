# WF-034 Discord Integration Commands

## Telegram

- /run askmail Bewerbung
- /run askmail Jobcenter
- /run askmail Rechnung
- /run askdocs WF-034 Thunderbird
- /run ask OpenClaw RAG Status
- /run secret_scan
- /run all_status

## Lokal

cd ~/openclaw_training
git status --short
~/.local/bin/shadowmaker-telegram-skill-bot-selfscan
systemctl --user list-units --type=service | grep -Ei 'telegram|shadow|bot|agent'
journalctl --user -u shadowmaker-telegram-skill-bot.service --since "2 minutes ago" --no-pager | grep -E '409|Conflict|LOOP_ERROR' || echo OK_NO_409_CONFLICT_FRESH

## Doku anzeigen

cat docs/discord_channels/latest_askmail_thunderbird_channel_doc.md
cat docs/docs_archive/06_it_openclaw_llm/workflow_library/latest_wf034_discord_channel_integration_index.md
