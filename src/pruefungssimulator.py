#!/usr/bin/env python3
"""
OPENCLAW PRÜFUNGSSIMULATOR
Echter IHK-Zeitdruck: 45min pro SA, zufällige Frage, automatische Bewertung.
"""
import subprocess, json, re, time, random, datetime, sys, requests, signal
from pathlib import Path

OLLAMA_URL   = "http://127.0.0.1:11434/api/generate"
OLLAMA_MODEL = "qwen2.5:7b"
ROUTER       = Path(__file__).parent / "rag_query_router.py"
PYTHON       = sys.executable
REPORTS      = Path.home() / "openclaw_training" / "reports"
REPORTS.mkdir(parents=True, exist_ok=True)

# IHK: 45 Minuten pro Situationsaufgabe
PRUEFUNGSZEIT_SEKUNDEN = 45 * 60

FRAGENKATALOG = {
    "SA1": [
        "Ein Team von 6 Entwicklern liefert seit 3 Sprints keine Definition-of-Done-konforme Arbeit. Der Product Owner eskaliert.",
        "Teamkonflikt zwischen Entwicklung und QA verzögert Release um 3 Wochen. Der Kunde droht mit Konventionalstrafe.",
        "Ein neues CRM-System soll in 6 Monaten eingeführt werden. Drei Abteilungen verweigern aktiv die Mitarbeit.",
        "Ein Schlüsselmitarbeiter kündigt mitten in der kritischen Projektphase. Kein Wissenstransfer wurde dokumentiert.",
        "Der Auftraggeber fordert kurzfristig 40% mehr Features ohne Budgeterhöhung. Das Team ist am Limit.",
        "Zwei Projektteams arbeiten an denselben Schnittstellen ohne Koordination. Doppelarbeit und Konflikte entstehen.",
    ],
    "SA2": [
        "Outsourcing-Partner liefert 40% der Tickets nicht fristgerecht. SLA wird dauerhaft unterschritten.",
        "Der IT-Dienstleister unterschreitet vereinbarte SLA-Werte um 35%. Eskalation durch Geschäftsführung.",
        "Ein ERP-Einführungsprojekt überschreitet Budget um 30%. Der Auftraggeber droht mit Vertragsauflösung.",
        "Nach Go-Live treten kritische Systemfehler auf. Der Betrieb ist 8 Stunden ausgefallen. Kundenverträge gefährdet.",
        "Das Projektbudget wurde durch Scope Creep um 50% überschritten. Steering Committee verlangt sofortigen Bericht.",
    ],
    "SA3": [
        "Datenschutzverletzung im laufenden Projekt durch fehlende Zugriffskontrollen. Kundendaten betroffen.",
        "Ein Mitarbeiter hat versehentlich Produktionsdaten gelöscht. Backup ist 3 Tage alt. Recovery läuft.",
        "Das neue System ist nicht barrierefrei. Die Abnahme durch den Betriebsrat wird verweigert.",
        "Sicherheitsaudit zeigt: Passwortrichtlinien wurden im Projekt ignoriert. Pentest deckt 3 kritische Lücken auf.",
        "Ein Zulieferer wurde insolvent. Kritische Softwarekomponente ist nicht mehr wartbar. Go-Live in 4 Wochen.",
    ],
}

SCORER_PROMPT = """
Du bist ein strenger IHK-Prüfer. Bewerte die folgende Prüfungsantwort.
Vergib für jeden der 10 Punkte genau 0, 1 oder 2 Punkte:
1 Situation       – Fallbezogen und konkret?
2 Ziel SMART      – Datum + messbarer KPI + Budget?
3 Stakeholder     – Tabellarisch mit Einfluss?
4 Ursachen        – Mensch / Organisation / Prozess sauber getrennt?
5 Alternativen    – 3 echte Maßnahmen, kein Status quo?
6 Bewertung       – Zahlen + alle 3 Dimensionen pro Alternative?
7 Entscheidung    – Gegen B/C + min. 3 fallbezogene Argumente?
8 Umsetzung       – Wer + Maßnahme + konkretes Datum?
9 Kontrolle       – Min. 3 KPIs mit Einheit + Zielwert?
10 Nachhaltigkeit – Lessons Learned + Rechtliches konkret benannt?

Antworte NUR in diesem JSON (kein Text davor/danach):
{"scores":[P1,P2,P3,P4,P5,P6,P7,P8,P9,P10],"total":SUMME,"staerken":["..."],"schwaechen":["..."],"urteil":"BESTANDEN oder NICHT BESTANDEN","feedback":"Ein Satz Gesamtfeedback"}
ANTWORT:
{answer}
"""

class Timer:
    def __init__(self, sekunden):
        self.limit = sekunden
        self.start = time.time()
        self._expired = False

    def elapsed(self):
        return int(time.time() - self.start)

    def remaining(self):
        return max(0, self.limit - self.elapsed())

    def expired(self):
        return self.remaining() == 0

    def fmt(self, secs):
        m, s = divmod(secs, 60)
        return f"{m:02d}:{s:02d}"

    def status(self):
        rem = self.remaining()
        pct = rem / self.limit
        if pct > 0.5:   color = "\033[0;32m"
        elif pct > 0.2: color = "\033[1;33m"
        else:            color = "\033[0;31m"
        return f"{color}⏱  {self.fmt(rem)} verbleibend\033[0m"


