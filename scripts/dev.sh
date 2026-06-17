#!/usr/bin/env bash
# dev.sh - outil de generation de la presentation
#
# Usage (apres `. activate`) :
#   dev.sh gen      - genere dist/presentation.pdf
#   dev.sh clean    - vide workdir/
#   dev.sh --help   - affiche ce message
#
# Stack (ADR-001) : texlua + LuaLaTeX + Beamer + metropolis. Ni Python ni pandoc.
# Variable attendue : PRESENTATION_ROOT (positionnee par `. activate`)

set -euo pipefail

ROOT="${PRESENTATION_ROOT:-$(cd "$(dirname "$0")/.." && pwd)}"
SLIDES_SRC="$ROOT/.dev/artefacts/presentation"
TEMPLATES="$ROOT/templates"
WORKDIR="$ROOT/workdir"
DIST="$ROOT/dist"
WORKDIR_TEX="$WORKDIR/tex"
WORKDIR_ASSETS="$WORKDIR/assets"

usage() {
    grep '^#' "$0" | sed 's/^# //' | sed 's/^#//'
    exit 0
}

clean() {
    rm -rf "$WORKDIR/tex" "$WORKDIR/assets" \
           "$WORKDIR"/main.tex "$WORKDIR"/main.pdf \
           "$WORKDIR"/*.aux "$WORKDIR"/*.log \
           "$WORKDIR"/*.nav "$WORKDIR"/*.snm \
           "$WORKDIR"/*.toc "$WORKDIR"/*.out \
           "$WORKDIR"/*.fdb_latexmk "$WORKDIR"/*.fls \
           "$WORKDIR"/build.log 2>/dev/null || true
    echo "[OK] workdir nettoye"
}

gen() {
    mkdir -p "$WORKDIR_TEX" "$WORKDIR_ASSETS" "$DIST"

    # Copier le theme dans workdir/ pour que lualatex le trouve
    cp "$TEMPLATES/theme/"*.sty "$WORKDIR/"

    # Rendre chaque slide avec texlua
    local slide_tex_files=()
    for slide_dir in "$SLIDES_SRC"/slide-*/; do
        local content_md="$slide_dir/content.md"
        [ -f "$content_md" ] || continue
        local name; name=$(basename "$slide_dir")
        local out="$WORKDIR_TEX/${name}.tex"
        texlua "$ROOT/scripts/render_slide.lua" \
            "$content_md" \
            "$ROOT/config.yaml" \
            "$out" \
            "$TEMPLATES" \
            "$WORKDIR_ASSETS"
        slide_tex_files+=("$out")
    done

    if [ ${#slide_tex_files[@]} -eq 0 ]; then
        echo "[ERREUR] Aucun content.md trouve dans $SLIDES_SRC/slide-*/" >&2
        exit 1
    fi

    # Generer workdir/main.tex (preamble + inputs des slides)
    local main_tex="$WORKDIR/main.tex"
    {
        cat "$TEMPLATES/preamble.tex"
        echo '\begin{document}'
        for f in "${slide_tex_files[@]}"; do
            echo "\\input{$f}"
        done
        echo '\end{document}'
    } > "$main_tex"

    # Compiler avec lualatex (2 passes pour les refs croisees Beamer)
    # latexmk prefere si disponible (gere biber, overlays, etc.)
    if command -v latexmk >/dev/null 2>&1; then
        latexmk -lualatex -outdir="$WORKDIR" -interaction=nonstopmode "$main_tex" \
            > "$WORKDIR/build.log" 2>&1
    else
        lualatex -interaction=nonstopmode -output-directory="$WORKDIR" "$main_tex" \
            > "$WORKDIR/build.log" 2>&1
        lualatex -interaction=nonstopmode -output-directory="$WORKDIR" "$main_tex" \
            >> "$WORKDIR/build.log" 2>&1
    fi

    if [ -f "$WORKDIR/main.pdf" ]; then
        cp "$WORKDIR/main.pdf" "$DIST/presentation.pdf"
        echo "[OK] dist/presentation.pdf genere"
    else
        echo "[ERREUR] Compilation LuaLaTeX echouee - voir workdir/build.log" >&2
        tail -40 "$WORKDIR/build.log" >&2
        exit 1
    fi
}

case "${1:-}" in
    gen)    gen ;;
    clean)  clean ;;
    --help) usage ;;
    "")     usage ;;
    *)      echo "[ERREUR] Commande inconnue : $1" >&2; usage ;;
esac
