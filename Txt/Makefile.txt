# Makefile for UC Berkeley Thesis with build directory
# All auxiliary files go to build/, PDF stays in root

# Main file name (without extension)
MAIN = main

# Build directory
BUILDDIR = build

# LaTeX compiler and flags
LATEX = pdflatex
LATEXFLAGS = -interaction=nonstopmode -output-directory=$(BUILDDIR)
BIBER = biber
BIBERFLAGS = 

# Viewer (change according to your OS)
VIEWER = open  # macOS
# VIEWER = xdg-open  # Linux
# VIEWER = start  # Windows

# Source files
TEX_FILES = $(MAIN).tex thesis-preamble.tex abstract.tex acknowledgements.tex
CHAPTER_FILES = $(wildcard chapters/*.tex)
APPENDIX_FILES = $(wildcard appendices/*.tex)
BIB_FILES = references.bib

# All source files
ALL_FILES = $(TEX_FILES) $(CHAPTER_FILES) $(APPENDIX_FILES) $(BIB_FILES)

# Default target
all: $(MAIN).pdf

# Create build directory and subdirectories if they don't exist
$(BUILDDIR):
	@mkdir -p $(BUILDDIR)
	@mkdir -p $(BUILDDIR)/chapters
	@mkdir -p $(BUILDDIR)/appendices

# Main compilation rule
$(MAIN).pdf: $(ALL_FILES) | $(BUILDDIR)
	@echo "=== Creating symbolic links for subdirectories ==="
	@ln -sfn ../chapters $(BUILDDIR)/chapters
	@ln -sfn ../appendices $(BUILDDIR)/appendices
	@echo "=== First LaTeX pass ==="
	-$(LATEX) $(LATEXFLAGS) $(MAIN)
	@echo "=== Running Biber ==="
	-cd $(BUILDDIR) && $(BIBER) $(MAIN)
	@echo "=== Second LaTeX pass ==="
	-$(LATEX) $(LATEXFLAGS) $(MAIN)
	@echo "=== Third LaTeX pass (for references) ==="
	-$(LATEX) $(LATEXFLAGS) $(MAIN)
	@echo "=== Moving PDF to root directory ==="
	@cp $(BUILDDIR)/$(MAIN).pdf .
	@echo "=== Compilation complete ==="

# Quick compile (no bibliography)
quick: | $(BUILDDIR)
	$(LATEX) $(LATEXFLAGS) $(MAIN)
	@cp $(BUILDDIR)/$(MAIN).pdf .

# View the PDF
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

# Word count (approximate)
wordcount: $(MAIN).pdf
	@echo "Approximate word count:"
	@pdftotext $(MAIN).pdf - | wc -w

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

# Show the build directory contents
show-build:
	@echo "Contents of build directory:"
	@ls -la $(BUILDDIR)/ 2>/dev/null || echo "Build directory doesn't exist yet."

# Help
help:
	@echo "Available targets:"
	@echo "  make all       - Full compilation with bibliography"
	@echo "  make quick     - Quick compilation (no bibliography)"
	@echo "  make view      - Compile and view PDF"
	@echo "  make clean     - Remove auxiliary files (keep PDF)"
	@echo "  make cleanall  - Remove all generated files including PDF"
	@echo "  make final     - Prepare final version"
	@echo "  make watch     - Continuously compile on file changes"
	@echo "  make wordcount - Show approximate word count"
	@echo "  make check     - Check for common issues"
	@echo "  make show-build - Show contents of build directory"
	@echo "  make help      - Show this help message"

.PHONY: all quick view clean cleanall final watch wordcount check show-build help