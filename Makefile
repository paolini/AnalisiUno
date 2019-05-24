all: AnalisiUno.pdf

AnalisiUno.pdf: AnalisiUno.tex chapters/*.tex_ figures/* code/*
	lockfile-create $<
	rubber --force --pdf --short $<
	lockfile-remove $<

strutture.pdf: strutture.gv
	dot -Tpdf $< -o $@


clean:
	rm -fr *.aux *.log *.out *.toc

build_site: all
