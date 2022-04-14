FROM ghcr.io/xu-cheng/texlive-full:latest
WORKDIR /analisi
COPY AnalisiUno.tex AnalisiUno-custom.tex mykaobook.cls mykao.sty ./
COPY chapters/*.tex chapters/
COPY figures/* figures/
COPY code/* code/
RUN latexmk -pdf -file-line-error -halt-on-error -interaction=nonstopmode AnalisiUno
