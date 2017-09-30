%.pdf: %.tex
	pdflatex $(TEXOPT) $<
	pdflatex $(TEXOPT) $<

all: formula_area.pdf curve.pdf forme_differenziali.pdf sistemi_lineari.pdf logica.pdf ricorrenza.pdf derivata.pdf

clean:
		rm *.aux *.log *.out
