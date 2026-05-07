#!/usr/bin/env bash
set -Eeuo pipefail

TS="$(date +%Y%m%d_%H%M%S)"
BASE="$HOME/openclaw_training"
DOC_DIR="$BASE/docs/status"
FREEZE_DIR="$DOC_DIR/freeze_report_$TS"
REPORT_DIR="$BASE/reports"
ARCHIVE_DIR="$BASE/artifacts/freezes"
REPORT_TXT="$REPORT_DIR/freeze_report_no_sudo_$TS.txt"
REPORT_MD="$FREEZE_DIR/SHADOWMAKER_FREEZE_REPORT_$TS.md"
ARCHIVE="$ARCHIVE_DIR/shadowmaker_freeze_report_$TS.tar.gz"

mkdir -p "$DOC_DIR" "$FREEZE_DIR" "$REPORT_DIR" "$ARCHIVE_DIR"

exec > >(tee -a "$REPORT_TXT") 2>&1

redact_file() {
  local src="$1"
  local dst="$2"

  if [ -f "$src" ]; then
    sed -E \
      -e 's#(TOKEN=).*#\1***MASKED***#g' \
      -e 's#(BOT_TOKEN=).*#\1***MASKED***#g' \
      -e 's#(WEBHOOK_URL=).*#\1***MASKED***#g' \
      -e 's#(DISCORD_WEBHOOK_URL=).*#\1***MASKED***#g' \
      -e 's#(DISCORD_SYSTEM_ALERTS_WEBHOOK_URL=).*#\1***MASKED***#g' \
      -e 's#(OPENAI_API_KEY=).*#\1***MASKED***#g' \
      -e 's#(ANTHROPIC_API_KEY=).*#\1***MASKED***#g' \
      -e 's#(CLAUDE_AI_SESSION_KEY=).*#\1***MASKED***#g' \
      -e 's#(PERPLEXITY_API_KEY=).*#\1***MASKED***#g' \
      "$src" > "$dst"
  fi
}

service_state_user() {
  local svc="$1"
  if systemctl --user is-active --quiet "$svc"; then
    echo "OK"
  elif systemctl --user is-enabled "$svc" 2>/dev/null | grep -q masked; then
    echo "MASKED"
  elif systemctl --user is-enabled --quiet "$svc" 2>/dev/null; then
    echo "NOT_RUNNING"
  else
    echo "MISSING_OR_DISABLED"
  fi
}

echo "============================================================"
echo " SHADOWMAKER FREEZE REPORT NO SUDO"
echo "============================================================"
echo "Zeit: $(date)"
echo "Host: $(hostname)"
echo "Report TXT: $REPORT_TXT"
echo "Report MD:  $REPORT_MD"
echo

CONTROL_STATUS="$(service_state_user shadowmaker-control-bot.service)"
WATCH_STATUS="$(service_state_user schatten-watch-bot.service)"
BACKUP_STATUS="$(service_state_user schatten-backup-bot.service)"

OPENCLAW_INTERNAL="$(docker exec -i openclaw-openclaw-gateway-1 sh -lc 'curl -sS -I --max-time 8 http://127.0.0.1:18789 2>&1 | head -20' 2>&1 || true)"
FLOWISE_HTTP="$(curl -sS -I --max-time 8 http://127.0.0.1:3001 2>&1 | head -10 || true)"
N8N_HTTP="$(curl -sS -I --max-time 8 http://127.0.0.1:5678 2>&1 | head -10 || true)"
TG4="$(curl -4 -I --max-time 10 https://api.telegram.org 2>&1 || true)"
TG6="$(curl -6 -I --max-time 10 https://api.telegram.org 2>&1 || true)"
USER_FAILED="$(systemctl --user --failed 2>&1 || true)"
SYSTEM_FAILED="$(systemctl --failed 2>&1 || true)"
DOCKER_PS="$(docker ps --format 'table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}' 2>&1 || true)"

OPENCLAW_OK="NO"
FLOWISE_OK="NO"
N8N_OK="NO"
TG4_OK="NO"
TG6_OK="NO"

grep -q "200 OK" <<< "$OPENCLAW_INTERNAL" && OPENCLAW_OK="YES" || true
grep -q "200 OK" <<< "$FLOWISE_HTTP" && FLOWISE_OK="YES" || true
grep -q "200 OK" <<< "$N8N_HTTP" && N8N_OK="YES" || true
grep -Eq "HTTP/[0-9.]+ (200|30[0-9])" <<< "$TG4" && TG4_OK="YES" || true
grep -Eq "HTTP/[0-9.]+ (200|30[0-9])" <<< "$TG6" && TG6_OK="YES" || true

cat > "$REPORT_MD" << MD
# Shadowmaker Freeze Report

Stand: $(date)

## 1. Kernstatus

| Bereich | Status |
|---|---:|
| CrashBandicot | $CONTROL_STATUS |
| SchattenWatchBot | $WATCH_STATUS |
| BackupBot | $BACKUP_STATUS |
| OpenClaw container-intern | $OPENCLAW_OK |
| Flowise | $FLOWISE_OK |
| n8n | $N8N_OK |
| Telegram IPv4 | $TG4_OK |
| Telegram IPv6 | $TG6_OK |

