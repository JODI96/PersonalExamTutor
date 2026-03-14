# Exam Tutor

Personal exam tutoring system. Each week a new PDF is studied, documented in Typst, and compiled into one growing summary document.

## Structure

```
├── TUTOR_INSTRUCTIONS.md        ← Tutor behavior guide (read at session start)
├── moon.yml                     ← Moon build tasks
├── .moon/workspace.yml          ← Moon workspace config
├── docs/
│   ├── summary.typ              ← Master document (includes all weeks)
│   ├── template.typ             ← Shared Typst template & callout boxes
│   └── weeks/
│       └── week_01/             ← One folder per week
│           ├── index.typ        ← Week entry point (includes chapters)
│           └── chapter_01.typ   ← One file per topic/chapter
├── exercises/
│   └── week_01/
│       ├── problems.md          ← Exercises (try before looking at solutions!)
│       └── solutions.md         ← Step-by-step solutions
├── pdfs/
│   └── week_01/                 ← Drop this week's PDFs here (can be multiple)
├── output/
│   └── summary.pdf              ← Built PDF (also on GitHub)
└── .github/workflows/ci.yml     ← CI pipeline (builds on every push)
```

## Quick Start

```bash
# Install Typst (once)
winget install --id Typst.Typst

# Build the summary PDF
moon run exam-tutor:build

# Live preview — auto-recompiles on every save
moon run exam-tutor:watch
```

The PDF is written to `output/summary.pdf`.

## Adding a New Week

```bash
# 1. Scaffold all folders and files for week 2
WEEK=2 moon run exam-tutor:new-week

# 2. Uncomment the new week in docs/summary.typ:
#    #include "weeks/week_02/index.typ"

# 3. Rebuild
moon run exam-tutor:build
```

## Workflow (Each Week)

1. Drop the week's PDF(s) into `pdfs/week_XX/`
2. Run a tutor session → content is added to `docs/weeks/week_XX/`
3. Uncomment the week's include in `docs/summary.typ`
4. `moon run exam-tutor:build` → `output/summary.pdf` updated

## Using as a Template (Other Modules)

1. Create a new branch: `git checkout -b module-statistics`
2. Update `title:` and `module:` in `docs/summary.typ`
3. Clear `docs/weeks/` content and start fresh

`master` is always the clean skeleton to branch from.
