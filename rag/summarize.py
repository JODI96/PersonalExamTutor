"""Chunks → Claude API → Typst chapter file → make build."""

import os
import subprocess
from datetime import date

import anthropic
from dotenv import load_dotenv

from rag.config import DOCS_WEEKS, SUMMARY_TYP, ROOT, CLAUDE_MODEL, EXERCISES_DIR, PDFS_DIR
from rag.ingest import get_week_chunks
from rag.logger import log_typst_error, log_truncated, log_correction

load_dotenv()

_SYSTEM_PROMPT = """\
Du bist ein Lernhilfe-Assistent. Du schreibst Zusammenfassungen im Typst-Format \
für ein Prüfungs-Lernheft.

Zwei gleichwertige Ziele:
1. VOLLSTÄNDIGKEIT — erkläre ALLE Konzepte der Vorlesung. Nichts weglassen.
   Der Student soll die Vorlesung nicht mehr brauchen — deine Summary ersetzt sie.
2. ANWENDBARKEIT — der Student soll nach dem Lesen JEDE Übungsaufgabe \
   selbständig lösen können, auch mit anderen Zahlen oder Formulierungen.

Die Übungsaufgaben (falls mitgeliefert) sind ein Kompass: sie zeigen welche Konzepte \
besonders prüfungsrelevant sind und wie tief du erklären musst. \
Aber erkläre ALLE Konzepte aus der Vorlesung — nicht nur die die in Übungen vorkommen.

Für jedes Konzept schreibst du:
1. Die Kernidee in einem Satz — was steckt dahinter, intuitiv erklärt
2. Woran erkenne ich in einer Aufgabe, dass ich dieses Konzept brauche?
3. Allgemeiner Lösungsablauf (nicht mit konkreten Zahlen, sondern als Rezept)
4. Ein durchgerechnetes Beispiel das das Rezept illustriert
5. Was ändert sich wenn die Aufgabe anders gestellt ist? (Varianten)

Callout-Boxen:
- #formula-box[...] — Allgemeines Lösungsrezept als nummerierte Schritte + Beispiel
- #tip-box[...]      — "Woran erkenne ich X?", Entscheidungsregeln, Shortcuts
- #warn-box[...]     — Häufige Denkfehler und warum sie passieren
- #cheat-box[...]    — Kompakte Entscheidungshilfe: "Wenn X, dann Y"

WICHTIG — Verwende ausschliesslich gültige Typst-Syntax. Hier ist die vollständige \
Referenz für mathematische Ausdrücke:

  Brüche:      frac(a, b)           ← Komma trennt Zähler und Nenner, KEIN }{
  Fett:        bold(x)
  Summe:       sum_(i=0)^n f(i)
  Matrizen:    mat(1,2;3,4)
  Ungefähr:    approx
  Kleiner-gl:  lt.eq
  Größer-gl:   gt.eq
  Skalarpr.:   dot
  Betrag:      abs(x)
  Norm:        norm(x)
  Pfeil:       arrow.r   arrow.l   arrow.t   arrow.b
  Text in $:   "Text"
  Transpon.:   x^T
  Griech.:     alpha  beta  gamma  delta  epsilon  lambda  mu  sigma  theta  phi  psi
  Kalkül:      nabla  partial
  Mengen:      in  forall  infinity

Struktur: === Abschnitt, *Fetttext*, _Kursiv_
Kein #import, kein #show — beginne direkt mit == Chapter X: [Titel]

VERBOTEN — Typst-Markup-Fehler:
- *X*wort (einzelner Buchstabe fett, direkt gefolgt von weiterem Text) → *Xwort* verwenden
  Falsch: *E*ingabe  Richtig: *Eingabe*
  Falsch: *A*nalyse  Richtig: *Analyse*

VERBOTEN in Code-Blöcken:
- Kein PostgreSQL Dollar-Quoting $$ ... $$ — Typst interpretiert $$ als Mathe-Delimiter \
  auch innerhalb von Code-Blöcken. Ersetze $$ durch einfache Anführungszeichen ' oder \
  schreibe den Ausdruck ohne Dollar-Quoting um.
- Kein \\ am Zeilenende — verwende stattdessen einen neuen Absatz.
"""

