MAIN = main
BUILDDIR = build

LATEX = pdflatex
LATEXFLAGS = -interaction=nonstopmode -output-directory=$(BUILDDIR) -file-line-error
BIBER = biber
BIBERFLAGS =

VIEWER = open  # macOS

# Source files
TEX_FILES = $(MAIN).tex thesis-preamble.tex abstract.tex acknowledgements.tex
CHAPTER_FILES = $(wildcard chapters/*.tex)
APPENDIX_FILES = $(wildcard appendices/*.tex)
TABLE_FILES = $(wildcard tables/*.tex)
FIG_FILES = $(wildcard figures/*/*.tex)
BIB_FILES = references.bib

ALL_FILES = $(TEX_FILES) $(CHAPTER_FILES) $(APPENDIX_FILES) $(BIB_FILES) $(TABLE_FILES) $(FIG_FILES) ucbthesis.cls

all: $(MAIN).pdf

$(BUILDDIR):
	@mkdir -p $(BUILDDIR)

$(MAIN).pdf: $(ALL_FILES) | $(BUILDDIR)
	@echo "=== Creating symbolic links for subdirectories ==="
	@ln -sfn ../chapters $(BUILDDIR)/chapters
	@ln -sfn ../appendices $(BUILDDIR)/appendices
	@ln -sfn ../figures $(BUILDDIR)/figures
	@ln -sfn ../tables $(BUILDDIR)/tables
	@ln -sfn ../references.bib $(BUILDDIR)/references.bib
	
	@echo "=== First LaTeX pass ==="
	-$(LATEX) $(LATEXFLAGS) $(MAIN)
	@echo "=== Running Biber ==="
	cd $(BUILDDIR) && $(BIBER) $(MAIN)
	@echo "=== Second LaTeX pass ==="
	-$(LATEX) $(LATEXFLAGS) $(MAIN)
	@echo "=== Third LaTeX pass (for references) ==="
	-$(LATEX) $(LATEXFLAGS) $(MAIN)
	@echo "=== Moving PDF to root directory ==="
	@cp $(BUILDDIR)/$(MAIN).pdf .
	@echo "=== Compilation complete ==="

# Quick compile (no bibliography)
quick: | $(BUILDDIR)
	@ln -sfn ../chapters $(BUILDDIR)/chapters
	@ln -sfn ../appendices $(BUILDDIR)/appendices
	@ln -sfn ../figures $(BUILDDIR)/figures
	@ln -sfn ../tables $(BUILDDIR)/tables
	$(LATEX) $(LATEXFLAGS) $(MAIN)
	@cp $(BUILDDIR)/$(MAIN).pdf .

view: $(MAIN).pdf
	$(VIEWER) $(MAIN).pdf

# Clean auxiliary files (keep PDF)
clean:
	@echo "Cleaning auxiliary files..."
	@rm -rf $(BUILDDIR)
	@rm -f *~ *.backup

# Clean everything including PDF
cleanall: clean
	@echo "Removing PDF..."
	@rm -f $(MAIN).pdf

# Final version (remove draft mode, editorial comments)
final:
	@echo "Creating final version..."
	@echo "Remember to:"
	@echo "  1. Comment out editorial commands in preamble"
	@echo "  2. Remove draft option if used"
	@echo "  3. Ensure all figures are high resolution"
	@echo "  4. Check formatting requirements"
	$(MAKE) cleanall
	$(MAKE) all

# Continuous compilation (watch for changes)
watch:
	@echo "Watching for changes... (Press Ctrl+C to stop)"
	@while true; do \
		$(MAKE) all; \
		echo "Waiting for changes..."; \
		fswatch -1 $(TEX_FILES) $(CHAPTER_FILES) $(APPENDIX_FILES) $(BIB_FILES) 2>/dev/null || sleep 5; \
	done

# Check for common issues
check: $(MAIN).pdf
	@echo "=== Checking for common issues ==="
	@echo "Checking for undefined references..."
	@grep -i "undefined" $(BUILDDIR)/$(MAIN).log || echo "No undefined references found."
	@echo "Checking for overfull hboxes..."
	@grep -i "overfull" $(BUILDDIR)/$(MAIN).log || echo "No overfull hboxes found."
	@echo "Checking for missing citations..."
	@grep -i "citation.*undefined" $(BUILDDIR)/$(MAIN).log || echo "No missing citations found."
	@echo "Checking for \\kd and \\bn commands (editorial marks)..."
	@grep -n "\\\\kd\|\\\\bn" $(CHAPTER_FILES) || echo "No editorial marks found."

.PHONY: all quick view clean cleanall final watch check