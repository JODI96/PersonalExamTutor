"""Chunks → Claude API → Typst chapter file → make build."""

import os
import subprocess
from datetime import date

import anthropic
from dotenv import load_dotenv

from rag.config import DOCS_WEEKS, SUMMARY_TYP, ROOT, CLAUDE_MODEL, EXERCISES_DIR
from rag.ingest import get_week_chunks

load_dotenv()

_SYSTEM_PROMPT = """\
Du bist ein Lernhilfe-Assistent. Du schreibst strukturierte Zusammenfassungen \
im Typst-Format für ein Prüfungs-Lernheft.

Regeln:
- Nutze diese Callout-Boxen aus dem Template:
    #formula-box[...] für Formeln und Referenz-Tabellen (blau)
    #tip-box[...]      für Key Insights und Eselsbrücken (grün)
    #warn-box[...]     für Prüfungsfallen (orange)
    #cheat-box[...]    für komprimierte Cheat-Sheet Blöcke (lila)
- Mathe in Typst: $bold(A)$, $A_(i,j)$, $sum_k$, $mat(1,2;3,4)$
- Struktur: === Abschnitt, *Fetttext*, _Kursiv_
- Kein #import, kein #show, keine Header-Zeile — das kommt von der index.typ
- Beginne direkt mit == Chapter X: [Titel]
- Sei präzise und lehrreich. Prüfungsrelevante Punkte hervorheben.
"""

_USER_TEMPLATE = """\
Hier sind die extrahierten Inhalte aus den Vorlesungs-PDFs für Woche {week_nr}:

---
{content}
---

Schreibe eine vollständige, strukturierte Typst-Zusammenfassung für dieses Material. \
Chapter-Nummer: {week_nr}. Nutze formula-box für alle Formeln, tip-box für Kerneinsichten, \
warn-box für häufige Fehler/Prüfungsfallen.
"""


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


def generate_summary(week_nr: int, progress=None) -> str:
    """Generate a Typst chapter file from indexed chunks. Returns the file path."""
    if progress:
        progress("Lade Chunks aus Datenbank...")

    chunks = get_week_chunks(week_nr)
    if not chunks:
        raise RuntimeError(f"Keine Chunks für Woche {week_nr} — erst indexieren!")

    content = _build_content(chunks)

    if progress:
        progress("Generiere Zusammenfassung mit Claude...")

    client = anthropic.Anthropic(api_key=os.environ["ANTHROPIC_API_KEY"])
    message = client.messages.create(
        model=CLAUDE_MODEL,
        max_tokens=8192,
        system=_SYSTEM_PROMPT,
        messages=[{
            "role": "user",
            "content": _USER_TEMPLATE.format(
                week_nr=week_nr,
                content=content,
            ),
        }],
    )
    typst_content = message.content[0].text

    chapter_path = _chapter_path(week_nr)
    chapter_path.parent.mkdir(parents=True, exist_ok=True)

    header = (
        f"// Auto-generated by RAG system on {date.today()}\n"
        f"// Week {week_nr} — do not edit the header\n\n"
        f'#import "../../template.typ": tip-box, warn-box, formula-box, cheat-box\n\n'
    )
    chapter_path.write_text(header + typst_content, encoding="utf-8")

    _ensure_summary_includes(week_nr)

    if progress:
        progress("Baue PDF...")
    _build_pdf()

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
