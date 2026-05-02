# Shadowmaker Mission Control – Aufgabenliste

Stand: Sa 2. Mai 06:47:13 CEST 2026

## Betriebsregel

Keine ungeprüfte Autonomie. Jede produktive Änderung folgt:

1. Status prüfen
2. Änderung isoliert durchführen
3. Report schreiben
4. Git committen
5. /freeze_report ausführen
6. Timeshift bei stabilem Stand

## Aktive Aufgaben

| ID | Bereich | Aufgabe | Owner | Status | Priorität | Kontrolle |
|---|---|---|---|---|---:|---|
| MC-001 | Mission Control | Daily Brief produktiv nutzen | CrashBandicot | aktiv | 1 | daily-brief-discord |
| MC-002 | Security | Security Audit 2x täglich prüfen | Winky | aktiv/pruefen | 1 | sec-audit-list |
| MC-003 | Daily Delight | Tägliches Build-Idee-Modul aktivieren | Linky | vorbereitet | 1 | daily-delight-run |
| MC-004 | Memory | Memory-Wiki-Grundstruktur aufbauen | Mnemosyne | vorbereitet | 2 | memory-wiki-status |
| MC-005 | OpenClaw | Stackstatus nach Discord routen | Winky | aktiv | 1 | openclaw-status-discord |
| MC-006 | IHK/MFP | Lernsystem als Projektkanal pflegen | Mentor | vorbereitet | 2 | #ihk-mfp |
| MC-007 | Career | Bewerbungs-/CV-Material strukturieren | Strategist | offen | 3 | career-it |
| MC-008 | Finance | Finanz-/Jobcenter-Daten getrennt halten | Steward | offen | 3 | finance-control |
| MC-009 | Housing | WBS/Jobcenter/Wohnung nachweissicher führen | Steward | offen | 2 | housing-jobcenter |
| MC-010 | Prompt-to-Code | Wiederkehrende Prompts in Skripte stabilisieren | Linky | vorbereitet | 2 | prompt_to_code |

## Heute

- Daily Brief erzeugen
- Security Timer prüfen
- Daily Delight erstellen
- Memory-Wiki aktualisieren
- Phase-2-Status dokumentieren

## Keine Löschung

Duplikate, Cache, Browserdaten, Finanzdaten und Behördenunterlagen werden nicht automatisch gelöscht.

Phase 4 Ergänzung – 2026-05-02
ID	Bereich	Aufgabe	Owner	Status	Priorität	Kontrolle
P4-001	Workspace Audit	echte OpenClaw/Mission-Control-Daten prüfen	Winky	aktiv	1	openclaw-workspace-audit
P4-002	WebUI	Read-only Dashboard starten	Linky	vorbereitet	1	mission-control-webui-status
P4-003	Security	keine Secrets / keine Schreibaktionen	Winky	aktiv	1	mc4-status
MD						

echo "[OK] Memory Wiki und Tasks aktualisiert."
echo

echo "============================================================"
echo "7) ALIASE SETZEN"
echo "============================================================"

if [ -f "/home/schattenmacher/.bashrc" ]; then
cp "/home/schattenmacher/.bashrc" "/home/schattenmacher/.bashrc.bak.mission_control_phase4_webui_20260502_071917"
sed -i '/# >>> mission control phase4 webui aliases >>>/,/# <<< mission control phase4 webui aliases <<</d' "/home/schattenmacher/.bashrc" || true

cat >> "/home/schattenmacher/.bashrc" << 'ALIASES'

>>> mission control phase4 webui aliases >>>

alias openclaw-workspace-audit='~/openclaw_workspace_audit.sh'
alias mission-control-webui-status='~/mission_control_webui_status.sh'
alias mission-control-webui-install='~/mission_control_webui_install.sh'
alias mission-control-webui-start='~/mission_control_webui_start.sh'
alias mc4-status='cat ~/openclaw_training/docs/status/latest_mission_control_phase4_webui_status.md'

<<< mission control phase4 webui aliases <<<

ALIASES

bash -n "/home/schattenmacher/.bashrc"
echo "[OK] Aliase gesetzt."
fi

echo

echo "============================================================"
echo "8) DISCORD MELDUNG"
echo "============================================================"

if [ -x "/home/schattenmacher/openclaw_training/scripts/discord_send_channel.sh" ]; then
"/home/schattenmacher/openclaw_training/scripts/discord_send_channel.sh" DISCORD_MISSION_CONTROL_WEBHOOK_URL "Phase 4 vorbereitet: Workspace Audit + read-only Mission Control WebUI. Start lokal: mission-control-webui-install && mission-control-webui-start" || true
fi

echo

