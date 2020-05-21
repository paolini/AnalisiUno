all: figurePJAinside.tex figurePJBinside.tex figurePJAoutside.tex figurePJBoutside.tex

figurePJA.pdf: figurePJ_standalone.tex figurePJ.tex
	pdflatex "\\def\\figurePJA{1} \\input{$<}"
	mv figurePJ_standalone.pdf $@

figurePJA.tif: figurePJA.pdf
	pdftoppm $< figurePJA -r 600 -tiff -singlefile -mono

figurePJB.pdf: figurePJ_standalone.tex figurePJ.tex
	pdflatex "\\def\\figurePJB{1} \\input{$<}"
	mv figurePJ_standalone.pdf $@

figurePJB.tif: figurePJB.pdf
	pdftoppm $< figurePJB -r 600 -tiff -singlefile -mono

figurePJAinside.tex: polyrectangle.py figurePJA.tif
	python $^ inside 61 50 > $@

figurePJBinside.tex: polyrectangle.py figurePJB.tif
	python $^ inside 57 49 > $@

figurePJAoutside.tex: polyrectangle.py figurePJA.tif
	python $^ outside 61 50 > $@

figurePJBoutside.tex: polyrectangle.py figurePJB.tif
	python $^ outside 57 49 > $@
