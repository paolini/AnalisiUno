-- build file per make4ht
Make:htlatex {}
Make:add("bibtex", "cd ${builddir} && BIBINPUTS=../..: bibtex ${input}")
Make:bibtex {}
Make:makeindex {}
Make:htlatex {}
Make:htlatex {}
