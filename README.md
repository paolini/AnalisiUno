
# compiling 

files `README.md` and `docs/index.html` are created from sources with the command:

    bash make-docs.sh

the `pdf` file can be obtained with the command:

    latexmk --pdf AnalisiUno

The `Makefile` should automate the previous commands.

# compilation with docker

    docker run -it -w /app -v "${PWD}:/app" ghcr.io/xu-cheng/texlive-full latexmk --pdf AnalisiUno -file-line-error -halt-on-error -interaction=nonstopmode

