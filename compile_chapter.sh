#!/bin/bash
# Compile individual chapter PDFs
# Usage: ./compile_chapter.sh chapter1

CHAPTER=$1
CHAPTER_DIR="chapters/${CHAPTER}"
CHAPTER_FILE="${CHAPTER_DIR}/${CHAPTER}.tex"
TEMP_WRAPPER="${CHAPTER_DIR}/${CHAPTER}_temp.tex"
PDF_OUTPUT="${CHAPTER_DIR}/${CHAPTER}.pdf"

if [ ! -f "$CHAPTER_FILE" ]; then
    echo "Error: Chapter file $CHAPTER_FILE not found"
    exit 1
fi

echo "Compiling ${CHAPTER}..."

# Create temporary wrapper
cat > "$TEMP_WRAPPER" <<EOF
\documentclass{../../phdthesis}
\usepackage{lipsum}
\usepackage{algorithm}
\usepackage{algorithmic}
\usepackage{booktabs}
\usepackage{multirow}
\usepackage{array}

\graphicspath{{fig/}}

\begin{document}
\input{${CHAPTER}.tex}

\bibliographystyle{IEEEtran}
\bibliography{../../bibliography}

\end{document}
EOF

# Compile
cd "$CHAPTER_DIR"
pdflatex -interaction=nonstopmode ${CHAPTER}_temp.tex > /dev/null
bibtex ${CHAPTER}_temp > /dev/null 2>&1
pdflatex -interaction=nonstopmode ${CHAPTER}_temp.tex > /dev/null
pdflatex -interaction=nonstopmode ${CHAPTER}_temp.tex > /dev/null 2>&1

# Rename output
if [ -f "${CHAPTER}_temp.pdf" ]; then
    mv ${CHAPTER}_temp.pdf ${CHAPTER}.pdf
    echo "✓ Created: ${PDF_OUTPUT}"
else
    echo "✗ Failed to compile ${CHAPTER}"
fi

# Clean up temporary files
rm -f ${CHAPTER}_temp.* 

cd - > /dev/null
