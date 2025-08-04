# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a UC Berkeley PhD thesis in LaTeX titled "Machine Learning Methods for Cross Section Measurements" by Krish Desai. The thesis focuses on applying machine learning techniques to particle physics unfolding problems.

## Build Commands

### Primary Build Commands
- `make all` - Full compilation with bibliography (runs pdflatex 3x + biber)
- `make quick` - Quick compile without bibliography (single pdflatex pass)
- `make view` - Compile and open PDF in default viewer
- `make watch` - Continuous compilation on file changes
- `make final` - Create final version (removes draft mode)

### Maintenance Commands
- `make clean` - Remove auxiliary files (.aux, .log, .bbl, etc.)
- `make cleanall` - Remove all generated files including PDF
- `make check` - Check for LaTeX issues (undefined refs, overfull hboxes, missing citations)

## Project Structure

```
main.tex              # Main document - includes all chapters/appendices
thesis-preamble.tex   # Package imports and custom command definitions
references.bib        # Bibliography (588KB, extensive physics/ML references)
chapters/             # 9 main chapters covering ML unfolding methods
appendices/           # 3 appendices (math proofs, implementation, results)
figures/              # Organized by chapter (chapter-01/ through chapter-09/)
tables/               # Table data files
build/                # Compilation output directory
```

## Key Custom Commands

The thesis defines editorial commands in thesis-preamble.tex:
- `\kd{text}` - Krish's editorial notes (shown in blue in draft mode)
- `\bn{text}` - Ben's editorial notes (shown in red in draft mode)

These are automatically hidden in final mode.

## Development Workflow

1. **For content changes**: Edit relevant .tex files in chapters/, appendices/, or root directory
2. **For quick preview**: Use `make quick` (faster, but won't update bibliography)
3. **For full compilation**: Use `make all` (needed when citations/references change)
4. **For continuous work**: Use `make watch` in a terminal to auto-recompile on saves

## Technical Details

- **Document Class**: `ucbthesis.cls` - UC Berkeley thesis formatting
- **Compiler**: pdflatex with Biber for bibliography
- **Key Packages**: TikZ (diagrams), algorithm2e (algorithms), listings (code), extensive math packages
- **Platform**: Optimized for macOS (uses `open` for PDF viewing)

## Common Tasks

### Adding a New Figure
1. Place figure in `figures/chapter-XX/` directory
2. Reference using `\includegraphics{figures/chapter-XX/filename}`
3. The build system handles path resolution automatically

### Checking for Issues
Run `make check` to find:
- Undefined references
- Missing citations  
- Overfull hboxes
- Editorial notes that need resolution

### Creating Final Version
1. Resolve all editorial notes (`\kd` and `\bn` commands)
2. Run `make final` to compile without draft mode
3. Run `make check` to ensure no issues remain