all: AnalisiUno.pdf README.md

README.md: make-docs.sh AnalisiUno.myaux
	bash $<

AnalisiUno.pdf AnalisiUno.myaux: AnalisiUno.tex chapters/*.tex figures/* code/* figurePJAinside.tex figurePJBinside.tex figurePJAoutside.tex figurePJBoutside.tex
	lockfile-create --retry 2 $<
	rubber --force --pdf --short $<; lockfile-remove $<

strutture.pdf: strutture.gv
	dot -Tpdf $< -o $@

figurePJA.pdf: figurePJ_standalone.tex figurePJ.tex
	pdflatex "\\def\\figurePJA{1} \\input{$<}"
	mv figurePJ_standalone.pdf $@

figurePJA.tif: figurePJA.pdf
	pdftoppm $< figurePJA -tiff -singlefile -mono

figurePJB.pdf: figurePJ_standalone.tex figurePJ.tex
	pdflatex "\\def\\figurePJB{1} \\input{$<}"
	mv figurePJ_standalone.pdf $@

figurePJB.tif: figurePJB.pdf
	pdftoppm $< figurePJB -tiff -singlefile -mono

figurePJAinside.tex: polyrectangle.py figurePJA.tif
	python $^ inside 61 50 > $@

figurePJBinside.tex: polyrectangle.py figurePJB.tif
	python $^ inside 57 49 > $@

figurePJAoutside.tex: polyrectangle.py figurePJA.tif
	python $^ outside 61 50 > $@

figurePJBoutside.tex: polyrectangle.py figurePJB.tif
	python $^ outside 57 49 > $@

clean:
	rubber --clean AnalisiUno

build_site: all