_USER_TEMPLATE = """\
Hier sind die extrahierten Inhalte aus den Vorlesungs-PDFs für Woche {week_nr}:

---
{content}
---
{exercises_section}
Schreibe eine vollständige Typst-Zusammenfassung für Woche {week_nr}.

Der Fokus liegt auf VERSTÄNDNIS, nicht auf dem Kopieren von Formeln oder Zahlen.
Stelle dir vor: ein Student sieht in der Prüfung eine ähnliche aber neue Aufgabe.
Deine Zusammenfassung soll ihm helfen zu erkennen:
  — Um welches Konzept geht es hier?
  — Was sind die allgemeinen Schritte zur Lösung?
  — Worauf muss ich achten damit ich keinen Fehler mache?

Alle relevanten Formeln müssen enthalten sein — aber nie ohne Kontext.
Zu jeder Formel gehört:
  — Wann benutze ich sie? (Erkennungsmerkmal in der Aufgabe)
  — Was bedeuten die Variablen konkret?
  — Ein durchgerechnetes Beispiel mit symbolischen Variablen das zeigt wie man rechnet.
Zahlen aus der Vorlesung dürfen als Beispiel vorkommen, aber das Rezept \
muss allgemein formuliert sein sodass es auf neue Zahlen anwendbar ist.
"""

_EXERCISES_SECTION = """\
Diese Übungsaufgaben sind die echten Kursaufgaben die der Student lösen können muss:

=== Übungen (Referenz):
{exercises_text}
{solutions_section}
WICHTIG: Schreibe die Zusammenfassung so, dass ein Student der sie liest \
ALLE obigen Übungsaufgaben selbständig lösen kann. \
Für jedes Konzept das in einer Übung vorkommt: erkläre das allgemeine Lösungsrezept \
so dass es auf neue ähnliche Aufgaben anwendbar ist.

"""

_SOLUTIONS_SUBSECTION = """\
=== Musterlösungen (Referenz für Lösungsansätze):
{solutions_text}

"""


_READABLE_EXT = {".adoc", ".pdf", ".txt", ".md"}


def _read_folder_text(folder, max_chars: int = 20_000) -> str:
    """Read all readable files from a folder, return concatenated text (truncated)."""
    from pathlib import Path
    import fitz

    folder = Path(folder)
    if not folder.exists():
        return ""

    parts, total = [], 0
    for f in sorted(folder.iterdir()):
        if not f.is_file() or f.suffix.lower() not in _READABLE_EXT:
            continue
        if f.suffix.lower() == ".pdf":
            doc = fitz.open(str(f))
            text = "\n".join(page.get_text() for page in doc)
            doc.close()
        else:
            text = f.read_text(encoding="utf-8", errors="replace")
        snippet = text[:max_chars - total]
        parts.append(f"[{f.name}]\n{snippet}")
        total += len(snippet)
        if total >= max_chars:
            break
    return "\n\n---\n\n".join(parts)


def _build_exercises_section(week_nr: int) -> str:
    """Build the exercises+solutions section to inject into the summary prompt."""
    week_path = PDFS_DIR / f"week_{week_nr:02d}"
    ex_text  = _read_folder_text(week_path / "uebungen")
    sol_text = _read_folder_text(week_path / "loesungen")

    if not ex_text:
        return ""

    sol_part = _SOLUTIONS_SUBSECTION.format(solutions_text=sol_text) if sol_text else ""
    return _EXERCISES_SECTION.format(exercises_text=ex_text, solutions_section=sol_part)


def _build_content(chunks: list[dict], max_chars: int = 80_000) -> str:
    parts, total = [], 0
    for c in chunks:
        text = c["text"]
        if total + len(text) > max_chars:
            break
        parts.append(text)
        total += len(text)
    return "\n\n---\n\n".join(parts)


def _chapter_path(week_nr: int):
    return DOCS_WEEKS / f"week_{week_nr:02d}" / f"chapter_{week_nr:02d}.typ"


def _index_path(week_nr: int):
    return DOCS_WEEKS / f"week_{week_nr:02d}" / "index.typ"


def _ensure_summary_includes(week_nr: int) -> None:
    """Uncomment or add the #include for this week in summary.typ."""
    text = SUMMARY_TYP.read_text(encoding="utf-8")
    tag      = f'#include "weeks/week_{week_nr:02d}/index.typ"'
    commented = f'// {tag}'

    if tag in text:
        return
    if commented in text:
        text = text.replace(commented, tag)
    else:
        text = text.rstrip() + f'\n{tag}\n'

    SUMMARY_TYP.write_text(text, encoding="utf-8")


