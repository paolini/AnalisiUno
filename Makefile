all: AnalisiUno.pdf README.md

README.md: make-docs.sh AnalisiUno.myaux
	bash $<

AnalisiUno.pdf AnalisiUno.myaux: AnalisiUno.tex chapters/*.tex figures/* code/*
	lockfile-create --retry 2 $<
	rubber --force --pdf --short $<; lockfile-remove $<

strutture.pdf: strutture.gv
	dot -Tpdf $< -o $@

clean:
	rubber --clean AnalisiUno

build_site: all
