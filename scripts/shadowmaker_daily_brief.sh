#!/usr/bin/env bash
set -Eeuo pipefail

TS="$(date +%Y%m%d_%H%M%S)"
TODAY="$(date +%F)"
BASE="$HOME/openclaw_training"
BRIEF_DIR="$BASE/mission_control/daily_briefs"
DOC_DIR="$BASE/docs/status"
REPORT_DIR="$BASE/reports"
REPORT_TXT="$REPORT_DIR/daily_brief_$TS.txt"
REPORT_MD="$BRIEF_DIR/daily_brief_${TODAY}_${TS}.md"

mkdir -p "$BRIEF_DIR" "$DOC_DIR" "$REPORT_DIR"

exec > >(tee -a "$REPORT_TXT") 2>&1

user_service_state() {
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

header_line() {
  echo "============================================================"
}

echo "============================================================"
echo " SHADOWMAKER DAILY BRIEF"
echo "============================================================"
echo "Zeit: $(date)"
echo "Host: $(hostname)"
echo "TXT: $REPORT_TXT"
echo "MD:  $REPORT_MD"
echo

CONTROL_STATUS="$(user_service_state shadowmaker-control-bot.service)"
WATCH_STATUS="$(user_service_state schatten-watch-bot.service)"
BACKUP_STATUS="$(user_service_state schatten-backup-bot.service)"

DOCKER_PS="$(docker ps --format 'table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}' 2>&1 || true)"
OPENCLAW_INTERNAL="$(docker exec -i openclaw-openclaw-gateway-1 sh -lc 'curl -sS -I --max-time 8 http://127.0.0.1:18789 2>&1 | head -20' 2>&1 || true)"
OPENCLAW_HOST="$(curl -sS -I --max-time 8 http://127.0.0.1:18789 2>&1 | head -10 || true)"
FLOWISE_HTTP="$(curl -sS -I --max-time 8 http://127.0.0.1:3001 2>&1 | head -10 || true)"
N8N_HTTP="$(curl -sS -I --max-time 8 http://127.0.0.1:5678 2>&1 | head -10 || true)"
TG4="$(curl -4 -I --max-time 10 https://api.telegram.org 2>&1 | head -20 || true)"
TG6="$(curl -6 -I --max-time 10 https://api.telegram.org 2>&1 | head -20 || true)"
USER_FAILED="$(systemctl --user --failed 2>&1 || true)"
SYSTEM_FAILED="$(systemctl --failed 2>&1 || true)"
UPTIME_TXT="$(uptime || true)"
RAM_TXT="$(free -h || true)"
DISK_TXT="$(df -h / || true)"
TIMESHIFT_LIST="$(sudo -n timeshift --list 2>&1 | tail -25 || true)"

OPENCLAW_OK="NO"
FLOWISE_OK="NO"
N8N_OK="NO"
TG4_OK="NO"
TG6_OK="NO"
FREEZE_OK="NO"
TIMESHIFT_OK="UNKNOWN"

grep -q "200 OK" <<< "$OPENCLAW_INTERNAL" && OPENCLAW_OK="YES" || true
grep -q "200 OK" <<< "$FLOWISE_HTTP" && FLOWISE_OK="YES" || true
grep -q "200 OK" <<< "$N8N_HTTP" && N8N_OK="YES" || true
grep -Eq "HTTP/[0-9.]+ (200|30[0-9])" <<< "$TG4" && TG4_OK="YES" || true
grep -Eq "HTTP/[0-9.]+ (200|30[0-9])" <<< "$TG6" && TG6_OK="YES" || true

if [ -f "$DOC_DIR/latest_shadowmaker_freeze_report.md" ]; then
  FREEZE_OK="YES"
fi

if grep -q "Shadowmaker stable freeze" <<< "$TIMESHIFT_LIST"; then
  TIMESHIFT_OK="YES"
elif grep -q "password" <<< "$TIMESHIFT_LIST" || grep -q "sudo" <<< "$TIMESHIFT_LIST"; then
  TIMESHIFT_OK="LOCAL_SUDO_REQUIRED"
fi

OPEN_ITEMS=()

if [ "$OPENCLAW_OK" != "YES" ]; then
  OPEN_ITEMS+=("OpenClaw container-intern prüfen")
fi

if [ "$FLOWISE_OK" != "YES" ]; then
  OPEN_ITEMS+=("Flowise prüfen")
fi

if [ "$N8N_OK" != "YES" ]; then
  OPEN_ITEMS+=("n8n prüfen")
fi

if [ "$TG4_OK" != "YES" ]; then
  OPEN_ITEMS+=("Telegram IPv4 prüfen")
fi

if [ "$TG6_OK" != "YES" ]; then
  OPEN_ITEMS+=("Telegram IPv6 bleibt dokumentierter Warnpunkt")
fi

if grep -q "shadowops-autopilot.service" <<< "$USER_FAILED"; then
  OPEN_ITEMS+=("ShadowOps Autopilot separat entscheiden: reparieren oder deaktivieren")
fi

if grep -q "shadowops-log-push.service" <<< "$USER_FAILED"; then
  OPEN_ITEMS+=("ShadowOps Log Push separat entscheiden: reparieren oder deaktivieren")
fi

if grep -q "casper-md5check.service" <<< "$SYSTEM_FAILED"; then
  OPEN_ITEMS+=("casper-md5check ist unkritisch; optional reset-failed")
fi

if [ "$FREEZE_OK" != "YES" ]; then
  OPEN_ITEMS+=("Freeze-Report fehlt")
fi

if [ "$TIMESHIFT_OK" = "LOCAL_SUDO_REQUIRED" ]; then
  OPEN_ITEMS+=("Timeshift-Prüfung braucht lokalen sudo")
fi

if [ "${#OPEN_ITEMS[@]}" -eq 0 ]; then
  OPEN_ITEMS+=("Keine kritischen offenen Punkte")
fi

cat > "$REPORT_MD" << MD
# Shadowmaker Daily Brief

Stand: $(date)

## 1. Lagebild

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
| Freeze Report vorhanden | $FREEZE_OK |
| Timeshift Status | $TIMESHIFT_OK |

## 2. Bewertung

\`\`\`text
OpenClaw ist OK, wenn container-intern HTTP/1.1 200 OK erscheint.
Host-HTTP-Fail/Reset bleibt dokumentierte Binding-Einschränkung und ist kein Ausfall.
Telegram IPv6 darf FAIL bleiben, solange IPv4 OK ist.
Vor größeren Änderungen: /freeze_report + lokaler Timeshift Snapshot.
\`\`\`

## 3. System

### Uptime

\`\`\`text
$UPTIME_TXT
\`\`\`

### RAM

\`\`\`text
$RAM_TXT
\`\`\`

### Disk

\`\`\`text
$DISK_TXT
\`\`\`

## 4. Docker

\`\`\`text
$DOCKER_PS
\`\`\`

## 5. OpenClaw

### Host-Test

\`\`\`text
$OPENCLAW_HOST
\`\`\`

### Container-intern

\`\`\`text
$OPENCLAW_INTERNAL
\`\`\`

## 6. Flowise

\`\`\`text
$FLOWISE_HTTP
\`\`\`

## 7. n8n

\`\`\`text
$N8N_HTTP
\`\`\`

## 8. Telegram Netzwerk

### IPv4

\`\`\`text
$TG4
\`\`\`

### IPv6

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

MD

for item in "${OPEN_ITEMS[@]}"; do
  echo "- $item" >> "$REPORT_MD"
done

cat >> "$REPORT_MD" << MD

## 11. Priorität 1–3 des Tages

\`\`\`text
1. Fundament nicht verändern: OpenClaw-Binding, Docker-Port 18789 und CrashBandicot-Core unberührt lassen.
2. Produktivmodul fokussieren: Daily Brief / Mission Control / Projektoutput statt Reparaturschleifen.
3. Vor jeder Änderung: /freeze_report ausführen und danach lokal Timeshift sichern.
\`\`\`

## 12. Nächster sicherer Schritt

\`\`\`text
Wenn der Stack stabil bleibt:
- Keine Systemänderung.
- Nur produktive Inhalte erzeugen.
- Bei neuer Änderung zuerst /freeze_report.
\`\`\`

## 13. Pfade

\`\`\`text
Daily Brief: $REPORT_MD
Latest:      $BRIEF_DIR/latest_daily_brief.md
TXT Report:  $REPORT_TXT
Freeze:      $DOC_DIR/latest_shadowmaker_freeze_report.md
\`\`\`
MD

cp "$REPORT_MD" "$BRIEF_DIR/latest_daily_brief.md"

echo "============================================================"
echo "FERTIG"
echo "============================================================"
echo "Daily Brief erstellt:"
echo "$REPORT_MD"
echo
echo "Latest:"
echo "$BRIEF_DIR/latest_daily_brief.md"
echo
echo "Kurzstatus:"
echo "CrashBandicot: $CONTROL_STATUS"
echo "OpenClaw intern: $OPENCLAW_OK"
echo "Flowise: $FLOWISE_OK"
echo "n8n: $N8N_OK"
echo "Telegram IPv4: $TG4_OK"
echo "Telegram IPv6: $TG6_OK"
echo "Freeze vorhanden: $FREEZE_OK"
echo "Timeshift: $TIMESHIFT_OK"
echo
echo "Offene Punkte:"
for item in "${OPEN_ITEMS[@]}"; do
  echo "- $item"
done
