from pathlib import Path

# Project root = parent of this file's parent
ROOT = Path(__file__).parent.parent

PDFS_DIR      = ROOT / "pdfs"
DOCS_WEEKS    = ROOT / "docs" / "weeks"
SUMMARY_TYP   = ROOT / "docs" / "summary.typ"
EXERCISES_DIR = ROOT / "exercises"
CHROMA_DIR    = ROOT / "chroma_db"

CLAUDE_MODEL      = "claude-sonnet-4-6"
EMBEDDING_MODEL   = "all-MiniLM-L6-v2"
CHROMA_COLLECTION = "exam_tutor"

CHUNK_SIZE      = 500   # characters
CHUNK_OVERLAP   = 50
TOP_K           = 5     # retrieved chunks per query
DUP_THRESHOLD   = 0.85  # cosine similarity above which we skip insertion