def wahl_frage(sa_typ=None):
    if sa_typ is None:
        sa_typ = random.choice(["SA1", "SA2", "SA3"])
    frage = random.choice(FRAGENKATALOG[sa_typ])
    return sa_typ, frage


def call_router(question):
    result = subprocess.run(
        [PYTHON, str(ROUTER)],
        input=question + "\n\nexit\n",
        capture_output=True, text=True, timeout=300
    )
    return result.stdout


def call_scorer(answer):
    prompt = SCORER_PROMPT.replace("{answer}", answer[:3500])
    r = requests.post(OLLAMA_URL, json={
        "model": OLLAMA_MODEL, "prompt": prompt,
        "stream": False, "options": {"temperature": 0.1}
    }, timeout=120)
    r.raise_for_status()
    raw = r.json().get("response", "")
    try:
        m = re.search(r'\{.*\}', raw, re.DOTALL)
        return json.loads(m.group(0)) if m else {"total": -1, "urteil": "PARSE-FEHLER"}
    except Exception:
        return {"total": -1, "urteil": "PARSE-FEHLER", "raw": raw}


def bar(score, max_score=20, width=20):
    filled = int(score / max_score * width)
    return "█" * filled + "░" * (width - filled)


def print_scorecard(sa_typ, frage, answer, score_data, elapsed):
    total     = score_data.get("total", 0)
    urteil    = score_data.get("urteil", "?")
    scores    = score_data.get("scores", [])
    staerken  = score_data.get("staerken", [])
    schwaechen= score_data.get("schwaechen", [])
    feedback  = score_data.get("feedback", "")
    labels    = ["Situation","Ziel SMART","Stakeholder","Ursachen","Alternativen",
                 "Bewertung","Entscheidung","Umsetzung","Kontrolle","Nachhaltigkeit"]

    m, s = divmod(elapsed, 60)
    zeit_str = f"{m:02d}:{s:02d}"
    farbe = "\033[0;32m" if total >= 16 else ("\033[1;33m" if total >= 12 else "\033[0;31m")

    print("\n" + "═" * 72)
    print(f"  SCORECARD – {sa_typ} – {datetime.datetime.now().strftime('%Y-%m-%d %H:%M')}")
    print("═" * 72)
    print(f"  Frage:  {frage}")
    print(f"  Zeit:   {zeit_str} / 45:00")
    print(f"  Score:  {farbe}{total}/20  [{bar(total)}]  {urteil}\033[0m")
    print()

    if scores:
        for i, (lbl, sc) in enumerate(zip(labels, scores), 1):
            icon = "✅" if sc == 2 else ("⚠️ " if sc == 1 else "❌")
            print(f"    {icon} P{i:02d} {lbl:<16} {sc}/2")
    print()

    if staerken:
        print("  STÄRKEN:")
        for s in staerken:
            print(f"    + {s}")
    if schwaechen:
        print("  VERBESSERUNG:")
        for s in schwaechen:
            print(f"    – {s}")
    if feedback:
        print(f"\n  FAZIT: {feedback}")
    print("═" * 72)
    return total


