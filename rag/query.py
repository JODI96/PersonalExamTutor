"""Frage → Embedding → Top-K Chunks → Claude → Antwort + Quellen."""

import os

import anthropic
from dotenv import load_dotenv

from rag.config import CLAUDE_MODEL, TOP_K
from rag.ingest import query_chunks

load_dotenv()

_SYSTEM = """\
Du bist ein präziser Lernassistent für Prüfungsvorbereitung. \
Beantworte Fragen ausschliesslich auf Basis des bereitgestellten Kontexts. \
Wenn der Kontext die Frage nicht abdeckt, sag das ehrlich. \
Antworte auf Deutsch. Nutze Markdown-Formatierung (fett, Listen, Formeln mit $...$).
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
        max_tokens=2048,
        system=_SYSTEM,
        messages=[{
            "role": "user",
            "content": (
                f"Kontext:\n{context}\n\n"
                f"Frage: {question}"
            ),
        }],
    )

    return {
        "answer": message.content[0].text,
        "sources": seen_sources,
        "chunks_used": len(hits),
    }
