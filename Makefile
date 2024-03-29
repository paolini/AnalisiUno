all: AnalisiUnoFonts.pdf AnalisiUno.pdf README.md

README.md: make-docs.sh AnalisiUno.myaux
	bash $<

AnalisiUnoFonts.pdf: AnalisiUno.pdf
	gs -o AnalisiUnoFonts.pdf -sDEVICE=pdfwrite -dEmbedAllFonts=true AnalisiUno.pdf

AnalisiUno.pdf AnalisiUno.myaux: AnalisiUno.tex chapters/*.tex figures/* code/* figures/figurePJAinside.tex figures/figurePJBinside.tex figures/figurePJAoutside.tex figures/figurePJBoutside.tex
	latexmk -pdf -file-line-error -halt-on-error -interaction=nonstopmode $<

strutture.pdf: strutture.gv
	dot -Tpdf $< -o $@

check_repeated_labels:
	grep 'label{.*}' -o chapters/*.tex | cut -f 2 -d{ | cut -f1 -d} | sort | uniq -d

clean:
	latexmk -C AnalisiUno.tex
	@rm *.mw

# devi scaricare il renderer MathJax e installarlo:
# sudo mv MathJax MathJaxS5 /usr/local/lib/python3.8/dist-packages/
html:
	plastex --renderer=MathJax --imager gspdfpng --split-level=1 PlasTex.tex
#	plastex --renderer=MathJax --imager=gspdfpng PlasTex.tex

build_site: all
