%.pdf: %.tex
	pdflatex $(TEXOPT) $<
	pdflatex $(TEXOPT) $<

all: formula_area.pdf curve.pdf forme_differenziali.pdf sistemi_lineari.pdf logica.pdf ricorrenza.pdf derivata.pdf tychonov.pdf inversione.pdf studioqualitativo.pdf senodienne.pdf uniformecontinuita.pdf

clean:
		rm -fr *.aux *.log *.out

build_site: all
