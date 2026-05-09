"""Frage → Embedding → Top-K Chunks → Claude → Antwort + Quellen."""

import os

import anthropic
from dotenv import load_dotenv

from rag.config import CLAUDE_MODEL, TOP_K
from rag.ingest import query_chunks

load_dotenv()

_SYSTEM = """\
Du bist ein persönlicher Prüfungstutor. Dein Ziel: der Student soll Konzepte so tief \
verstehen, dass er beliebige Aufgaben dazu lösen kann.

Erkenne selbst was der Student braucht:

**Wenn es eine Verständnisfrage ist** ("Was ist X?", "Wie funktioniert Y?", "Erkläre..."):
1. **Kernidee** — ein Satz, intuitiv, ohne Fachbegriffe
2. **Erklärung** — präzise auf Basis des Kontexts, mit dem Warum dahinter
3. **Beispiel** — zeige wie es konkret angewendet wird
4. **Achtung** — häufige Denkfehler oder Stolpersteine falls im Kontext erkennbar

**Wenn es eine Aufgabe ist** (Berechne, Löse, Zeige, Bestimme...):
1. **Konzept** — ein Satz: welches Konzept steckt dahinter und warum passt es hier?
2. **Schritt-für-Schritt Lösung** — JEDEN Schritt zeigen, nichts überspringen
   - Jeden Schritt nummerieren
   - In einem Satz erklären warum dieser Schritt gemacht wird
   - Vollständige Rechnung (keine "..." in Formeln)
3. **Ergebnis** — klar hervorheben
4. **Lernpunkt** — ein Satz: was soll der Student aus dieser Aufgabe mitnehmen?

Regeln:
- Nutze NUR den bereitgestellten Kontext als Informationsquelle
- Wenn der Kontext nicht ausreicht, sag es explizit
- Antworte auf Deutsch
- Markdown: **fett**, Listen, $...$ für inline-Formeln, $$...$$ für Display
- Matrizen und Zwischenergebnisse immer vollständig ausschreiben
"""


def answer(question: str, top_k: int = TOP_K) -> dict:
    """
    Returns:
        {
          "answer": str,
          "sources": [{"week": int, "filename": str}, ...],
          "chunks_used": int,
        }
    """
    hits = query_chunks(question, top_k=top_k)
    if not hits:
        return {
            "answer": "Keine Dokumente indexiert. Bitte zuerst eine Woche indexieren.",
            "sources": [],
            "chunks_used": 0,
        }

    context_parts = []
    seen_sources: list[dict] = []
    for i, hit in enumerate(hits, 1):
        context_parts.append(f"[Quelle {i}] Woche {hit['meta']['week']} — {hit['meta']['filename']}\n{hit['text']}")
        src = {"week": hit["meta"]["week"], "filename": hit["meta"]["filename"]}
        if src not in seen_sources:
            seen_sources.append(src)

    context = "\n\n".join(context_parts)

    client = anthropic.Anthropic(api_key=os.environ["ANTHROPIC_API_KEY"])
    message = client.messages.create(
        model=CLAUDE_MODEL,
        max_tokens=4096,
        system=_SYSTEM,
        messages=[{
            "role": "user",
            "content": (
                f"Kontext aus den Vorlesungsunterlagen:\n{context}\n\n"
                f"Frage/Aufgabe: {question}"
            ),
        }],
    )

    return {
        "answer": message.content[0].text,
        "sources": seen_sources,
        "chunks_used": len(hits),
    }
