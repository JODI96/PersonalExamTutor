"""PDF → text chunks → embeddings → ChromaDB."""

from __future__ import annotations

import fitz  # PyMuPDF
import chromadb
from sentence_transformers import SentenceTransformer

from rag.config import (
    PDFS_DIR, CHROMA_DIR, CHROMA_COLLECTION,
    EMBEDDING_MODEL, CHUNK_SIZE, CHUNK_OVERLAP,
)

_embedder: SentenceTransformer | None = None
_client: chromadb.PersistentClient | None = None


def _get_embedder() -> SentenceTransformer:
    global _embedder
    if _embedder is None:
        _embedder = SentenceTransformer(EMBEDDING_MODEL)
    return _embedder


def _get_collection() -> chromadb.Collection:
    global _client
    if _client is None:
        CHROMA_DIR.mkdir(parents=True, exist_ok=True)
        _client = chromadb.PersistentClient(path=str(CHROMA_DIR))
    return _client.get_or_create_collection(CHROMA_COLLECTION)


def _week_dir(week_nr: int):
    return PDFS_DIR / f"week_{week_nr:02d}"


def _extract_text(pdf_path) -> str:
    doc = fitz.open(str(pdf_path))
    pages = [page.get_text() for page in doc]
    doc.close()
    return "\n".join(pages)


def _chunk(text: str) -> list[str]:
    chunks, start = [], 0
    while start < len(text):
        end = start + CHUNK_SIZE
        chunks.append(text[start:end].strip())
        start += CHUNK_SIZE - CHUNK_OVERLAP
    return [c for c in chunks if len(c) > 30]


def ingest_week(week_nr: int, progress=None) -> int:
    """Index all PDFs in pdfs/week_XX/. Returns number of new chunks added."""
    week_path = _week_dir(week_nr)
    if not week_path.exists():
        raise FileNotFoundError(f"Ordner nicht gefunden: {week_path}")

    pdfs = list(week_path.glob("*.pdf"))
    if not pdfs:
        raise FileNotFoundError(f"Keine PDFs in {week_path}")

    collection = _get_collection()
    embedder   = _get_embedder()
    added = 0

    for pdf in pdfs:
        if progress:
            progress(f"Lese {pdf.name}...")
        text   = _extract_text(pdf)
        chunks = _chunk(text)

        for i, chunk in enumerate(chunks):
            doc_id = f"w{week_nr:02d}_{pdf.stem}_{i}"
            # skip if already indexed
            existing = collection.get(ids=[doc_id])
            if existing["ids"]:
                continue
            embedding = embedder.encode(chunk).tolist()
            collection.add(
                ids=[doc_id],
                embeddings=[embedding],
                documents=[chunk],
                metadatas=[{"week": week_nr, "filename": pdf.name, "chunk": i}],
            )
            added += 1

    return added


def get_week_chunks(week_nr: int) -> list[dict]:
    """Return all stored chunks for a given week."""
    collection = _get_collection()
    result = collection.get(where={"week": week_nr}, include=["documents", "metadatas"])
    return [
        {"text": doc, "meta": meta}
        for doc, meta in zip(result["documents"], result["metadatas"])
    ]


def query_chunks(question: str, top_k: int = 5) -> list[dict]:
    """Embed a question and return the top_k most similar chunks."""
    embedder   = _get_embedder()
    collection = _get_collection()
    embedding  = embedder.encode(question).tolist()
    result = collection.query(
        query_embeddings=[embedding],
        n_results=top_k,
        include=["documents", "metadatas", "distances"],
    )
    return [
        {"text": doc, "meta": meta, "distance": dist}
        for doc, meta, dist in zip(
            result["documents"][0],
            result["metadatas"][0],
            result["distances"][0],
        )
    ]


def embed_text(text: str) -> list[float]:
    return _get_embedder().encode(text).tolist()


def chunk_similarity(embedding: list[float], week_nr: int) -> float:
    """Return the max cosine similarity of an embedding against all chunks of a week."""
    import numpy as np

    collection = _get_collection()
    result = collection.get(where={"week": week_nr}, include=["embeddings"])
    if not result["embeddings"]:
        return 0.0

    vec = np.array(embedding)
    sims = [
        float(np.dot(vec, np.array(e)) / (np.linalg.norm(vec) * np.linalg.norm(e) + 1e-9))
        for e in result["embeddings"]
    ]
    return max(sims)


def add_chunk(text: str, week_nr: int, source: str = "expansion") -> None:
    """Add a single text chunk to the index (used after smart expand)."""
    collection = _get_collection()
    embedder   = _get_embedder()
    import time
    doc_id    = f"w{week_nr:02d}_{source}_{int(time.time())}"
    embedding = embedder.encode(text).tolist()
    collection.add(
        ids=[doc_id],
        embeddings=[embedding],
        documents=[text],
        metadatas=[{"week": week_nr, "filename": source, "chunk": 0}],
    )
