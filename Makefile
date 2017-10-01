%.pdf: %.tex
	pdflatex $(TEXOPT) $<
	pdflatex $(TEXOPT) $<

all: formula_area.pdf curve.pdf forme_differenziali.pdf sistemi_lineari.pdf logica.pdf ricorrenza.pdf derivata.pdf tychonov.pdf inversione.pdf studioqualitativo.pdf senodienne.pdf uniformecontinuita.pdf AnalisiSuperiore.pdf

clean:
	rm -fr *.aux *.log *.out *.toc

build_site: all
