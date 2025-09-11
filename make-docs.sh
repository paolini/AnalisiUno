
# Opzioni di sicurezza e robustezza per bash
set -e          # termina lo script se un comando fallisce
set -u          # termina lo script se si usa una variabile non definita
set -o pipefail # termina lo script se un comando in una pipeline fallisce
set -o noclobber # previene la sovrascrittura accidentale dei file con >
# set -o nullglob # (decommenta se vuoi che i glob vuoti diventino stringa vuota)
# set -o nounset  # equivalente a -u, lasciato per chiarezza
# set -o errexit  # equivalente a -e, lasciato per chiarezza
# set -o noglob   # disabilita l'espansione dei glob (raramente utile)

out=README.md
INTRODUZIONE=chapters/00_introduzione.tex
# truncate
echo "writing file" ${out}
echo "" >| ${out}

# extracting documentation from latex source
grep "%% README" "${INTRODUZIONE}" | cut -f1 -d"%" | sed "s/\\\\emph{\\([^}]*\\)}/\\*\\1\\*/g" >> ${out}

# writing additional info for the repository
cat << EOF >> ${out} 
# release

Releases (PDF format) are available at the github repository: <https://github.com/paolini/AnalisiUno/tags>

# compiling 

files \`README.md\` and \`docs/index.html\` are created from sources with the command:

    bash make-docs.sh

the \`pdf\` file can be obtained with the command:

    latexmk --pdf AnalisiUno

The \`Makefile\` should automate the previous commands.

# compilation with docker

    docker run -it -w /app -v "\${PWD}:/app" ghcr.io/xu-cheng/texlive-full latexmk --pdf AnalisiUno -file-line-error -halt-on-error -interaction=nonstopmode

EOF

out=docs/index.html

echo "writing file" ${out}

cat <<EOF >| ${out}
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

<!-- Matomo -->
<script>
  var _paq = window._paq = window._paq || [];
  /* tracker methods like "setCustomDimension" should be called before "trackPageView" */
  _paq.push(['trackPageView']);
  _paq.push(['enableLinkTracking']);
  (function() {
    var u="//matomo.matb.it/";
    _paq.push(['setTrackerUrl', u+'matomo.php']);
    _paq.push(['setSiteId', '5']);
    var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0];
    g.async=true; g.src=u+'matomo.js'; s.parentNode.insertBefore(g,s);
  })();
</script>
<!-- End Matomo Code -->

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
    'ex7b': "http://paolini.github.io/recurrence/#expr=4*x*(1-x)&a=0.2199&r=2.053&x=1.422&y=0.476",
    'ex8': "http://paolini.github.io/recurrence/#expr=1%2F(2-x)&a=1.3000&r=6.600&x=2.000&y=1.400",
    '43856': "https://paolini.github.io/funplot/#q=%7B%22p%22%3A%7B%22x%22%3A0.06254685170865516%2C%22y%22%3A-0.11758873413430246%2C%22r%22%3A7.348071607205723%7D%2C%22l%22%3A%5B%7B%22t%22%3A%22ode_equation%22%2C%22e%22%3A%22x*y%5E2%2Bx%22%2C%22c%22%3A%22%234A90E2%22%2C%22sc%22%3A%22%237ED321%22%2C%22ds%22%3Afalse%2C%22gp%22%3Atrue%2C%22l%22%3A%5B%5D%7D%5D%7D",
    '94467': "https://paolini.github.io/funplot/#q=%7B%22p%22%3A%7B%22x%22%3A0.06254685170865516%2C%22y%22%3A-0.11758873413430246%2C%22r%22%3A7.348071607205723%7D%2C%22l%22%3A%5B%7B%22t%22%3A%22ode_equation%22%2C%22e%22%3A%22y%20%2F%20abs(y)%5E(2%2F3)%22%2C%22c%22%3A%22%234A90E2%22%2C%22sc%22%3A%22%237ED321%22%2C%22ds%22%3Afalse%2C%22gp%22%3Afalse%2C%22l%22%3A%5B%7B%22x%22%3A0.19587884700344577%2C%22y%22%3A0.07071956130373995%7D%2C%7B%22x%22%3A0.30698884308243823%2C%22y%22%3A-0.010761102487521181%7D%2C%7B%22x%22%3A0.6403188313194156%2C%22y%22%3A0.04109022901600863%7D%2C%7B%22x%22%3A1.106980814851184%2C%22y%22%3A-0.02557576863138684%7D%2C%7B%22x%22%3A1.5736427983829522%2C%22y%22%3A0.06331222823180713%7D%2C%7B%22x%22%3A2.0477121149866533%2C%22y%22%3A-0.02557576863138684%7D%2C%7B%22x%22%3A2.5143740985184215%2C%22y%22%3A0.07071956130373995%7D%2C%7B%22x%22%3A2.9662214159063245%2C%22y%22%3A-0.010761102487521181%7D%2C%7B%22x%22%3A3.4032540671503613%2C%22y%22%3A0.12257089280726977%7D%2C%7B%22x%22%3A4.062506710552383%2C%22y%22%3A-0.062612433991051%7D%2C%7B%22x%22%3A4.44768803029289%2C%22y%22%3A0.07071956130373995%7D%2C%7B%22x%22%3A5.010645343759785%2C%22y%22%3A-0.032983101703319674%7D%2C%7B%22x%22%3A5.477307327291554%2C%22y%22%3A0.11516355973533693%7D%2C%7B%22x%22%3A5.936561977751389%2C%22y%22%3A-0.062612433991051%7D%2C%7B%22x%22%3A6.3810019620673595%2C%22y%22%3A0.11481634099759008%7D%2C%7B%22x%22%3A6.653907765564865%2C%22y%22%3A-0.04420689757925167%7D%5D%7D%5D%7D",    'series': "https://github.com/paolini/AnalisiUno/blob/master/code/series.py",
    'bisection': "https://github.com/paolini/AnalisiUno/blob/master/code/bisection.py",
    'napier': "https://github.com/paolini/AnalisiUno/blob/master/code/napier.py",
    'computee': "https://github.com/paolini/AnalisiUno/blob/master/code/compute_e.py",
    'Mandelbrot': "https://github.com/paolini/AnalisiUno/blob/master/code/Mandelbrot.py",
    'computepi': "https://github.com/paolini/AnalisiUno/blob/master/code/compute_pi.py",
    'Koch': "https://github.com/paolini/AnalisiUno/blob/master/code/Koch.py",
    'Fourier': "https://github.com/paolini/AnalisiUno/blob/master/code/Fourier.py",
    'logica': "http://pagine.dm.unipi.it/paolini/didattica/appunti/logica.pdf",
    'figtrigo': "https://paolini.github.io/funplot/#q=%7B%22p%22%3A%7B%22x%22%3A0.6317763501997922%2C%22y%22%3A0.14774102772394218%2C%22r%22%3A6.954840642318821%7D%2C%22l%22%3A%5B%7B%22t%22%3A%22graph%22%2C%22e%22%3A%22tan(x)%22%2C%22c%22%3A%22%238B572A%22%7D%2C%7B%22t%22%3A%22graph%22%2C%22e%22%3A%22cos(x)%22%2C%22c%22%3A%22%230000FF%22%7D%2C%7B%22t%22%3A%22graph%22%2C%22e%22%3A%22sin(x)%22%2C%22c%22%3A%22%23417505%22%7D%2C%7B%22t%22%3A%22graph_inverted%22%2C%22e%22%3A%22pi%2F2%22%2C%22c%22%3A%22%23CED1CB%22%7D%2C%7B%22t%22%3A%22graph_inverted%22%2C%22e%22%3A%22-pi%2F2%22%2C%22c%22%3A%22%23CECFCB%22%7D%5D%7D",
    'figiperb': "https://paolini.github.io/funplot/#q=%7B%22p%22%3A%7B%22x%22%3A-0.05295440431163167%2C%22y%22%3A-0.3520883830793602%2C%22r%22%3A11.010098668753743%7D%2C%22l%22%3A%5B%7B%22t%22%3A%22graph%22%2C%22e%22%3A%221%22%2C%22c%22%3A%22%23D9D9D8%22%7D%2C%7B%22t%22%3A%22graph%22%2C%22e%22%3A%22-1%22%2C%22c%22%3A%22%23D3D3D3%22%7D%2C%7B%22t%22%3A%22graph%22%2C%22e%22%3A%22tanh(x)%22%2C%22c%22%3A%22%238B572A%22%7D%2C%7B%22t%22%3A%22graph%22%2C%22e%22%3A%22cosh(x)%22%2C%22c%22%3A%22%23020BFA%22%7D%2C%7B%22t%22%3A%22graph%22%2C%22e%22%3A%22sinh(x)%22%2C%22c%22%3A%22%23D0021B%22%7D%5D%7D",
    'separabile': "https://paolini.github.io/funplot/#q=%7B%22p%22%3A%7B%22x%22%3A0%2C%22y%22%3A0%2C%22r%22%3A5%7D%2C%22l%22%3A%5B%7B%22t%22%3A%22ode_equation%22%2C%22e%22%3A%22x%5E2*exp(y)%22%2C%22c%22%3A%22%234A90E2%22%2C%22sc%22%3A%22%237ED321%22%2C%22ds%22%3Afalse%2C%22gp%22%3Atrue%2C%22l%22%3A%5B%5D%7D%5D%7D",
    'edo_463': "https://paolini.github.io/funplot/#q=%7B%22p%22%3A%7B%22x%22%3A0.24976002087478472%2C%22y%22%3A-0.17819487847667634%2C%22r%22%3A6.456342057408671%7D%2C%22l%22%3A%5B%7B%22t%22%3A%22graph%22%2C%22e%22%3A%221%22%2C%22c%22%3A%22%23D0021B%22%7D%2C%7B%22t%22%3A%22graph%22%2C%22e%22%3A%22-1%22%2C%22c%22%3A%22%23D0021B%22%7D%2C%7B%22t%22%3A%22ode_equation%22%2C%22e%22%3A%22(1-y%5E2)x%20sin(x)%22%2C%22c%22%3A%22%23000000%22%2C%22sc%22%3A%22%237ED321%22%2C%22ds%22%3Afalse%2C%22gp%22%3Afalse%2C%22l%22%3A%5B%7B%22x%22%3A-5.283862230447393e-9%2C%22y%22%3A-3.1582453986645245e-8%7D%5D%7D%5D%7D",
    'edo_4630': "https://paolini.github.io/funplot/#q=%7B%22p%22%3A%7B%22x%22%3A-0.07614353762585471%2C%22y%22%3A-0.5940066347406062%2C%22r%22%3A6.855579953554406%7D%2C%22l%22%3A%5B%7B%22t%22%3A%22graph%22%2C%22e%22%3A%22pi%2F2%22%2C%22c%22%3A%22%23D0021B%22%7D%2C%7B%22t%22%3A%22graph%22%2C%22e%22%3A%22-pi%2F2%22%2C%22c%22%3A%22%23D0021B%22%7D%2C%7B%22t%22%3A%22ode_equation%22%2C%22e%22%3A%22cos(y)*sin(x)%22%2C%22c%22%3A%22%234A90E2%22%2C%22sc%22%3A%22%237ED321%22%2C%22ds%22%3Afalse%2C%22gp%22%3Afalse%2C%22l%22%3A%5B%7B%22x%22%3A0.0%2C%22y%22%3A0.0%7D%5D%7D%5D%7D",
    'edo_4630b': "https://paolini.github.io/funplot/#q=%7B%22p%22%3A%7B%22x%22%3A0.16471279815999562%2C%22y%22%3A-0.392814347539557%2C%22r%22%3A10.685068720030651%7D%2C%22l%22%3A%5B%7B%22t%22%3A%22ode_equation%22%2C%22c%22%3A%22%234A90E2%22%2C%22sc%22%3A%22%237ED321%22%2C%22e%22%3A%22cos(y%5E2)*sin(x)%22%2C%22ds%22%3Afalse%2C%22gp%22%3Afalse%2C%22l%22%3A%5B%5B-0.000034419071295612714%2C0.00021685400476081806%5D%5D%7D%2C%7B%22t%22%3A%22graph%22%2C%22i%22%3Afalse%2C%22c%22%3A%22%23f00%22%2C%22e%22%3A%22sqrt(pi%2F2)%22%7D%2C%7B%22t%22%3A%22graph%22%2C%22i%22%3Afalse%2C%22c%22%3A%22%23f00%22%2C%22e%22%3A%22-sqrt(pi%2F2)%22%7D%5D%7D",
    'edo_volterra': "https://paolini.github.io/funplot/#q=%7B%22p%22%3A%7B%22x%22%3A1.6338367315281261%2C%22y%22%3A1.6449570865299732%2C%22r%22%3A5.474291781914866%7D%2C%22l%22%3A%5B%7B%22t%22%3A%22ode_system%22%2C%22ex%22%3A%22x*(1-y)%22%2C%22ey%22%3A%22y*(x-1)%22%2C%22c%22%3A%22%234A90E2%22%2C%22sc%22%3A%22%237ED321%22%2C%22ds%22%3Afalse%2C%22da%22%3Atrue%2C%22gp%22%3Afalse%2C%22l%22%3A%5B%5B0.9761553444993991%2C1.0138225051829446%5D%2C%5B0.9917523860375654%2C0.8812476521085304%5D%2C%5B0.9761553444993991%2C0.7876654028795321%5D%2C%5B0.9449612614230664%2C0.5537097798070365%5D%2C%5B0.9215656991158168%2C0.38214232288720634%5D%2C%5B0.9527597821921495%2C0.18717930366012664%5D%2C%5B0.9839538652684823%2C0.10919409596929477%5D%5D%7D%5D%7D",
    'ode_logistica': "https://paolini.github.io/funplot/#q=%7B%22p%22%3A%7B%22x%22%3A0%2C%22y%22%3A0%2C%22r%22%3A5%7D%2C%22l%22%3A%5B%7B%22t%22%3A%22ode_equation%22%2C%22c%22%3A%22%234A90E2%22%2C%22sc%22%3A%22%237ED321%22%2C%22e%22%3A%22(1-y)*y%22%2C%22ds%22%3Afalse%2C%22gp%22%3Atrue%2C%22l%22%3A%5B%5D%7D%5D%7D",
    'sistemi_sella': "https://paolini.github.io/funplot/#q=%7B%22p%22%3A%7B%22x%22%3A0.015%2C%22y%22%3A-0.14%2C%22r%22%3A2.77%7D%2C%22l%22%3A%5B%7B%22t%22%3A%22ode_system%22%2C%22ex%22%3A%22%20y%22%2C%22ey%22%3A%22y%20%2B%20x%22%2C%22c%22%3A%22%234A90E2%22%2C%22sc%22%3A%22%237ED321%22%2C%22ds%22%3Afalse%2C%22gp%22%3Atrue%2C%22l%22%3A%5B%5D%7D%5D%7D",
    'sistemi_fuoco': "https://paolini.github.io/funplot/#q=%7B%22p%22%3A%7B%22x%22%3A0.015%2C%22y%22%3A-0.14%2C%22r%22%3A2.77%7D%2C%22l%22%3A%5B%7B%22t%22%3A%22ode_system%22%2C%22ex%22%3A%22%20y%22%2C%22ey%22%3A%22-x%20-y%22%2C%22c%22%3A%22%234A90E2%22%2C%22sc%22%3A%22%237ED321%22%2C%22ds%22%3Afalse%2C%22gp%22%3Atrue%2C%22l%22%3A%5B%5D%7D%5D%7D",
    'sistemi_nodo': "https://paolini.github.io/funplot/#q=%7B%22p%22%3A%7B%22x%22%3A0.015%2C%22y%22%3A-0.14113430003440713%2C%22r%22%3A2.775103135445589%7D%2C%22l%22%3A%5B%7B%22t%22%3A%22ode_system%22%2C%22ex%22%3A%22-2*x%2By%22%2C%22ey%22%3A%22-3*y%22%2C%22c%22%3A%22%234A90E2%22%2C%22sc%22%3A%22%237ED321%22%2C%22ds%22%3Afalse%2C%22gp%22%3Atrue%2C%22l%22%3A%5B%5D%7D%5D%7D",
    'sistemi_nodo_improprio': "https://paolini.github.io/funplot/#q=%7B%22p%22%3A%7B%22x%22%3A0.014%2C%22y%22%3A-0.16%2C%22r%22%3A2.92%7D%2C%22l%22%3A%5B%7B%22t%22%3A%22ode_system%22%2C%22ex%22%3A%22-x%2By%22%2C%22ey%22%3A%22-y%22%2C%22c%22%3A%22%234A90E2%22%2C%22sc%22%3A%22%237ED321%22%2C%22ds%22%3Afalse%2C%22gp%22%3Atrue%2C%22l%22%3A%5B%5D%7D%5D%7D",
    'sistemi_stella': "https://paolini.github.io/funplot/#q=%7B%22p%22%3A%7B%22x%22%3A0.015%2C%22y%22%3A-0.14%2C%22r%22%3A2.77%7D%2C%22l%22%3A%5B%7B%22t%22%3A%22ode_system%22%2C%22ex%22%3A%22-x%22%2C%22ey%22%3A%22-y%22%2C%22c%22%3A%22%234A90E2%22%2C%22sc%22%3A%22%237ED321%22%2C%22ds%22%3Afalse%2C%22gp%22%3Atrue%2C%22l%22%3A%5B%5D%7D%5D%7D",
    'sistemi_centro': "https://paolini.github.io/funplot/#q=%7B%22p%22%3A%7B%22x%22%3A0.015%2C%22y%22%3A-0.14%2C%22r%22%3A2.77%7D%2C%22l%22%3A%5B%7B%22t%22%3A%22ode_system%22%2C%22ex%22%3A%22-4*x%2B17*y%22%2C%22ey%22%3A%22-23*x%2B4*y%22%2C%22c%22%3A%22%234A90E2%22%2C%22sc%22%3A%22%237ED321%22%2C%22ds%22%3Afalse%2C%22gp%22%3Atrue%2C%22l%22%3A%5B%5D%7D%5D%7D",
    'darboux': "https://paolini.github.io/funplot/#q=%7B%22p%22%3A%7B%22x%22%3A0.03916255253926221%2C%22y%22%3A-0.02282969005983251%2C%22r%22%3A0.7408648288253102%7D%2C%22l%22%3A%5B%7B%22t%22%3A%22graph%22%2C%22e%22%3A%22x%5E2%22%2C%22c%22%3A%22%2366B906%22%7D%2C%7B%22t%22%3A%22graph%22%2C%22e%22%3A%22-x%5E2%22%2C%22c%22%3A%22%2361B105%22%7D%2C%7B%22t%22%3A%22graph%22%2C%22e%22%3A%22x%5E2*sin(1%2Fx)%22%2C%22c%22%3A%22%23000000%22%7D%5D%7D",
    'ex843': "https://paolini.github.io/funplot/#q=%7B%22p%22%3A%7B%22x%22%3A0.8359215354250258%2C%22y%22%3A-0.3113064274119333%2C%22r%22%3A6.26161358095934%7D%2C%22l%22%3A%5B%7B%22t%22%3A%22ode_equation%22%2C%22c%22%3A%22%230077ff%22%2C%22sc%22%3A%22%237ED321%22%2C%22e%22%3A%221-x*y%5E3%22%2C%22ds%22%3Afalse%2C%22gp%22%3Afalse%2C%22l%22%3A%5B%5B0.000007591585841334249%2C1.8948673928092548e-7%5D%5D%7D%2C%7B%22t%22%3A%22implicit%22%2C%22c%22%3A%22%23e69f9f%22%2C%22e%22%3A%221-x*y%5E3%22%7D%5D%7D",
    'exoqt': "https://paolini.github.io/funplot/#q=%7B%22p%22%3A%7B%22x%22%3A0.8359215354250258%2C%22y%22%3A-0.3113064274119333%2C%22r%22%3A6.26161358095934%7D%2C%22l%22%3A%5B%7B%22t%22%3A%22ode_equation%22%2C%22c%22%3A%22%230077ff%22%2C%22sc%22%3A%22%237ED321%22%2C%22e%22%3A%221-x*y%5E3%22%2C%22ds%22%3Afalse%2C%22gp%22%3Afalse%2C%22l%22%3A%5B%5B0.000007591585841334249%2C1.8948673928092548e-7%5D%5D%7D%2C%7B%22t%22%3A%22implicit%22%2C%22c%22%3A%22%23e69f9f%22%2C%22e%22%3A%221-x*y%5E3%22%7D%5D%7D",
    'dummy': "#" // last entry without trailing comma
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

grep "%% README" "${INTRODUZIONE}" \
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
  <li><a href="https://www.amazon.it/dp/B09KNCWQTJ">ordina una copia cartacea</a></li>
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
