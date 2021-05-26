out=README.md

echo "writing file" ${out}

# truncate
echo "" > ${out}

# extracting documentation from latex source
grep "%% README" chapters/AnalisiUno-00*.tex | cut -f1 -d"%" | sed "s/\\\\emph{\\([^}]*\\)}/\\*\\1\\*/g" >> ${out}

# writing additional info for the repository
cat <<EOF >> ${out}
# compiling 

files `README.md` and `docs/index.html` are create from sources with the command:

    bash make-docs.sh

the `pdf` file can be obtained with the command:

    latexmk --pdf AnalisiUno

The `Makefile` should automate the previous commands.

# compilation with docker

    docker run -it -w /app -v "${PWD}:/app" ghcr.io/xu-cheng/texlive-full latexmk --pdf AnalisiUno -file-line-error -halt-on-error -interaction=nonstopmode

EOF

out=docs/index.html

echo "writing file" ${out}

cat <<EOF > ${out}
<html>
<!-- questo file e' stato creato automaticamente da make-docs.sh. non modificarlo! -->
<head>
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-VRBT3T3Q7E"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-VRBT3T3Q7E');
</script>
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
    'logica': "http://pagine.dm.unipi.it/paolini/didattica/appunti/logica.pdf",
    'figtrigo': "https://paolini.github.io/funplot/#q=%7B%22p%22%3A%7B%22x%22%3A0.6317763501997922%2C%22y%22%3A0.14774102772394218%2C%22r%22%3A6.954840642318821%7D%2C%22l%22%3A%5B%7B%22t%22%3A%22graph%22%2C%22e%22%3A%22tan(x)%22%2C%22c%22%3A%22%238B572A%22%7D%2C%7B%22t%22%3A%22graph%22%2C%22e%22%3A%22cos(x)%22%2C%22c%22%3A%22%230000FF%22%7D%2C%7B%22t%22%3A%22graph%22%2C%22e%22%3A%22sin(x)%22%2C%22c%22%3A%22%23417505%22%7D%2C%7B%22t%22%3A%22graph_inverted%22%2C%22e%22%3A%22pi%2F2%22%2C%22c%22%3A%22%23CED1CB%22%7D%2C%7B%22t%22%3A%22graph_inverted%22%2C%22e%22%3A%22-pi%2F2%22%2C%22c%22%3A%22%23CECFCB%22%7D%5D%7D",
    'figiperb': "https://paolini.github.io/funplot/#q=%7B%22p%22%3A%7B%22x%22%3A-0.05295440431163167%2C%22y%22%3A-0.3520883830793602%2C%22r%22%3A11.010098668753743%7D%2C%22l%22%3A%5B%7B%22t%22%3A%22graph%22%2C%22e%22%3A%221%22%2C%22c%22%3A%22%23D9D9D8%22%7D%2C%7B%22t%22%3A%22graph%22%2C%22e%22%3A%22-1%22%2C%22c%22%3A%22%23D3D3D3%22%7D%2C%7B%22t%22%3A%22graph%22%2C%22e%22%3A%22tanh(x)%22%2C%22c%22%3A%22%238B572A%22%7D%2C%7B%22t%22%3A%22graph%22%2C%22e%22%3A%22cosh(x)%22%2C%22c%22%3A%22%23020BFA%22%7D%2C%7B%22t%22%3A%22graph%22%2C%22e%22%3A%22sinh(x)%22%2C%22c%22%3A%22%23D0021B%22%7D%5D%7D",
    'sistemi_sella': "https://paolini.github.io/funplot/#q=%7B%22p%22%3A%7B%22x%22%3A0.015%2C%22y%22%3A-0.14%2C%22r%22%3A2.77%7D%2C%22l%22%3A%5B%7B%22t%22%3A%22ode_system%22%2C%22ex%22%3A%22%20y%22%2C%22ey%22%3A%22y%20%2B%20x%22%2C%22c%22%3A%22%234A90E2%22%2C%22sc%22%3A%22%237ED321%22%2C%22ds%22%3Afalse%2C%22gp%22%3Atrue%2C%22l%22%3A%5B%5D%7D%5D%7D",
    'sistemi_fuoco': "https://paolini.github.io/funplot/#q=%7B%22p%22%3A%7B%22x%22%3A0.015%2C%22y%22%3A-0.14%2C%22r%22%3A2.77%7D%2C%22l%22%3A%5B%7B%22t%22%3A%22ode_system%22%2C%22ex%22%3A%22%20y%22%2C%22ey%22%3A%22-x%20-y%22%2C%22c%22%3A%22%234A90E2%22%2C%22sc%22%3A%22%237ED321%22%2C%22ds%22%3Afalse%2C%22gp%22%3Atrue%2C%22l%22%3A%5B%5D%7D%5D%7D",
    'sistemi_nodo': "https://paolini.github.io/funplot/#q=%7B%22p%22%3A%7B%22x%22%3A0.015%2C%22y%22%3A-0.14113430003440713%2C%22r%22%3A2.775103135445589%7D%2C%22l%22%3A%5B%7B%22t%22%3A%22ode_system%22%2C%22ex%22%3A%22-2*x%2By%22%2C%22ey%22%3A%22-3*y%22%2C%22c%22%3A%22%234A90E2%22%2C%22sc%22%3A%22%237ED321%22%2C%22ds%22%3Afalse%2C%22gp%22%3Atrue%2C%22l%22%3A%5B%5D%7D%5D%7D",
    'sistemi_nodo_improprio': "https://paolini.github.io/funplot/#q=%7B%22p%22%3A%7B%22x%22%3A0.014%2C%22y%22%3A-0.16%2C%22r%22%3A2.92%7D%2C%22l%22%3A%5B%7B%22t%22%3A%22ode_system%22%2C%22ex%22%3A%22-x%2By%22%2C%22ey%22%3A%22-y%22%2C%22c%22%3A%22%234A90E2%22%2C%22sc%22%3A%22%237ED321%22%2C%22ds%22%3Afalse%2C%22gp%22%3Atrue%2C%22l%22%3A%5B%5D%7D%5D%7D",
    'sistemi_stella': "https://paolini.github.io/funplot/#q=%7B%22p%22%3A%7B%22x%22%3A0.015%2C%22y%22%3A-0.14%2C%22r%22%3A2.77%7D%2C%22l%22%3A%5B%7B%22t%22%3A%22ode_system%22%2C%22ex%22%3A%22-x%22%2C%22ey%22%3A%22-y%22%2C%22c%22%3A%22%234A90E2%22%2C%22sc%22%3A%22%237ED321%22%2C%22ds%22%3Afalse%2C%22gp%22%3Atrue%2C%22l%22%3A%5B%5D%7D%5D%7D",
    'sistemi_centro': "https://paolini.github.io/funplot/#q=%7B%22p%22%3A%7B%22x%22%3A0.015%2C%22y%22%3A-0.14%2C%22r%22%3A2.77%7D%2C%22l%22%3A%5B%7B%22t%22%3A%22ode_system%22%2C%22ex%22%3A%22-4*x%2B17*y%22%2C%22ey%22%3A%22-23*x%2B4*y%22%2C%22c%22%3A%22%234A90E2%22%2C%22sc%22%3A%22%237ED321%22%2C%22ds%22%3Afalse%2C%22gp%22%3Atrue%2C%22l%22%3A%5B%5D%7D%5D%7D",
    'edo_463': "https://paolini.github.io/funplot/#q=%7B%22p%22%3A%7B%22x%22%3A0.24976002087478472%2C%22y%22%3A-0.17819487847667634%2C%22r%22%3A6.456342057408671%7D%2C%22l%22%3A%5B%7B%22t%22%3A%22graph%22%2C%22e%22%3A%221%22%2C%22c%22%3A%22%23D0021B%22%7D%2C%7B%22t%22%3A%22graph%22%2C%22e%22%3A%22-1%22%2C%22c%22%3A%22%23D0021B%22%7D%2C%7B%22t%22%3A%22ode_equation%22%2C%22e%22%3A%22(1-y%5E2)x%20sin(x)%22%2C%22c%22%3A%22%23000000%22%2C%22sc%22%3A%22%237ED321%22%2C%22ds%22%3Afalse%2C%22gp%22%3Afalse%2C%22l%22%3A%5B%7B%22x%22%3A-5.283862230447393e-9%2C%22y%22%3A-3.1582453986645245e-8%7D%5D%7D%5D%7D",
    'darboux': "https://paolini.github.io/funplot/#q=%7B%22p%22%3A%7B%22x%22%3A0.03916255253926221%2C%22y%22%3A-0.02282969005983251%2C%22r%22%3A0.7408648288253102%7D%2C%22l%22%3A%5B%7B%22t%22%3A%22graph%22%2C%22e%22%3A%22x%5E2%22%2C%22c%22%3A%22%2366B906%22%7D%2C%7B%22t%22%3A%22graph%22%2C%22e%22%3A%22-x%5E2%22%2C%22c%22%3A%22%2361B105%22%7D%2C%7B%22t%22%3A%22graph%22%2C%22e%22%3A%22x%5E2*sin(1%2Fx)%22%2C%22c%22%3A%22%23000000%22%7D%5D%7D"
  };

  var id = window.location.search.substring(1);
  if (id) {
    var url = urls[id];

    if (url) {
      window.location.href = url;
    } else if (!id.includes("=")) {
      var html = "<p>Rimando alla pagina '" + id + "' sconosciuto.\n"
      html += "Puoi <a href='mailto:emanuele.paolini@gmail.com'>segnalarmi il problema</a>.\n"
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
  <li><a href="https://github.com/paolini/AnalisiUno">codice sorgente</a></li>
  <li><a href="https://github.com/paolini/AnalisiUno/releases/latest">ultimo rilascio
  (da qui puoi scaricare il file PDF)</a></li>
  <li><a href="https://www.amazon.it/dp/1718794134/">ordina una copia cartacea</a></li>
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
