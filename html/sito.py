"""Pagine del sito oltre a quelle del libro (da eseguire dopo postprocess.py).

- index.html (il frontespizio con l'indice) diventa la pagina iniziale:
  presentazione, pulsanti (leggi, PDF, copia cartacea, ...) e indice;
- rimandi.js: gli indirizzi brevi dei QR code stampati nel libro,
  https://paolini.github.io/AnalisiUno?chiave, rimandano alla pagina
  indicata in rimandi.json (la tabella si modifica li');
- collegamenti.html: tutti i collegamenti del testo (i QR code della
  versione stampata), ciascuno con la sezione in cui compare;
- nelle pagine del libro i link brevi diventano link diretti.

Uso: python3 sito.py rimandi.json out/
"""
import json
import os
import re
import sys

SHORT = 'http://paolini.github.io/AnalisiUno?'   # \myshorturl in AnalisiUno-custom.tex
SITE = 'https://paolini.github.io/AnalisiUno'
EMAIL = 'emanuele.paolini@gmail.com'

HOME = """<div class='home'>
<p class='home-sub'>Appunti per il corso di Analisi Matematica del corso di studi
in Fisica dell'Universit&agrave; di Pisa.</p>
<p class='home-actions'>
<a class='btn btn-primary' href='introduzione/index.html'>Inizia a leggere</a>
<a class='btn' href='https://github.com/paolini/AnalisiUno/releases/latest'>Scarica il PDF</a>
<a class='btn' href='https://www.amazon.it/dp/B09KNCWQTJ'>Copia cartacea</a>
<a class='btn' href='collegamenti.html'>Figure interattive</a>
<a class='btn' href='https://github.com/paolini/AnalisiUno'>Codice sorgente</a>
</p>
<p class='home-doi'><a href='https://doi.org/10.5281/zenodo.24164701'><img
 src='https://zenodo.org/badge/105351342.svg' alt='DOI' /></a></p>
<div id='rimando'></div>
</div>
<h2 class='home-toc'>Indice</h2>
"""

RIMANDI_JS = """// generato da sito.py a partire da rimandi.json: non modificare
// Gli indirizzi brevi dei QR code (https://paolini.github.io/AnalisiUno?chiave)
// rimandano alla pagina indicata nella tabella.
var RIMANDI = %s;
(function () {
  var id = window.location.search.substring(1);
  if (!id || id.indexOf('=') >= 0) return;
  if (RIMANDI[id]) { window.location.replace(RIMANDI[id]); return; }
  document.addEventListener('DOMContentLoaded', function () {
    var e = document.getElementById('rimando');
    if (e) e.innerHTML = "<p>Rimando alla pagina '" + id.replace(/[<>&'"]/g, '') +
      "' sconosciuto. Puoi <a href='mailto:%s'>segnalarmi il problema</a>; " +
      "qui c'&egrave; l'<a href='collegamenti.html'>elenco dei collegamenti</a>.</p>";
  });
})();
"""

LINK = re.compile(r"<a href='([^']*)'><span class='extlink'></span>(.*?)</a>", re.S)


def read(path):
    return open(path, encoding='utf8').read()


def write(path, s):
    open(path, 'w', encoding='utf8').write(s)


def main(rimandi_file, out):
    rimandi = json.load(open(rimandi_file, encoding='utf8'))
    home = read(os.path.join(out, 'index.html'))

    # pagine nell'ordine dell'indice, con il loro titolo (numero compreso)
    pages, toc = [], {}
    for num, href, name in re.findall(
            r"<span class='\w+Toc'>([^<]*)<a href='([^'#]*)[^']*'[^>]*>(.*?)</a>", home, re.S):
        if href.endswith('.html') and href not in pages:
            pages.append(href)
            toc[href] = (num.strip() + ' ' + name).strip()

    # link dei QR code: diretti nelle pagine, raccolti per collegamenti.html
    links = []   # (pagina, ancora, url, descrizione)
    for page in pages:
        path = os.path.join(out, page)
        s = read(path)
        def repl(m):
            url, desc = m.group(1), m.group(2)
            if url.startswith(SHORT):
                url = rimandi.get(url[len(SHORT):], url)
            anchor = 'qr-%d' % (len(links) + 1)
            links.append((page, anchor, url, desc))
            return "<a id='%s' href='%s'><span class='extlink'></span>%s</a>" % (anchor, url, desc)
        t = LINK.sub(repl, s)
        if t != s:
            write(path, t)

    # collegamenti.html, raggruppati per capitolo
    head = home[:home.index('<body')]
    head = re.sub(r'<title>.*?</title>', '<title>Figure interattive e collegamenti</title>', head, flags=re.S)
    body = ["<body>",
            "<div class='crosslinks'><p class='noindent'><a href='index.html'>&uarr; indice</a></p></div>",
            "<h2 class='chapterHead'>Figure interattive e collegamenti</h2>",
            "<p>I collegamenti presenti nel testo: nella versione stampata sono i "
            "QR-code a margine. Per ciascuno &egrave; indicata la sezione in cui compare.</p>"]
    chapter = None
    for page, anchor, url, desc in links:
        if url.rstrip('/') == SITE:
            continue  # "questa pagina web" (l'introduzione rimanda al sito)
        ch = page.split('/')[0] if '/' in page else ''
        if ch != chapter:
            if chapter is not None:
                body.append('</ul>')
            chapter = ch
            name = toc.get(ch + '/index.html', ch)
            body.append("<h3 class='sectionHead'>%s</h3>\n<ul class='collegamenti'>" % name)
        where = toc.get(page, page)
        body.append("<li><a href='%s'>%s</a> &mdash; <a class='dove' href='%s#%s'>%s</a></li>"
                    % (url, desc, page, anchor, where))
    if chapter is not None:
        body.append('</ul>')
    body.append('</body>\n</html>\n')
    write(os.path.join(out, 'collegamenti.html'), head + '\n'.join(body))

    # pagina iniziale e rimandi
    write(os.path.join(out, 'rimandi.js'),
          RIMANDI_JS % (json.dumps(rimandi, indent=2, ensure_ascii=False), EMAIL))
    home = home.replace('</head>', "<script src='rimandi.js'></script>\n</head>", 1)
    home = home.replace("<div class='tableofcontents'>", HOME + "<div class='tableofcontents'>", 1)
    # la voce "Indice" dell'indice e' superflua nella pagina iniziale
    home = re.sub(r"<span class='likechapterToc'><a href='indice\.html[^']*'[^>]*>Indice</a></span>\s*(<br />)?",
                  '', home, count=1)
    write(os.path.join(out, 'index.html'), home)
    print('sito: %d collegamenti, %d rimandi' % (len(links), len(rimandi)))


if __name__ == '__main__':
    main(sys.argv[1], sys.argv[2])
