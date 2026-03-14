# Exam Tutor

Personal exam tutoring system. Each week a new PDF is studied, documented in Typst, and compiled into one growing summary document.

## Structure

```
├── TUTOR_INSTRUCTIONS.md        ← Tutor behavior guide (read at session start)
├── docs/
│   ├── summary.typ              ← Master document (includes all weeks)
│   ├── template.typ             ← Shared Typst template & callout boxes
│   └── weeks/
│       └── week_01/             ← One folder per week
│           ├── index.typ        ← Week entry point (includes chapters)
│           ├── chapter_01.typ   ← One file per topic/chapter
│           └── chapter_02.typ   ← Add more as needed
├── exercises/
│   └── week_01/
│       ├── problems.md          ← Exercises (try before looking at solutions!)
│       └── solutions.md         ← Step-by-step solutions
├── pdfs/
│   └── week_01/                 ← Drop this week's PDFs here (can be multiple)
├── output/                      ← Built PDF (gitignored)
├── Makefile                     ← Build commands
└── .github/workflows/ci.yml     ← CI pipeline
```

## Quick Start

```bash
# Install Typst (once)
winget install --id Typst.Typst

# Build the summary PDF
make build

# Live preview while editing
make watch

# Add a new week
make new-week W=2
```

## Workflow

1. Upload new PDF to `pdfs/`
2. Run a tutor session → content gets added to `docs/weeks/week_XX.typ`
3. Uncomment the new week in `docs/summary.typ`
4. `make build` → `output/summary.pdf` updated

## Using as a Template (Other Modules)

This repo is designed as a reusable template:

1. Create a new branch or fork: `git checkout -b module-statistics`
2. Edit `docs/summary.typ`: update `module:` and `title:` fields
3. Clear `docs/weeks/` content and start fresh

The `template` branch always contains the clean skeleton.