def _ensure_index_typ(week_path) -> bool:
    """Create a minimal index.typ if missing but chapters exist. Returns True if usable."""
    index = week_path / "index.typ"
    chapters = [c for c in week_path.glob("chapter_*.typ") if c.stat().st_size > 200]
    if not chapters:
        return False
    if not index.exists():
        wn   = week_path.name  # e.g. week_04
        n    = int(wn.split("_")[1])
        includes = "\n".join(f'#include "{c.name}"' for c in sorted(chapters))
        index.write_text(
            f'#import "../../template.typ": tip-box, warn-box, formula-box, cheat-box\n\n'
            f'= Week {n}\n\n{includes}\n',
            encoding="utf-8",
        )
    return True


def _sync_all_includes() -> None:
    """Auto-uncomment every week that has content."""
    import re
    text = SUMMARY_TYP.read_text(encoding="utf-8")
    changed = False

    for week_path in sorted(DOCS_WEEKS.glob("week_*")):
        if not _ensure_index_typ(week_path):
            continue

        wn        = week_path.name.replace("week_", "")
        tag       = f'#include "weeks/week_{wn}/index.typ"'
        commented = f'// {tag}'

        # Check if tag is active (starts a line, not preceded by //)
        already_active = bool(re.search(r'^' + re.escape(tag), text, re.MULTILINE))
        if already_active:
            continue

        if commented in text:
            text = text.replace(commented, tag)
            changed = True
        else:
            text = text.rstrip() + f'\n{tag}\n'
            changed = True

    if changed:
        SUMMARY_TYP.write_text(text, encoding="utf-8")


_FIX_SYSTEM = """\
Du bist ein Typst-Syntax-Korrektor. Du erhältst Typst-Code mit Kompilierfehlern \
und gibst den vollständig korrigierten Code zurück — ohne Erklärungen, ohne \
Markdown-Codeblock, nur reiner Typst-Code.

Häufigste Fehler und ihre Korrekturen:
  frac(a}{b})   →  frac(a, b)      ← geschweifte Klammern durch Komma ersetzen
  frac(a}{b)    →  frac(a, b)
  x^((i})       →  x^((i))         ← geschweifte Klammer durch runde ersetzen
  x^{i}         →  x^(i)           ← LaTeX-Klammern durch runde ersetzen
  _{i}          →  _(i)
  uparrow       →  arrow.t
  downarrow     →  arrow.b
  rightarrow    →  arrow.r
  leftarrow     →  arrow.l
  leq           →  lt.eq
  geq           →  gt.eq
  neq           →  eq.not
  cdot          →  dot
  infty         →  infinity
  $$ ... $$     →  '...'   ← PostgreSQL Dollar-Quoting durch einfache Quotes ersetzen

Abgeschnittener Code (Token-Limit):
  - Schliesse alle offenen #formula-box([, #tip-box[, #warn-box[, #cheat-box[ mit ])
  - Schliesse offene ( mit )  und  [ mit ]
  - Vervollständige abgebrochene Sätze sinnvoll auf Deutsch
  - Gib immer den vollständigen Code zurück (nicht nur die geänderten Stellen)
"""

_FIX_USER = """\
Dieser Typst-Code hat folgende Kompilierfehler:

{errors}

Hier ist der vollständige Code:

{code}

Gib den vollständig korrigierten Typst-Code zurück.
"""


def _strip_fences(text: str) -> str:
    import re
    text = re.sub(r"^```[a-z]*\n?", "", text.strip(), flags=re.IGNORECASE)
    text = re.sub(r"\n?```$", "", text.strip())
    return text.strip()


def _self_correct(typst_content: str, errors: str, client) -> str:
    msg = client.messages.create(
        model=CLAUDE_MODEL,
        max_tokens=8192,
        system=_FIX_SYSTEM,
        messages=[{"role": "user", "content": _FIX_USER.format(errors=errors, code=typst_content)}],
    )
    return _strip_fences(msg.content[0].text)


def _continue_truncated(partial: str, system: str, user_msg: str, client, progress=None) -> str:
    """Resume a truncated Typst generation using multi-turn — Claude only writes the missing ending."""
    if progress:
        progress("Output war abgeschnitten — Claude schreibt Fortsetzung...")
    msg = client.messages.create(
        model=CLAUDE_MODEL,
        max_tokens=4096,
        system=system,
        messages=[
            {"role": "user", "content": user_msg},
            {"role": "assistant", "content": partial},
            {"role": "user", "content": (
                "Dein Output wurde durch das Token-Limit unterbrochen. "
                "Schreibe bitte genau dort weiter wo du aufgehört hast — "
                "gib NUR die Fortsetzung aus, nicht den bereits geschriebenen Teil. "
                "Schliesse alle offenen Blöcke (#formula-box, #tip-box, #warn-box, #cheat-box) "
                "mit `])` bzw. `]` und beende das Dokument sauber."
            )},
        ],
    )
    continuation = _strip_fences(msg.content[0].text)
    return partial + continuation


