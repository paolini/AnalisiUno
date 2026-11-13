all: ita en

ita: AnalisiUnoFonts.pdf AnalisiUno.pdf README.md

en: AnalisiUnoEn.pdf

README.md: make-docs.sh AnalisiUno.myaux
	bash $<

AnalisiUnoFonts.pdf: AnalisiUno.pdf
	gs -o AnalisiUnoFonts.pdf -sDEVICE=pdfwrite -dEmbedAllFonts=true AnalisiUno.pdf

AnalisiUno.pdf AnalisiUno.myaux: AnalisiUno.tex *.tex chapters/*.tex chapters/*/*.tex figures/* code/* figures/figurePJAinside.tex figures/figurePJBinside.tex figures/figurePJAoutside.tex figures/figurePJBoutside.tex
	latexmk -pdf -file-line-error -halt-on-error -interaction=nonstopmode $<

AnalisiUnoEn.pdf AnalisiUnoEn.myaux: AnalisiUnoEn.tex *.tex chapters/*.tex chapters/*/*.tex figures/* code/* figures/figurePJAinside.tex figures/figurePJBinside.tex figures/figurePJAoutside.tex figures/figurePJBoutside.tex
	latexmk -pdf -file-line-error -halt-on-error -interaction=nonstopmode $<

Fondamenti.pdf::
	latexmk -pdf Fondamenti.tex

strutture.pdf: strutture.gv
	dot -Tpdf $< -o $@

check_repeated_labels:
	grep 'label{.*}' -o chapters/*.tex | cut -f 2 -d{ | cut -f1 -d} | sort | uniq -d

clean:
	latexmk -C AnalisiUno.tex
	@rm *.mw

# versione HTML (make4ht, vedi html/AnalisiUnoHtml.tex), output in html/out/
.PHONY: html html-plastex
HTML_BUILD = html/build
HTML_OUT = html/out
FIG_SVG = $(patsubst %.pdf,%.svg,$(wildcard figures/*.pdf))
html: html/mathjax-config.js $(FIG_SVG)
	rm -rf $(HTML_OUT)
	mkdir -p $(HTML_BUILD) $(HTML_OUT)
	cp html/style.css $(HTML_BUILD)/
	make4ht -B $(HTML_BUILD) -d $(HTML_OUT) -c html/config.cfg -e html/build.lua \
		-f html5+common_domfilters html/AnalisiUnoHtml.tex "3"
	cp html/mathjax-config.js $(HTML_OUT)/
	python3 html/postprocess.py $(HTML_BUILD)/AnalisiUnoHtml.aux $(HTML_OUT)

figures/%.svg: figures/%.pdf
	pdftocairo -svg $< $@

html/mathjax-config.js: html/mathjax_macros.py AnalisiUno-custom.tex
	python3 $< AnalisiUno-custom.tex $@

# vecchio esperimento con plasTeX
# devi scaricare il renderer MathJax e installarlo:
# sudo mv MathJax MathJaxS5 /usr/local/lib/python3.8/dist-packages/
html-plastex:
	plastex --renderer=MathJax --imager gspdfpng --split-level=1 PlasTex.tex

build_site: all
