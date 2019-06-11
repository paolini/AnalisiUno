out=README.md

echo "writing file" ${out}

cat <<EOF > ${out}
Questo repository contiene gli appunti del
corso di Analisi Matematica tenuto da me (emanuele.paolini@gmail.com)
dal 2017-2018 per il corso di studi in Fisica dell'Università di Pisa.
EOF

grep "%% README" chapters/AnalisiUno-00*.tex | cut -f1 -d"%" | sed "s/\\\\emph{\\([^}]*\\)}/\\*\\1\\*/g" >> ${out}

out=docs/index.html

echo "writing file" ${out}

cat <<EOF > ${out}
<html>
<!-- questo file e' stato creato automaticamente da make-docs.sh. non modificarlo! -->
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
<p>di <a href='http://pagine.dm.unipi.it/paolini'>Emanuele Paolini</a>
<p id="redirect"></p>
<script>
  var urls = {
    'fibonacci': "http://paolini.github.io/recurrence/#expr=1%2B1%2Fx&a=1.0000&r=4.000&x=2.000&y=1.700",
    'ex3': "http://paolini.github.io/recurrence/#expr=1%2Bx*x&a=0.0000&r=20.000&x=0.000&y=9.000",
    'ex4': "http://paolini.github.io/recurrence/#expr=4-1%2Fx&a=1.0000&r=8.000&x=1.500&y=2.100",
    'ex5': "http://paolini.github.io/recurrence/#expr=1-1%2Fx&a=0.5000&r=8.000&x=0.000&y=0.000",
    'ex6': "http://paolini.github.io/recurrence/#expr=(5-x*x)%2F4&a=0.0000&r=2.400&x=1.000&y=0.800",
    'ex7': "http://paolini.github.io/recurrence/#expr=2-x*x&a=-1.1000&r=4.000&x=0.000&y=0.000",
    'ex8': "http://paolini.github.io/recurrence/#expr=1%2F(2-x)&a=1.3000&r=6.600&x=2.000&y=1.400",
    '43856': "http://paolini.github.io/recurrence/ode.html#r=5&x=0&y=0&points=0_0_0_0.5_0_1_0_1.5_0_2_0_-0.5_0_-1_0_-1.5_0_-2_2_0_2.5_0_3_0_3.5_0_4_0_1.8_0_-1.75_0_-2_0_-2.5_0_-3_0_-3.5_0_-4_0&f=x*y%5E2%2Bx",
    '94467': "http://paolini.github.io/recurrence/ode.html#r=7&x=3.3&y=0.2&points=0.4_-0.03_0.7_0.05_0.9_-0.05_1.25_0.05_1.6_-0.06_1.8_0.06_2_-0.05_2.4_0.05_2.6_-0.03_2.9_0.03_3.3_-0.04_3.6_0.05_3.9_-0.03_4.2_0.02_4.4_-0.04_4.7_0.05_5.1_-0.05_5.3_0.05_5.7_-0.06_5.95_0.09_6.31_-0.1_6.5_0.07_7_-0.07_7.3_0.07_7.7_-0.05_8_0.06_8.4_-0.07_8.7_0.03_9.1_-0.06_9.4_0.07_9.8_-0.06_9.9_0.08_0.1_0.02&f=abs(y)%5E(4%2F3)%2Fy",
    'series': "https://github.com/paolini/AnalisiUno/blob/master/code/series.py",
    'bisection': "https://github.com/paolini/AnalisiUno/blob/master/code/bisection.py",
    'computee': "https://github.com/paolini/AnalisiUno/blob/master/code/compute_e.py",
    'Mandelbrot': "https://github.com/paolini/AnalisiUno/blob/master/code/Mandelbrot.py",
    'computepi': "https://github.com/paolini/AnalisiUno/blob/master/code/compute_pi.py",
    'Koch': "https://github.com/paolini/AnalisiUno/blob/master/code/Koch.py",
    'Fourier': "https://github.com/paolini/AnalisiUno/blob/master/code/Fourier.py",
    'logica': "http://pagine.dm.unipi.it/paolini/didattica/appunti/logica.pdf"
  };

  var id = window.location.search.substring(1);
  if (id) {
    var url = urls[id];

    if (url) {
      window.location.href = url;
    } else {
      html = "<p>Rimando alla pagina '" + id + "' sconosciuto.\n"
      html += "Puoi <a href="mailto:emanuele.paolini@gmail.com">segnalarmi il problema</a>.\n"
      html += "Di seguito un elenco dei rimandi disponibili.</p>\n"
      html += "<ul>\n"
      for (var key in urls) {
        html += "<li><a href='" + urls[key] +"'>" + key + "</a></li>\n";
      }
      html += "</ul>\n"
      document.getElementById("redirect").innerHTML = html;
    }
  }
</script>
<p>
EOF

grep "%% README" chapters/AnalisiUno-00*.tex \
  | cut -f1 -d"%" \
  | sed "s/^ *$/<\/p><p>/g" \
  | sed "s/\\\\emph{\\([^}]*\\)}/<i>\\1<\\/i>/g" \
  >> ${out}

cat <<EOF >> ${out}
<h2>collegamenti utili</h2>
<ul>
  <li><a href="https://github.com/paolini/AnalisiUno">codice sorgente su GitHub</a></li>
  <li><a href="https://github.com/paolini/AnalisiUno/releases/latest">ultimo rilascio
  (da qui puoi scaricare il file PDF)</a></li>
  <li><a href="https://www.amazon.it/dp/1718794134/">ordina il libro su amazon</a></li>
</ul>
<h2>riferimenti presenti nel testo</h2>
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