def generate_summary(week_nr: int, progress=None) -> str:
    """Generate a Typst chapter file from indexed chunks. Returns the file path."""
    if progress:
        progress("Lade Chunks aus Datenbank...")

    chunks = get_week_chunks(week_nr)
    if not chunks:
        raise RuntimeError(f"Keine Chunks für Woche {week_nr} — erst indexieren!")

    content = _build_content(chunks)

    if progress:
        progress("Lese Übungs- und Lösungsdateien...")
    exercises_section = _build_exercises_section(week_nr)
    if exercises_section and progress:
        progress("Übungen gefunden — Summary wird darauf ausgerichtet.")
    elif progress:
        progress("Keine Übungsdateien — generiere allgemeine Zusammenfassung.")

    if progress:
        progress("Generiere Zusammenfassung mit Claude...")

    client = anthropic.Anthropic(api_key=os.environ["ANTHROPIC_API_KEY"])
    user_msg = _USER_TEMPLATE.format(
        week_nr=week_nr,
        content=content,
        exercises_section=exercises_section,
    )
    message = client.messages.create(
        model=CLAUDE_MODEL,
        max_tokens=8192,
        system=_SYSTEM_PROMPT,
        messages=[{"role": "user", "content": user_msg}],
    )
    typst_content = message.content[0].text

    # If Claude hit the token limit, continue the generation in a follow-up turn
    if message.stop_reason == "max_tokens":
        log_truncated(week_nr)
        typst_content = _continue_truncated(typst_content, _SYSTEM_PROMPT, user_msg, client, progress)

    chapter_path = _chapter_path(week_nr)
    chapter_path.parent.mkdir(parents=True, exist_ok=True)

    header = (
        f"// Auto-generated by RAG system on {date.today()}\n"
        f"// Week {week_nr} — do not edit the header\n\n"
        f'#import "../../template.typ": tip-box, warn-box, formula-box, cheat-box\n\n'
    )
    chapter_path.write_text(header + typst_content, encoding="utf-8")
    _ensure_summary_includes(week_nr)

    for attempt in range(3):
        try:
            if progress:
                progress(f"Baue PDF (Versuch {attempt + 1})...")
            _build_pdf()
            break
        except RuntimeError as e:
            if attempt == 2:
                log_correction(week_nr, attempt + 1, success=False)
                raise
            error_msg = str(e)
            log_typst_error(week_nr, attempt + 1, error_msg)
            first_error = error_msg.split("\n")[1] if "\n" in error_msg else error_msg
            if progress:
                progress(f"Syntax-Fehler: {first_error.strip()}")
                progress(f"Sende Fehler an Claude zur Korrektur...")
            typst_content = _self_correct(typst_content, error_msg, client)
            chapter_path.write_text(header + typst_content, encoding="utf-8")
            log_correction(week_nr, attempt + 1, success=True)
            if progress:
                progress(f"Claude hat den Code korrigiert — baue neu...")

    return str(chapter_path)


_EXERCISES_SYSTEM = """\
Du erstellst prüfungsnahe Übungsaufgaben für ein Lernheft.
Nutze NUR den bereitgestellten Vorlesungsinhalt als Grundlage.
Format: Markdown mit LaTeX-Mathe ($...$ für inline, $$...$$ für Display).
Struktur pro Aufgabe:
  ## Exercise N — [Titel]
  Kurze Beschreibung, dann konkrete Zahlen/Matrizen/Aufgabenstellung.
  Unteraufgaben mit **(a)**, **(b)**, **(c)** etc.
Erstelle 3–4 Aufgaben die typische Prüfungsaufgaben dieses Themas abdecken.
"""

