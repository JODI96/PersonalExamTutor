"""Scaffold a new week folder. Usage: python scripts/new_week.py 3"""

import sys
import shutil
from pathlib import Path

ROOT = Path(__file__).parent.parent


def new_week(n: int) -> None:
    wn = f"{n:02d}"
    dirs = [
        ROOT / "docs" / "weeks" / f"week_{wn}",
        ROOT / "pdfs" / f"week_{wn}",
        ROOT / "exercises" / f"week_{wn}",
    ]
    for d in dirs:
        d.mkdir(parents=True, exist_ok=True)

    docs_dir = ROOT / "docs" / "weeks" / f"week_{wn}"
    src_docs  = ROOT / "docs" / "weeks" / "week_01"

    if not (docs_dir / "index.typ").exists():
        text = (src_docs / "index.typ").read_text(encoding="utf-8")
        text = text.replace("week_01", f"week_{wn}").replace("Week 1", f"Week {n}")
        (docs_dir / "index.typ").write_text(text, encoding="utf-8")
        print(f"OK Created docs/weeks/week_{wn}/index.typ")

    if not (docs_dir / "chapter_01.typ").exists():
        text = (src_docs / "chapter_01.typ").read_text(encoding="utf-8")
        text = text.replace("week_01", f"week_{wn}").replace("Week 1", f"Week {n}")
        (docs_dir / "chapter_01.typ").write_text(text, encoding="utf-8")
        print(f"OK Created docs/weeks/week_{wn}/chapter_01.typ")

    ex_dir     = ROOT / "exercises" / f"week_{wn}"
    src_ex_dir = ROOT / "exercises" / "week_01"
    for fname in ("problems.md", "solutions.md"):
        dest = ex_dir / fname
        if not dest.exists():
            shutil.copy(src_ex_dir / fname, dest)
            print(f"OK Created exercises/week_{wn}/{fname}")

    gitkeep = ROOT / "pdfs" / f"week_{wn}" / ".gitkeep"
    gitkeep.touch()
    print(f"OK Created pdfs/week_{wn}/  (drop PDFs here)")
    print()
    print(f'Next: uncomment  #include "weeks/week_{wn}/index.typ"  in docs/summary.typ')


if __name__ == "__main__":
    if len(sys.argv) != 2 or not sys.argv[1].isdigit():
        print("Usage: python scripts/new_week.py <week_number>")
        sys.exit(1)
    new_week(int(sys.argv[1]))
