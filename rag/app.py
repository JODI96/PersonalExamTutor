"""Streamlit Web-App für das RAG-System."""

import sys
import subprocess
from pathlib import Path
sys.path.insert(0, str(Path(__file__).parent.parent))

import os
import streamlit as st
from dotenv import load_dotenv

load_dotenv()

# ── Auto-watch: typst watch läuft im Hintergrund ─────────────────────────────
@st.cache_resource
def _start_typst_watch():
    root = Path(__file__).parent.parent
    (root / "output").mkdir(exist_ok=True)
    # Initial build on startup
    subprocess.run(
        ["typst", "compile", "docs/summary.typ", "output/summary.pdf"],
        cwd=str(root),
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
    )
    # Then watch for changes
    proc = subprocess.Popen(
        ["typst", "watch", "docs/summary.typ", "output/summary.pdf"],
        cwd=str(root),
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
    )
    return proc

_start_typst_watch()

st.set_page_config(
    page_title="Exam Tutor RAG",
    page_icon="📚",
    layout="wide",
)

# ── API Key Check ────────────────────────────────────────────────────────────
if not os.environ.get("ANTHROPIC_API_KEY") or os.environ["ANTHROPIC_API_KEY"] == "your-key-here":
    st.error(
        "**Kein API Key gefunden.** "
        "Trage deinen Anthropic API Key in die `.env` Datei ein:\n\n"
        "```\nANTHROPIC_API_KEY=sk-ant-...\n```\n\n"
        "Key erstellen: https://console.anthropic.com → API Keys → New Key"
    )
    st.stop()

# ── Lazy imports (nach API-Key Check) ────────────────────────────────────────
from rag.ingest import ingest_week
from rag.summarize import generate_summary
from rag.query import answer
from rag.expand import add_to_summary

# ── Session State ────────────────────────────────────────────────────────────
if "messages" not in st.session_state:
    st.session_state.messages = []
if "last_answers" not in st.session_state:
    st.session_state.last_answers = {}  # idx → {answer, week_nr}

# ── Sidebar ──────────────────────────────────────────────────────────────────
with st.sidebar:
    st.title("📚 Exam Tutor RAG")
    st.divider()

    week_nr = st.selectbox("Woche auswählen", list(range(1, 15)), index=0, format_func=lambda w: f"Woche {w:02d}")

    st.subheader("1. PDFs indexieren")
    if st.button("PDFs einlesen & indexieren", use_container_width=True):
        with st.status("Indexiere PDFs...", expanded=True) as status:
            try:
                def progress(msg):
                    st.write(msg)
                n = ingest_week(week_nr, progress=progress)
                if n == 0:
                    status.update(label=f"Woche {week_nr} bereits indexiert", state="complete")
                else:
                    status.update(label=f"{n} Chunks indexiert", state="complete")
            except FileNotFoundError as e:
                status.update(label="Fehler", state="error")
                st.error(str(e))
            except Exception as e:
                status.update(label="Fehler", state="error")
                st.error(f"Fehler: {e}")

    st.subheader("2. PDF bauen")
    if st.button("PDF neu bauen", use_container_width=True):
        with st.status("Baue PDF...", expanded=True) as status:
            try:
                from rag.summarize import _build_pdf
                def prog_build(msg):
                    st.write(msg)
                _build_pdf(auto_generate=True, progress=prog_build)
                status.update(label="PDF fertig!", state="complete")
            except Exception as e:
                status.update(label="Fehler", state="error")
                st.error(str(e))

    st.subheader("3. Übungen generieren")
    if st.button("Übungen & Lösungen erstellen", use_container_width=True):
        with st.status("Generiere Übungen...", expanded=True) as status:
            try:
                from rag.summarize import generate_exercises
                def prog_ex(msg):
                    st.write(msg)
                p_path, s_path = generate_exercises(week_nr, progress=prog_ex)
                status.update(label="Übungen fertig!", state="complete")
                st.success(f"problems.md + solutions.md erstellt")
            except RuntimeError as e:
                status.update(label="Fehler", state="error")
                st.error(str(e))
            except Exception as e:
                status.update(label="Fehler", state="error")
                st.error(f"Fehler: {e}")

    st.subheader("4. Zusammenfassung generieren")
    if st.button("Typst-Zusammenfassung erstellen", use_container_width=True):
        with st.status("Generiere Zusammenfassung...", expanded=True) as status:
            try:
                def progress2(msg):
                    st.write(msg)
                path = generate_summary(week_nr, progress=progress2)
                status.update(label="Zusammenfassung fertig!", state="complete")
                st.success(f"Datei: {path}")
            except RuntimeError as e:
                status.update(label="Fehler", state="error")
                st.error(str(e))
            except Exception as e:
                status.update(label="Fehler", state="error")
                st.error(f"Fehler: {e}")

    st.divider()
    st.caption("Fragen werden über alle indizierten Wochen beantwortet.")

    if st.button("Chat leeren", use_container_width=True):
        st.session_state.messages = []
        st.session_state.last_answers = {}
        st.rerun()

# ── Chat ─────────────────────────────────────────────────────────────────────
st.title("Chat")

for idx, msg in enumerate(st.session_state.messages):
    with st.chat_message(msg["role"]):
        st.markdown(msg["content"])

        if msg["role"] == "assistant" and idx in st.session_state.last_answers:
            info = st.session_state.last_answers[idx]
            sources = info.get("sources", [])
            if sources:
                src_text = ", ".join(f"Woche {s['week']} ({s['filename']})" for s in sources)
                st.caption(f"Quellen: {src_text}")

            col1, col2 = st.columns([3, 1])
            with col2:
                btn_key = f"add_{idx}"
                if st.button("+ Zur Zusammenfassung", key=btn_key):
                    result_placeholder = st.empty()
                    def expand_progress(m):
                        result_placeholder.info(m)
                    result = add_to_summary(msg["content"], week_nr, progress=expand_progress)
                    if result["status"] == "added":
                        result_placeholder.success(result["message"])
                    elif result["status"] == "duplicate":
                        result_placeholder.warning(result["message"])
                    else:
                        result_placeholder.error(result["message"])

if question := st.chat_input("Stelle eine Frage zu deinen Lernmaterialien..."):
    st.session_state.messages.append({"role": "user", "content": question})

    with st.chat_message("user"):
        st.markdown(question)

    with st.chat_message("assistant"):
        with st.spinner("Suche in Dokumenten..."):
            try:
                result = answer(question)
                answer_text = result["answer"]
                sources     = result["sources"]
            except Exception as e:
                answer_text = f"Fehler: {e}"
                sources     = []

        st.markdown(answer_text)
        if sources:
            src_text = ", ".join(f"Woche {s['week']} ({s['filename']})" for s in sources)
            st.caption(f"Quellen: {src_text}")

    idx = len(st.session_state.messages)
    st.session_state.messages.append({"role": "assistant", "content": answer_text})
    st.session_state.last_answers[idx] = {"sources": sources, "week_nr": week_nr}
    st.rerun()
