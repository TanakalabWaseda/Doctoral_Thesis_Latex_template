# Makefile for PhD Thesis
# Usage: make [target]

# Main file name (without .tex extension)
MAIN = overall_thesis

# LaTeX compiler
LATEX = pdflatex
BIBTEX = bibtex

# Compiler flags
LATEXFLAGS = -interaction=nonstopmode -halt-on-error

# Output PDF
PDF = $(MAIN).pdf

# Auxiliary files to clean
AUX_FILES = *.aux *.log *.toc *.lof *.lot *.out *.bbl *.blg *.synctex.gz *.fls *.fdb_latexmk \
            chapters/*/*.aux front_matter/*.aux

# ============================================================================
# TARGETS
# ============================================================================

.PHONY: all clean cleanall help view bib chapters chapter1 chapter2 chapter3 chapter4 chapter5 chapter6 chapter7 appendixA appendixB

# Default target
all: $(PDF)

# Compile thesis (run twice for cross-references)
$(PDF): $(MAIN).tex phdthesis.cls
	@echo "First LaTeX pass..."
	@$(LATEX) $(LATEXFLAGS) $(MAIN).tex
	@echo "Second LaTeX pass..."
	@$(LATEX) $(LATEXFLAGS) $(MAIN).tex
	@echo "Done! PDF generated: $(PDF)"

# Compile with bibliography
bib: $(MAIN).tex phdthesis.cls bibliography.bib
	@echo "First LaTeX pass..."
	@$(LATEX) $(LATEXFLAGS) $(MAIN).tex
	@echo "Running BibTeX..."
	@$(BIBTEX) $(MAIN)
	@echo "Second LaTeX pass..."
	@$(LATEX) $(LATEXFLAGS) $(MAIN).tex
	@echo "Third LaTeX pass..."
	@$(LATEX) $(LATEXFLAGS) $(MAIN).tex
	@echo "Done! PDF with bibliography generated: $(PDF)"
	@echo "Compiling individual chapters in parallel..."
	@$(MAKE) -j$(shell nproc 2>/dev/null || sysctl -n hw.logicalcpu) chapters

# Quick compile (single pass, for fast preview)
quick: $(MAIN).tex
	@echo "Quick compile (single pass)..."
	@$(LATEX) $(LATEXFLAGS) $(MAIN).tex
	@echo "Done! Note: cross-references may be incorrect."

# Clean auxiliary files
clean:
	@echo "Cleaning auxiliary files..."
	@rm -f $(AUX_FILES)
	@rm -f chapters/*/*_temp.*
	@echo "Done!"

# Clean everything including PDF
cleanall: cleans..."
	@rm -f $(PDF)
	@rm -f chapters/*/*.pdfng PDF..."
	@rm -f $(PDF)
	@echo "All clean!"

# View PDF (macOS)
view: $(PDF)
	@echo "Opening PDF..."
	@open $(PDF)

# Compile all individual chapters (run in parallel with: make -j8 chapters)
chapters: chapter1 chapter2 chapter3 chapter4 chapter5 chapter6 chapter7 appendixA appendixB

# Compile individual chapters
chapter1:
	@./compile_chapter.sh chapter1

chapter2:
	@./compile_chapter.sh chapter2

chapter3:
	@./compile_chapter.sh chapter3

chapter4:
	@./compile_chapter.sh chapter4

chapter5:
	@./compile_chapter.sh chapter5

chapter6:
	@./compile_chapter.sh chapter6

chapter7:
	@./compile_chapter.sh chapter7

appendixA:
	@if [ -f chapters/appendixA/appendixA.tex ]; then \
		./compile_chapter.sh appendixA; \
	else \
		echo "Skipping appendixA (chapters/appendixA/appendixA.tex not found)"; \
	fi

appendixB:
	@if [ -f chapters/appendixB/appendixB.tex ]; then \
		./compile_chapter.sh appendixB; \
	else \
		echo "Skipping appendixB (chapters/appendixB/appendixB.tex not found)"; \
	fi

# Show help
help:
	@echo "PhD Thesis Makefile"
	@echo "==================="
	@echo ""
	@echo "Available targets:"
	@echo "  make          - Compile thesis (default)"
	@echo "  make chapter6 - Compile Chapter 6 individually"
	@echo "  make chapter7 - Compile Chapter 7 individually"
	@echo "  make all      - Compile thesis"
	@echo "  make bib      - Compile with BibTeX"
	@echo "  make quick    - Quick compile (single pass)"
	@echo "  make chapters - Compile all individual chapters"
	@echo "  make chapter1 - Compile Chapter 1 individually"
	@echo "  make chapter2 - Compile Chapter 2 individually"
	@echo "  make chapter3 - Compile Chapter 3 individually"
	@echo "  make chapter4 - Compile Chapter 4 individually"
	@echo "  make chapter5 - Compile Chapter 5 individually"
	@echo "  make chapter6 - Compile Chapter 6 individually"
	@echo "  make chapter7 - Compile Chapter 7 individually"
	@echo "  make clean    - Remove auxiliary files"
	@echo "  make cleanall - Remove all generated files"
	@echo "  make view     - Open PDF (macOS)"
	@echo "  make help     - Show this help"
	@echo ""
	@echo "Example workflow:"
	@echo "  1. Edit your chapter files in chapters/*/"
	@echo "  2. make bib"
	@echo "  3. make view"
	@echo ""
	@echo "Directory structure:"
	@echo "  overall_thesis.tex    - Main thesis file"
	@echo "  phdthesis.cls         - LaTeX class file"
	@echo "  bibliography.bib      - Bibliography database"
	@echo "  chapters/             - Individual chapter files"
	@echo "  front_matter/         - Front matter files"
