
# Opzioni di sicurezza e robustezza per bash
set -e          # termina lo script se un comando fallisce
set -u          # termina lo script se si usa una variabile non definita
set -o pipefail # termina lo script se un comando in una pipeline fallisce
set -o noclobber # previene la sovrascrittura accidentale dei file con >
# set -o nullglob # (decommenta se vuoi che i glob vuoti diventino stringa vuota)
# set -o nounset  # equivalente a -u, lasciato per chiarezza
# set -o errexit  # equivalente a -e, lasciato per chiarezza
# set -o noglob   # disabilita l'espansione dei glob (raramente utile)

out=README.md
INTRODUZIONE=chapters/00_introduzione.tex
# truncate
echo "writing file" ${out}
echo "[![DOI](https://zenodo.org/badge/105351342.svg)](https://doi.org/10.5281/zenodo.24164701)" >| ${out}
echo "" >> ${out}

# extracting documentation from latex source
grep "%% README" "${INTRODUZIONE}" | cut -f1 -d"%" | sed "s/\\\\emph{\\([^}]*\\)}/\\*\\1\\*/g" >> ${out}

# writing additional info for the repository
cat << EOF >> ${out} 
# release

Releases (PDF format) are available at the github repository: <https://github.com/paolini/AnalisiUno/tags>

# compiling 

file \`README.md\` is created from sources with the command:

    bash make-docs.sh

the \`pdf\` file can be obtained with the command:

    latexmk --pdf AnalisiUno

The \`Makefile\` should automate the previous commands.
The HTML version (published at <https://paolini.github.io/AnalisiUno/>) is built with \`make html\`.

# compilation with docker

    docker run -it -w /app -v "\${PWD}:/app" ghcr.io/xu-cheng/texlive-full latexmk --pdf AnalisiUno -file-line-error -halt-on-error -interaction=nonstopmode

EOF