def save_report(sa_typ, frage, answer, score_data, elapsed):
    ts = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
    path = REPORTS / f"sim_{sa_typ}_{ts}.txt"
    total = score_data.get("total", 0)
    with open(path, "w", encoding="utf-8") as f:
        f.write(f"OPENCLAW PRÜFUNGSSIMULATOR\n")
        f.write(f"Datum: {datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
        f.write(f"SA-Typ: {sa_typ} | Score: {total}/20 | Zeit: {elapsed//60:02d}:{elapsed%60:02d}\n")
        f.write(f"{'='*60}\n")
        f.write(f"FRAGE:\n{frage}\n\n")
        f.write(f"ANTWORT:\n{answer}\n\n")
        f.write(f"BEWERTUNG:\n{json.dumps(score_data, ensure_ascii=False, indent=2)}\n")
    print(f"\n  Report: {path}")


def modus_ki(sa_typ, frage):
    """KI generiert Antwort – Scoring als Qualitätsprüfung."""
    print(f"\n  KI-Modus: Router generiert SA-Antwort...")
    q = f"Erstelle eine {sa_typ} Antwort: {frage}"
    timer = Timer(PRUEFUNGSZEIT_SEKUNDEN)

    router_out = call_router(q)
    m = re.search(r'\[IHK-ROUTER.*?\]\n(.*?)--- QUELLEN ---', router_out, re.DOTALL)
    answer = m.group(1).strip() if m else router_out[:3000]
    elapsed = timer.elapsed()

    print("  Bewertung läuft...")
    score_data = call_scorer(answer)
    return answer, score_data, elapsed


def modus_manuell(sa_typ, frage):
    """Nutzer schreibt selbst – echter Prüfungsmodus."""
    timer = Timer(PRUEFUNGSZEIT_SEKUNDEN)
    print(f"\n  PRÜFUNGSMODUS AKTIV – {sa_typ}")
    print(f"  Zeitlimit: 45:00 Minuten")
    print(f"  Frage: {frage}")
    print(f"\n  Antwort eingeben (10 Punkte). Leere Zeile + 'ABGABE' beendet:")
    print("  " + "─" * 60)

    lines = []
    last_status = -1
    while not timer.expired():
        rem = timer.remaining()
        if rem // 60 != last_status:
            last_status = rem // 60
            print(f"  {timer.status()}", end="\r")

        try:
            line = input()
        except (EOFError, KeyboardInterrupt):
            break
        if line.strip().upper() == "ABGABE":
            break
        lines.append(line)

    elapsed = timer.elapsed()
    answer = "\n".join(lines).strip()

    if timer.expired():
        print("\n  ⏰ ZEIT ABGELAUFEN – automatische Abgabe")
    else:
        print(f"\n  Abgabe nach {elapsed//60:02d}:{elapsed%60:02d}")

    if not answer:
        print("  Keine Antwort eingegeben.")
        return "", {"total": 0, "urteil": "NICHT BESTANDEN"}, elapsed

    print("  Bewertung läuft...")
    score_data = call_scorer(answer)
    return answer, score_data, elapsed


def hauptmenu():
    print("\n" + "═" * 72)
    print("  OPENCLAW PRÜFUNGSSIMULATOR v1.0")
    print("  IHK IT-Projektleiter – Situationsaufgaben Training")
    print("═" * 72)
    print()
    print("  [1]  KI-Modus      – Router löst, Scorer bewertet")
    print("  [2]  Prüfungsmodus – Du löst selbst (45 Min Zeitdruck)")
    print("  [3]  Batch-Test    – 5 Fragen automatisch (wie bisher)")
    print("  [q]  Beenden")
    print()

    while True:
        wahl = input("  Auswahl: ").strip().lower()
        if wahl in {"1", "2", "3", "q"}:
            return wahl
        print("  Ungültige Eingabe.")


def sa_auswahl():
    print("\n  SA-Typ wählen:")
    print("  [1] SA1  [2] SA2  [3] SA3  [z] Zufällig")
    while True:
        w = input("  Auswahl: ").strip().lower()
        if w == "1": return "SA1"
        if w == "2": return "SA2"
        if w == "3": return "SA3"
        if w == "z": return None
        print("  Ungültig.")


def batch_test():
    fragen = [
        ("SA1", "Teamkonflikt zwischen Entwicklung und QA verzögert Release um 3 Wochen."),
        ("SA2", "Outsourcing-Partner liefert 40% der Tickets nicht fristgerecht."),
        ("SA3", "Datenschutzverletzung im laufenden Projekt durch fehlende Zugriffskontrollen."),
        ("SA1", "Ein neues CRM-System soll in 6 Monaten eingeführt werden. Drei Abteilungen verweigern die Mitarbeit."),
        ("SA2", "Der IT-Dienstleister unterschreitet vereinbarte SLA-Werte um 35%."),
    ]
    totals = []
    for i, (sa, frage) in enumerate(fragen, 1):
        print(f"\n  [{i}/{len(fragen)}] {sa}: {frage[:55]}...")
        q = f"Erstelle eine {sa} Antwort: {frage}"
        router_out = call_router(q)
        m = re.search(r'\[IHK-ROUTER.*?\]\n(.*?)--- QUELLEN ---', router_out, re.DOTALL)
        answer = m.group(1).strip() if m else router_out[:3000]
        sd = call_scorer(answer)
        t = sd.get("total", 0)
        totals.append(t)
        u = sd.get("urteil", "?")
        print(f"  Score: {t}/20 – {u}")

    avg = sum(totals) / len(totals) if totals else 0
    print(f"\n  ═══ BATCH-ERGEBNIS: Ø {avg:.1f}/20 ═══")
    if avg >= 17:   print("  ✅ SYSTEM PRODUKTIONSREIF")
    elif avg >= 14: print("  ⚠️  SYSTEM AUSREICHEND")
    else:           print("  ❌ OPTIMIERUNG NÖTIG")


def main():
    while True:
        wahl = hauptmenu()
        if wahl == "q":
            print("  Auf Wiedersehen.")
            break

        elif wahl == "3":
            batch_test()

        elif wahl in {"1", "2"}:
            sa_typ = sa_auswahl()
            sa_typ, frage = wahl_frage(sa_typ)
            print(f"\n  Frage ({sa_typ}): {frage}")

            if wahl == "1":
                answer, score_data, elapsed = modus_ki(sa_typ, frage)
            else:
                answer, score_data, elapsed = modus_manuell(sa_typ, frage)

            total = print_scorecard(sa_typ, frage, answer, score_data, elapsed)
            save_report(sa_typ, frage, answer, score_data, elapsed)

        print()
        cont = input("  Weiter? [j/N]: ").strip().lower()
        if cont != "j":
            break


if __name__ == "__main__":
    main()
