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
#   make run           — start the RAG web app
# ============================================================

TYPST   := typst
MAIN    := docs/summary.typ
OUTPUT  := output/summary.pdf

.PHONY: build watch test clean new-week install-typst run

## Start the RAG web app
run:
	streamlit run rag/app.py

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
new-week:
ifndef W
	$(error Usage: make new-week W=<number>, e.g. make new-week W=2)
endif
	python scripts/new_week.py $(W)

## Typst installation help
install-typst:
	@echo "Install Typst:"
	@echo "  Windows:  winget install --id Typst.Typst"
	@echo "  macOS:    brew install typst"
	@echo "  Linux:    cargo install typst-cli"
	@echo "  Manual:   https://github.com/typst/typst/releases"
