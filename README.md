# PhD Thesis LaTeX Template

This repository contains a custom dissertation template centered on `phdthesis.cls` and `overall_thesis.tex`.

## Current Build Commands

### Build full thesis (fast)
```bash
make
```

### Build full thesis with bibliography
```bash
make bib
```

### Build one chapter PDF
```bash
make chapter1
make chapter2
# ...
make chapter7
```

### Build all chapter PDFs
```bash
make chapters
```

### Clean auxiliary files
```bash
make clean
```

## Current Project Structure

- `overall_thesis.tex`: main thesis entry point
- `phdthesis.cls`: thesis class definition
- `bibliography.bib`: bibliography database
- `Makefile`: build targets (`make`, `make bib`, chapter builds)
- `compile_chapter.sh`: helper script used by chapter build targets
- `front_matter/`: abstract, nomenclature, acknowledgments, dedication
- `chapters/chapter1/` to `chapters/chapter7/`: chapter sources and optional `fig/` folders

## Thesis Composition in Current Main File

`overall_thesis.tex` currently includes:

- Front matter:
  - `\include{front_matter/abstract}`
  - `\tableofcontents`
  - `\listoftables`
  - `\include{front_matter/nomenclature}`
- Main matter:
  - `\part{Foundations}` with chapters 1-3
  - `\part{Applications}` with chapters 4-7
- Back matter:
  - `\bibliographystyle{plainnat}`
  - `\bibliography{bibliography}`
  - `\include{front_matter/acknowledgments}`
  - `\include{front_matter/dedication}`
  - `vita` and `achievements` environments

## Notes About Optional Content

- Appendix chapter targets are optional in `Makefile`.
- If `chapters/appendixA/appendixA.tex` or `chapters/appendixB/appendixB.tex` do not exist, they are skipped and do not fail `make bib`.

## Bibliography Notes

- The repository currently builds bibliography with `plainnat` in `overall_thesis.tex`.
- If you want IEEE output later, change the style in `overall_thesis.tex` to an installed IEEE `.bst` and rebuild.

## PDF Tracking Notes

- Generated PDFs can be tracked with `git add -f` when ignored by `.gitignore`.
- Example:
  - `git add -f overall_thesis.pdf chapters/chapter*/chapter*.pdf`

## Minimal Author Workflow

1. Edit front matter and chapter `.tex` files.
2. Run `make bib`.
3. Review `overall_thesis.pdf`.
4. Stage any files you want tracked.
