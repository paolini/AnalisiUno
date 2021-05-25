all: AnalisiUno.pdf README.md

README.md: make-docs.sh AnalisiUno.myaux
	bash $<

AnalisiUno.pdf AnalisiUno.myaux: AnalisiUno.tex chapters/*.tex figures/* code/* figures/figurePJAinside.tex figures/figurePJBinside.tex figures/figurePJAoutside.tex figures/figurePJBoutside.tex
	latexmk --pdf $<

strutture.pdf: strutture.gv
	dot -Tpdf $< -o $@

check_repeated_labels:
	grep 'label{.*}' -o chapters/*.tex | cut -f 2 -d{ | cut -f1 -d} | sort | uniq -d

clean:
	latexmk -C AnalisiUno.tex

build_site: all
