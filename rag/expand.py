"""Smart summary expansion: answer → Typst snippet → deduplicated insert."""

import os

import anthropic
from dotenv import load_dotenv

from rag.config import DOCS_WEEKS, CLAUDE_MODEL, DUP_THRESHOLD
from rag.ingest import embed_text, chunk_similarity, add_chunk
from rag.summarize import _build_pdf

load_dotenv()

_SNIPPET_SYSTEM = """\
Du schreibst einen kurzen Typst-Ergänzungs-Snippet für ein Lernheft.

Regeln:
- Maximal 1-2 Absätze Typst-Markup
- Nutze #formula-box[...], #tip-box[...] oder #warn-box[...] wenn passend
- Kein #import, kein == Heading wenn der Inhalt zu einem bestehenden Abschnitt gehört
- Falls es ein wirklich neues Konzept ist: beginne mit === [Konzepttitel]
- Typst-Mathe: $bold(A)$, $sum_i$, etc.
- Antworte NUR mit dem Typst-Code, kein erklärender Text davor/danach
"""


def _chapter_path(week_nr: int):
    return DOCS_WEEKS / f"week_{week_nr:02d}" / f"chapter_{week_nr:02d}.typ"


def add_to_summary(answer_text: str, week_nr: int, progress=None) -> dict:
    """
    Check for duplicates, then insert a Typst snippet into the chapter file.

    Returns:
        {"status": "added" | "duplicate" | "no_chapter", "message": str}
    """
    chapter_path = _chapter_path(week_nr)
    if not chapter_path.exists():
        return {
            "status": "no_chapter",
            "message": f"Kein Chapter für Woche {week_nr}. Bitte zuerst eine Zusammenfassung generieren.",
        }

    if progress:
        progress("Prüfe auf Duplikate...")

    embedding  = embed_text(answer_text)
    similarity = chunk_similarity(embedding, week_nr)

    if similarity >= DUP_THRESHOLD:
        return {
            "status": "duplicate",
            "message": f"Inhalt bereits vorhanden (Ähnlichkeit: {similarity:.0%}). Nichts hinzugefügt.",
        }

    if progress:
        progress("Generiere Typst-Snippet...")

    client = anthropic.Anthropic(api_key=os.environ["ANTHROPIC_API_KEY"])
    message = client.messages.create(
        model=CLAUDE_MODEL,
        max_tokens=1024,
        system=_SNIPPET_SYSTEM,
        messages=[{
            "role": "user",
            "content": (
                f"Formuliere folgenden Inhalt als Typst-Snippet für Woche {week_nr}:\n\n"
                f"{answer_text}"
            ),
        }],
    )
    snippet = message.content[0].text.strip()

    existing = chapter_path.read_text(encoding="utf-8")
    chapter_path.write_text(
        existing.rstrip() + "\n\n// --- Ergänzt via RAG Chat ---\n" + snippet + "\n",
        encoding="utf-8",
    )

    add_chunk(answer_text, week_nr, source="expansion")

    if progress:
        progress("Baue PDF neu...")
    _build_pdf()

    return {
        "status": "added",
        "message": "Erfolgreich zur Zusammenfassung hinzugefügt und PDF neu gebaut.",
    }
