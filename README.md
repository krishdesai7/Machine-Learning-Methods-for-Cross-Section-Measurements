# Machine Learning Methods for Cross Section Measurements

**PhD Dissertation** — University of California, Berkeley  
**Author:** Krish Desai  
**Degree:** Doctor of Philosophy in Physics  
**Expected:** Summer 2025  

**Dissertation Committee**  
- **Co-advisors:** Professor Benjamin Nachman, Professor Uros Seljak  
- **Committee Members:** Professor Joshua Bloom, Professor Saul Perlmutter  

---

## Abstract

This dissertation develops a unified framework leveraging modern machine learning techniques to solve the *unfolding problem* in particle physics — the ill-posed inverse problem of extracting particle-level truth distributions from detector-level measurements.

Four original contributions are presented:

- **Neural Posterior Unfolding (NPU):** Uses conditional normalizing flows as differentiable detector response surrogates, enabling likelihood-based unfolding that replaces traditional point estimates with full posterior distributions for rigorous uncertainty quantification.

- **Moment Unfolding:** Abandons binning entirely and directly deconvolves distribution moments, providing precise experimental predictions well-suited for effective field theories and phenomenological models.

- **Reweighting Adversarial Networks (RAN):** Performs full spectral unfolding using adversarial training to implement particle-level reweighting guided by a detector-level classifier, offering theoretical and computational advantages over histogram-based methods.

- **Unbinned Inference on Correlated Data:** A critical examination of event correlations in unfolded data, revealing systematic misestimation of uncertainties when correlations are ignored, with methodological recommendations to ensure correct coverage for derived observables.

Methods are validated on Gaussian toy models and realistic CMS proton-proton collision simulations (Z+jets events), demonstrating improvements in precision, accuracy, and computational efficiency while maintaining compatibility with established approaches.

---

## Chapters

| Chapter | Title |
|---------|-------|
| 1 | Introduction — units and conventions, statistical foundations, the Standard Model, and the role of cross section measurements |
| 2 | Theoretical Foundations — the forward problem, detector response, and the ill-posed inverse unfolding problem |
| 3 | Machine Learning for Unfolding — emergence of ML in HEP, paradigm shifts, and a survey of existing approaches |
| 4 | Neural Posterior Unfolding (NPU) — normalizing flows as differentiable response surrogates for posterior binned unfolding |
| 5 | Moment Unfolding — direct deconvolution of distribution moments without binning |
| 6 | Reweighting Adversarial Networks (RAN) — full spectral adversarial unfolding beyond binned spectra |
| 7 | Unbinned Inference on Correlated Data — statistical treatment of correlations induced by unfolding |
| 8 | Towards Robust Unfolding with Nuisance Parameters *(in progress — not included in current build)* |
| 9 | SymmetryGAN — connection between symmetry discovery and unfolding |
| 10 | Synthesis and Comparative Analysis *(in progress — not included in current build)* |
| 11 | Conclusions |

---

## Repository Structure

```
.
├── main.tex                    # Root LaTeX document
├── main.pdf                    # Compiled dissertation PDF
├── abstract.tex                # Abstract
├── acknowledgements.tex        # Acknowledgements
├── thesis-preamble.tex         # Package imports and custom commands
├── ucbthesis.cls               # UC Berkeley thesis document class
├── references.bib              # Bibliography (~588 KB, extensive HEP/ML references)
├── CITATION.cff                # Machine-readable citation metadata
├── CITATION.bib                # BibTeX citation entry
├── Makefile                    # Build system
├── chapters/                   # One .tex file per chapter
├── appendices/                 # Appendix .tex files
├── figures/                    # Figures organized by chapter (chapter-01/, chapter-02/, ...)
├── tables/                     # Table data files
├── extract_definitions.py      # Utility: extract definitions from LaTeX source
├── extract_theorems_proofs.py  # Utility: extract theorems and proofs
└── reference_analysis.py       # Utility: analyze bibliography
```

---

## Building the Dissertation

### Prerequisites

- **pdflatex** (TeX Live or MiKTeX recommended)
- **Biber** (bibliography processor)
- **latexmk** (optional, used by `watch` target)

### Build Commands

| Command | Description |
|---------|-------------|
| `make all` | Full compilation with bibliography (runs pdflatex × 3 + Biber) |
| `make quick` | Single pdflatex pass — fast preview without bibliography updates |
| `make view` | Compile and open the PDF (macOS) |
| `make watch` | Continuous compilation whenever source files change |
| `make final` | Create a final version with draft mode disabled |
| `make clean` | Remove auxiliary files (keeps PDF) |
| `make cleanall` | Remove all generated files including the PDF |
| `make check` | Scan for undefined references, missing citations, overfull hboxes, and unresolved editorial marks |

**Recommended workflow:**

```bash
# First build (resolves all cross-references and bibliography)
make all

# Subsequent content edits (faster iteration)
make quick

# Before submission
make check
make final
```

Output is placed in the `build/` directory and copied to the repository root as `main.pdf`.

---

## Custom Editorial Commands

Defined in `thesis-preamble.tex` and automatically hidden in final mode:

| Command | Author | Color |
|---------|--------|-------|
| `\kd{text}` | Krish Desai | Blue |
| `\bn{text}` | Benjamin Nachman | Red |

---

## Citation

If you use material from this dissertation, please cite:

```bibtex
@thesis{desai2025phd,
  author      = {Desai, Krish},
  title       = {Machine Learning Methods for Cross Section Measurements},
  type        = {PhD dissertation},
  institution = {University of California, Berkeley},
  date        = {2025-08-15},
  supervisor  = {Nachman, Benjamin and Seljak, Uro{\v s}},
  keywords    = {Cross sections, Deconvolution, High energy physics, Machine learning, Particle physics, Unfolding},
  url         = {https://www.proquest.com/dissertations-theses/machine-learning-methods-cross-section/docview/3256604408/se-2}
}
```

A machine-readable `CITATION.cff` is also included for use with GitHub's *Cite this repository* feature.

---

## Keywords

machine learning · particle physics · unfolding · deconvolution · cross sections ·  
normalizing flows · adversarial networks · high-energy physics · LHC · CMS
