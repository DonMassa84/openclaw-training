# ⚔️ Discord Archive Commands

```bash
find ~/openclaw_training/docs -type f | grep -Ei "discord|channel|attachment|daily|freeze|openclaw-status|memory" | sort

for ch in housing-jobcenter agent-control mail-control ihk-training security-control docs-archive daily-reports system-alerts daily-brief freeze-reports openclaw-status daily-delight openclaw-projects automation-n8n-flowise memory-wiki; do printf "%-30s " "$ch"; grep -RIl "$ch" ~/openclaw_training/docs 2>/dev/null | wc -l; done
```
