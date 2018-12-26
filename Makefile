DEPENDS=*.tex_ *.png koch.*

%.pdf: %.tex $(DEPENDS)
	rubber -f --pdf -s $<

strutture.pdf: strutture.gv
	dot -Tpdf $< -o $@

all: AnalisiUno.pdf

clean:
	rm -fr *.aux *.log *.out *.toc

build_site: all
