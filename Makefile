DEPENDS=*.tex_ *.png koch.*

%.pdf: %.tex $(DEPENDS)
	rubber -f --pdf -s $<

Fondamenti.pdf: Fondamenti.tex
	rubber -f --pdf -s $<

all: Fondamenti.pdf

clean:
	rm -fr *.aux *.log *.out *.toc

build_site: all
