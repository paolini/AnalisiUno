out=README.md

echo "writing file" ${out}

cat <<EOF > ${out}
Questo repository contiene gli appunti del
corso di Analisi Matematica tenuto da me (emanuele.paolini@gmail.com)
dal 2017-2018 per il corso di studi in Fisica dell'Università di Pisa.
EOF

grep "%% README" chapters/AnalisiUno-00*.tex | cut -f1 -d"%" >> ${out}

out=docs/index.html

echo "writing file" ${out}

cat <<EOF > ${out}
<html>
<!---- questo file e' stato creato automaticamente da make-docs.sh -- non modificarlo! ---->
<head>
<link rel="stylesheet" type="text/css" href="index.css">
<script type="text/x-mathjax-config">
MathJax.Hub.Config({
  tex2jax: {inlineMath: [['$','$'], ['\$\$','\$\$']]}
});
</script>
<script type="text/javascript" async
  src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.5/MathJax.js?config=TeX-MML-AM_CHTML">
</script>
<title>Emanuele Paolini: Analisi Matematica Uno</title>
</head>
<body>
<h1>Appunti di Analisi Matematica Uno</h1>
<p>
EOF

grep "%% README" chapters/AnalisiUno-00*.tex | cut -f1 -d"%" | sed "s/^ *$/<\/p><p>/g" >> ${out}

cat <<EOF >> ${out}
<h2>collegamenti utili</h2>
<ul>
  <li><a href="https://github.com/paolini/AnalisiUno">codice sorgente su GitHub</a></li>
  <li><a href="https://github.com/paolini/AnalisiUno/releases/latest">ultimo rilascio
  (da qui puoi scaricare il file PDF)</a></li>
  <li><a href="https://www.amazon.it/dp/1718794134/">compra il libro su amazon</a></li>
</ul>
<h2>diagrammi interattivi</h2>
<ul>
EOF

cat AnalisiUno.myaux | sed s/\\\\%/%/g >> ${out}

cat <<EOF >> ${out}
</ul>
EOF

cat <<EOF >> ${out}
</p>
</body>
EOF