echo "============================================================"
echo "9) GIT COMMIT"
echo "============================================================"

if [ -d "/home/schattenmacher/openclaw_training/.git" ]; then
cd "/home/schattenmacher/openclaw_training"
git add mission_control docs scripts reports 2>/dev/null || true
git commit -m "Prepare Mission Control Phase 4 WebUI 20260502_071917" 2>/dev/null || true
git log --oneline -10 || true
fi

echo

echo "============================================================"
echo "10) ABSCHLUSS"
echo "============================================================"
echo "[OK] Phase 4 vorbereitet: Workspace Audit + Mission Control WebUI."
echo
echo "Jetzt prüfen:"
echo "source ~/.bashrc"
echo "mc4-status"
echo "mission-control-webui-status"
echo
echo "Dann installieren:"
echo "mission-control-webui-install"
echo
echo "Dann starten:"
echo "mission-control-webui-start"
echo
echo "Browser:"
echo "http://127.0.0.1:4173
"
echo
echo "Nach erfolgreichem Test:"
echo "/freeze_report"
echo
echo "Danach lokal:"
echo "sudo timeshift --create --comments "Shadowmaker stable freeze after Mission Control Phase 4 WebUI""
echo "sudo timeshift --list"
echo
echo "Report:"
echo "/home/schattenmacher/openclaw_training/reports/setup_mission_control_phase4_webui_allinone_20260502_071917.txt"
echo "============================================================"
echo "FERTIG"
echo "============================================================"


## Phase 4 Ergänzung – 2026-05-02

| ID | Bereich | Aufgabe | Owner | Status | Priorität | Kontrolle |
|---|---|---|---|---|---:|---|
| P4-001 | Workspace Audit | echte OpenClaw/Mission-Control-Daten prüfen | Winky | aktiv | 1 | openclaw-workspace-audit |
| P4-002 | WebUI | Read-only Dashboard starten | Linky | vorbereitet | 1 | mission-control-webui-status |
| P4-003 | Security | keine Secrets / keine Schreibaktionen | Winky | aktiv | 1 | mc4-status |
| P4-004 | WebUI Test | npm install + localhost Test | Linky | offen | 1 | mission-control-webui-install |

## Phase 5 Ergänzung – 2026-05-02

| ID | Bereich | Aufgabe | Owner | Status | Priorität | Kontrolle |
|---|---|---|---|---|---:|---|
| P5-001 | Multi-Agent | Winky als ersten echten Agent produktiv ausführen | Winky | aktiv | 1 | winky-run |
| P5-002 | Multi-Agent | Winky Timer optional entscheiden | User | offen | 2 | install-winky-timer-optional |
| P5-003 | Multi-Agent | Mentor als zweiten Agent vorbereiten | Mentor | vorbereitet | 2 | ihk-mfp-drill |
| P5-004 | Multi-Agent | Linky erst nach Winky-Stabilisierung aktivieren | Linky | wartend | 3 | prompt-to-code-review |

## Phase 5 Mnemosyne Ergänzung – 2026-05-02

| ID | Bereich | Aufgabe | Owner | Status | Priorität | Kontrolle |
|---|---|---|---|---|---:|---|
| P5-005 | Multi-Agent | Mnemosyne als Memory Curator produktiv ausführen | Mnemosyne | aktiv | 1 | mnemosyne-run |
| P5-006 | Memory | Memory-Wiki-Wachstum beobachten | Mnemosyne | aktiv | 2 | phase5-crew-status |
| P5-007 | Multi-Agent | Mnemosyne Timer optional entscheiden | User | offen | 2 | install-mnemosyne-timer-optional |
| P5-008 | Multi-Agent | Mentor als dritten Agent später aktivieren | Mentor | wartend | 3 | ihk-mfp-drill |

## Phase 5 Strategist Ergänzung – 2026-05-02

| ID | Bereich | Aufgabe | Owner | Status | Priorität | Kontrolle |
|---|---|---|---|---|---:|---|
| P5-013 | Multi-Agent | Strategist als Career Agent produktiv ausführen | Strategist | aktiv | 1 | strategist-run |
| P5-014 | Career | Stellenanzeigen nach Fit-Raster analysieren | Strategist | vorbereitet | 1 | strategist-latest |
| P5-015 | Career | CV-/Anschreiben-Bausteine erzeugen | Strategist | vorbereitet | 1 | latest_strategist_career_template |
| P5-016 | Multi-Agent | Strategist Timer optional entscheiden | User | offen | 3 | install-strategist-timer-optional |
| P5-017 | Multi-Agent | Steward später aktivieren | Steward | wartend | 3 | finance-housing-readonly |
