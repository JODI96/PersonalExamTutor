# ============================================================
# Exam Tutor — Build System
# ============================================================
# Commands:
#   make build        — compile the Typst document to PDF
#   make watch        — live-reload while editing
#   make test         — build and verify (used in CI)
#   make clean        — remove build output
#   make new-week W=2 — scaffold a new week (e.g. make new-week W=2)
#   make install-typst — instructions to install typst
# ============================================================

TYPST   := typst
MAIN    := docs/summary.typ
OUTPUT  := output/summary.pdf

.PHONY: build watch test clean new-week install-typst

## Build the PDF
build: output
	$(TYPST) compile $(MAIN) $(OUTPUT)
	@echo "✓ Built: $(OUTPUT)"

## Live preview (auto-recompile on save)
watch: output
	$(TYPST) watch $(MAIN) $(OUTPUT)

## CI test: build must succeed
test: build
	@echo "✓ Build test passed"

## Remove output
clean:
	rm -f $(OUTPUT)

## Create output directory if missing
output:
	mkdir -p output

## Scaffold a new week folder (usage: make new-week W=2)
## Each week is a folder: docs/weeks/week_XX/, pdfs/week_XX/, exercises/week_XX/
new-week:
ifndef W
	$(error Usage: make new-week W=<number>, e.g. make new-week W=2)
endif
	@WN=$$(printf '%02d' $(W)); \
	WDIR="docs/weeks/week_$${WN}"; \
	PDIR="pdfs/week_$${WN}"; \
	EXDIR="exercises/week_$${WN}"; \
	if [ -d "$$WDIR" ]; then \
		echo "Week $$WN already exists: $$WDIR"; \
	else \
		mkdir -p $$WDIR $$PDIR $$EXDIR; \
		sed "s/week_01/week_$${WN}/g; s/Week 1/Week $${WN}/g" \
			docs/weeks/week_01/index.typ > $$WDIR/index.typ; \
		sed "s/week_01/week_$${WN}/g; s/Week 1/Week $${WN}/g; s/Chapter 1/Chapter 1/g" \
			docs/weeks/week_01/chapter_01.typ > $$WDIR/chapter_01.typ; \
		cp exercises/week_01/problems.md  $$EXDIR/problems.md; \
		cp exercises/week_01/solutions.md $$EXDIR/solutions.md; \
		touch $$PDIR/.gitkeep; \
		echo "✓ Created $$WDIR/index.typ"; \
		echo "✓ Created $$WDIR/chapter_01.typ"; \
		echo "✓ Created $$PDIR/  (drop PDFs here)"; \
		echo "✓ Created $$EXDIR/problems.md + solutions.md"; \
		echo ""; \
		echo "Next: uncomment  #include \"weeks/week_$${WN}/index.typ\"  in docs/summary.typ"; \
	fi

## Typst installation help
install-typst:
	@echo "Install Typst:"
	@echo "  Windows:  winget install --id Typst.Typst"
	@echo "  macOS:    brew install typst"
	@echo "  Linux:    cargo install typst-cli"
	@echo "  Manual:   https://github.com/typst/typst/releases"