## 2. Betriebsstandard

OpenClaw gilt als funktionsfähig, wenn der container-interne Test \`HTTP/1.1 200 OK\` liefert.

Der Host-Test auf \`http://127.0.0.1:18789\` darf mit Reset/Fail reagieren und ist als Binding-Einschränkung dokumentiert.

## 3. Docker

\`\`\`text
$DOCKER_PS
\`\`\`

## 4. OpenClaw intern

\`\`\`text
$OPENCLAW_INTERNAL
\`\`\`

## 5. Flowise

\`\`\`text
$FLOWISE_HTTP
\`\`\`

## 6. n8n

\`\`\`text
$N8N_HTTP
\`\`\`

## 7. Telegram IPv4

\`\`\`text
$TG4
\`\`\`

## 8. Telegram IPv6

\`\`\`text
$TG6
\`\`\`

## 9. Failed Services

### User

\`\`\`text
$USER_FAILED
\`\`\`

### System

\`\`\`text
$SYSTEM_FAILED
\`\`\`

## 10. Offene Punkte

\`\`\`text
- ShadowOps Autopilot separat reparieren oder deaktivieren.
- ShadowOps Log Push separat reparieren oder deaktivieren.
- casper-md5check.service ist unkritisch.
- Telegram IPv6 FAIL bleibt dokumentiert, solange IPv4 OK ist.
- Discord Webhook nur produktiv, wenn echte Channel-Webhook-URL gesetzt ist.
\`\`\`

## 11. Standardbefehle

\`\`\`bash
oc-loop
sm-health
sm-status
sm-logs
watch-status
watch-logs
discord-status
discord-stack
\`\`\`

## 12. Freeze-Pfade

\`\`\`text
Freeze Dir: $FREEZE_DIR
TXT Report: $REPORT_TXT
MD Report:  $REPORT_MD
Archive:    $ARCHIVE
\`\`\`
MD

cp "$REPORT_MD" "$DOC_DIR/latest_shadowmaker_freeze_report.md"

mkdir -p "$FREEZE_DIR/config_redacted"

redact_file "$HOME/shadowmaker_bots/.env" "$FREEZE_DIR/config_redacted/shadowmaker_bots.env.redacted"
redact_file "$HOME/openclaw_training/mission_control/discord/discord.env" "$FREEZE_DIR/config_redacted/discord.env.redacted"
redact_file "/opt/openclaw/.env" "$FREEZE_DIR/config_redacted/opt_openclaw.env.redacted"
redact_file "/opt/openclaw/docker-compose.yml" "$FREEZE_DIR/config_redacted/opt_openclaw_docker-compose.yml.redacted"
redact_file "/opt/openclaw/data/config/openclaw.json" "$FREEZE_DIR/config_redacted/opt_openclaw_config_openclaw.json.redacted"

{
  echo "== hostnamectl =="
  hostnamectl || true
  echo
  echo "== uptime =="
  uptime || true
  echo
  echo "== free -h =="
  free -h || true
  echo
  echo "== df -h / =="
  df -h / || true
} > "$FREEZE_DIR/system_basis.txt"

echo "$DOCKER_PS" > "$FREEZE_DIR/docker_ps.txt"
echo "$USER_FAILED" > "$FREEZE_DIR/systemctl_user_failed.txt"
echo "$SYSTEM_FAILED" > "$FREEZE_DIR/systemctl_system_failed.txt"

systemctl --user status shadowmaker-control-bot.service --no-pager > "$FREEZE_DIR/service_shadowmaker-control-bot.txt" 2>&1 || true
systemctl --user status schatten-watch-bot.service --no-pager > "$FREEZE_DIR/service_schatten-watch-bot.txt" 2>&1 || true
systemctl --user status schatten-backup-bot.service --no-pager > "$FREEZE_DIR/service_schatten-backup-bot.txt" 2>&1 || true

if [ -f "$HOME/openclaw_operating_loop.sh" ]; then
  "$HOME/openclaw_operating_loop.sh" > "$FREEZE_DIR/oc_loop_output.txt" 2>&1 || true
fi

tar -czf "$ARCHIVE" -C "$FREEZE_DIR" .
sha256sum "$ARCHIVE" > "$ARCHIVE.sha256"

if [ -d "$BASE/.git" ]; then
  cd "$BASE"
  git add docs mission_control scripts reports artifacts 2>/dev/null || true
  git commit -m "Freeze report via Telegram command $TS" 2>/dev/null || true
fi

echo "============================================================"
echo "FERTIG"
echo "============================================================"
echo "Freeze Report erstellt:"
echo "$REPORT_MD"
echo
echo "Latest:"
echo "$DOC_DIR/latest_shadowmaker_freeze_report.md"
echo
echo "Archiv:"
echo "$ARCHIVE"
echo
echo "SHA256:"
cat "$ARCHIVE.sha256"