_SOLUTIONS_SYSTEM = """\
Du erstellst detaillierte Musterlösungen für Prüfungsübungen.
Nutze den Lösungsweg GENAU so wie er in der Vorlesung besprochen wurde.
Format: Markdown mit LaTeX-Mathe.
Für jede Aufgabe:
  ## Exercise N — [Titel]
  ### (a) ...
  **Step 1 —** Beschreibung was und warum
  [Rechenschritt mit vollständiger Rechnung]
  $$\\boxed{Endergebnis}$$
Zeige JEDEN Zwischenschritt. Erkläre warum jeder Schritt gemacht wird.
Verweise auf Konzepte aus der Vorlesung (z.B. "Wie in der Vorlesung: orthogonale Matrizen haben A⁻¹ = Aᵀ").
"""


def generate_exercises(week_nr: int, progress=None) -> tuple[str, str]:
    """Generate problems.md and solutions.md for a week. Returns (problems_path, solutions_path)."""
    if progress:
        progress("Lade Chunks aus Datenbank...")

    chunks = get_week_chunks(week_nr)
    if not chunks:
        raise RuntimeError(f"Keine Chunks für Woche {week_nr} — erst indexieren!")

    content = _build_content(chunks)
    client  = anthropic.Anthropic(api_key=os.environ["ANTHROPIC_API_KEY"])

    if progress:
        progress("Generiere Übungsaufgaben mit Claude...")

    problems_msg = client.messages.create(
        model=CLAUDE_MODEL,
        max_tokens=4096,
        system=_EXERCISES_SYSTEM,
        messages=[{
            "role": "user",
            "content": (
                f"Vorlesungsinhalt Woche {week_nr}:\n\n{content}\n\n"
                f"Erstelle 3–4 prüfungsnahe Übungsaufgaben zu diesem Material."
            ),
        }],
    )

    if progress:
        progress("Generiere detaillierte Lösungswege mit Claude...")

    problems_text = problems_msg.content[0].text
    solutions_msg = client.messages.create(
        model=CLAUDE_MODEL,
        max_tokens=8192,
        system=_SOLUTIONS_SYSTEM,
        messages=[{
            "role": "user",
            "content": (
                f"Vorlesungsinhalt Woche {week_nr}:\n\n{content}\n\n"
                f"Hier sind die Aufgaben:\n\n{problems_text}\n\n"
                f"Erstelle detaillierte Schritt-für-Schritt Lösungen exakt im Vorlesungsstil."
            ),
        }],
    )

    ex_dir = EXERCISES_DIR / f"week_{week_nr:02d}"
    ex_dir.mkdir(parents=True, exist_ok=True)

    header_problems = (
        f"# Week {week_nr} — Exercises\n\n"
        f"**Generiert:** {date.today()}  \n"
        f"> Versuche alle Aufgaben selbst bevor du `solutions.md` anschaust!\n\n---\n\n"
    )
    header_solutions = (
        f"# Week {week_nr} — Solutions\n\n"
        f"**Generiert:** {date.today()}  \n"
        f"> Nur lesen nachdem du die Aufgaben ernsthaft versucht hast!\n\n---\n\n"
    )

    problems_path  = ex_dir / "problems.md"
    solutions_path = ex_dir / "solutions.md"
    problems_path.write_text(header_problems  + problems_text,              encoding="utf-8")
    solutions_path.write_text(header_solutions + solutions_msg.content[0].text, encoding="utf-8")

    return str(problems_path), str(solutions_path)


def _normalize(p) -> str:
    s = str(p)
    if s.startswith("\\\\?\\"):
        s = s[4:]
    return s


def _auto_generate_missing(progress=None) -> None:
    """For every week that has chunks in ChromaDB but no chapter .typ file, generate the summary."""
    from rag.ingest import get_week_chunks
    for week_nr in range(1, 15):
        chapter = _chapter_path(week_nr)
        if chapter.exists() and chapter.stat().st_size > 200:
            continue
        chunks = get_week_chunks(week_nr)
        if not chunks:
            continue
        if progress:
            progress(f"Woche {week_nr} fehlt — generiere Zusammenfassung...")
        generate_summary(week_nr)


def _build_pdf(auto_generate: bool = False, progress=None) -> None:
    if auto_generate:
        _auto_generate_missing(progress=progress)
    _sync_all_includes()
    (ROOT / "output").mkdir(exist_ok=True)
    cwd = _normalize(ROOT)
    result = subprocess.run(
        ["typst", "compile", "docs/summary.typ", "output/summary.pdf"],
        cwd=cwd,
        capture_output=True,
        text=True,
    )
    if result.returncode != 0:
        raise RuntimeError(f"typst compile fehlgeschlagen:\n{result.stderr}")
