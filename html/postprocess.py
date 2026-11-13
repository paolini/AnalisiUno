"""Post-elaborazione dell'HTML prodotto da make4ht.

Dentro le formule (passate a MathJax senza elaborarle) possono restare
comandi che MathJax non puo' risolvere da solo:
- \\eqref{...} e \\ref{...}: MathJax non conosce le etichette di LaTeX;
  li sostituiamo con il numero (preso dal file .aux) come link \\href;
- \\the\\year: sostituito con l'anno corrente.

Inoltre ricostruisce i mini-indici delle pagine dei capitoli a partire
dall'indice generale: quelli generati da tex4ht sono sfasati (prendono
voci di altri capitoli).

Infine sposta le pagine in una cartella per capitolo (vedi i nomi
assegnati in config.cfg): 02_limiti.html -> limiti/index.html,
02_limiti--06_radianti.html -> limiti/radianti.html, la pagina principale
diventa index.html; e aggiorna tutti i link.

Uso: python3 postprocess.py build/AnalisiUnoHtml.aux out/
"""
import datetime
import glob
import os
import re
import sys
import unicodedata

MAIN = 'AnalisiUnoHtml.html'  # pagina principale (diventa index.html)

def read_labels(aux):
    """etichetta -> (ancora, numero)"""
    labels = {}
    pat = re.compile(r'\\newlabel\{([^}]*)\}\{\{\\rEfLiNK\{([^}]*)\}'
                     r'\{\\csname :autoref\\endcsname\{[^}]*\}([^}]*)\}\}')
    for line in open(aux, encoding='utf8', errors='replace'):
        m = pat.match(line)
        if m:
            labels[m.group(1)] = (m.group(2), m.group(3))
    return labels

def anchor_files(outdir):
    """ancora -> nome del file html che la contiene"""
    where = {}
    for f in glob.glob(os.path.join(outdir, '*.html')):
        for a in re.findall(r"id='([^']*)'", open(f, encoding='utf8').read()):
            where.setdefault(a, os.path.basename(f))
    return where

def inside_text(s, pos):
    """True se la posizione pos e' dentro un \\text{...} di una formula"""
    k = max(s.rfind('\\text {', 0, pos), s.rfind('\\text{', 0, pos))
    if k < 0 or s.rfind('\\(', 0, pos) > k or s.rfind('\\begin{', 0, pos) > k:
        return False
    k = s.index('{', k)
    depth = 0
    for c in s[k:pos]:
        depth += {'{': 1, '}': -1}.get(c, 0)
        if depth == 0:
            return False
    return True

LEVEL = {'likechapterToc': 0, 'chapterToc': 0, 'appendixToc': 0,
         'likesectionToc': 1, 'sectionToc': 1}

def fix_minitocs(outdir, main=MAIN):
    toc = open(os.path.join(outdir, main), encoding='utf8').read()
    entries = re.findall(r"<span class='(\w+Toc)'>(.*?)</span>", toc, re.S)
    for i, (cls, body) in enumerate(entries):
        if LEVEL.get(cls) != 0:
            continue
        page = re.search(r"href='([^'#]*)", body).group(1)
        children = []
        for cls2, body2 in entries[i+1:]:
            if LEVEL.get(cls2, 9) <= 0:
                break
            body2 = re.sub(r" id='[^']*'", '', body2)
            children.append("<span class='%s'>%s</span>" % (cls2, body2))
        f = os.path.join(outdir, page)
        if not os.path.exists(f):
            continue
        s = open(f, encoding='utf8').read()
        t = re.sub(r"(<div class='\w+TOCS'>).*?(</div>)",
                   lambda m: m.group(1) + '\n' + '\n<br />'.join(children) + '\n' + m.group(2),
                   s, count=1, flags=re.S)
        if t != s:
            open(f, 'w', encoding='utf8').write(t)

def strip_num(name):
    """02_limiti -> limiti, 08_esponenziale_complesso -> esponenziale-complesso"""
    return re.sub(r'^\d+_', '', name).replace('_', '-')

def slug(text):
    text = unicodedata.normalize('NFKD', text)
    text = ''.join(c for c in text if not unicodedata.combining(c)).lower()
    return re.sub(r'[^a-z0-9]+', '-', text).strip('-')

def page_title(path):
    s = open(path, encoding='utf8').read()
    m = re.search(r'<title>(.*?)</title>', s, re.S)
    t = re.sub(r'<[^>]*>|&[a-z]+;', '', m.group(1)) if m else ''
    return re.sub(r'^[A-Z0-9.]+\s+', '', t.strip())  # toglie il numero

# nomi scelti a mano, al posto di quelli generati automaticamente, es.
#   'edo/funzioni-vettoriali-e-di-piu-variabili.html': 'edo/vettoriali.html'
RENAME = {
}

def toc_titles(outdir):
    """pagina -> titolo nell'indice generale (il titolo breve, se c'e')"""
    toc = open(os.path.join(outdir, MAIN), encoding='utf8').read()
    titles = {}
    for page, title in re.findall(r"<a href='([^'#]*)[^']*'[^>]*>(.*?)</a>", toc, re.S):
        titles.setdefault(page, re.sub(r'<[^>]*>|&[a-z]+;', '', title))
    return titles

def new_names(outdir):
    """nome piatto -> nuovo percorso relativo a outdir"""
    names = {MAIN: 'index.html'}
    used = set(names.values())
    titles = toc_titles(outdir)
    for f in sorted(os.listdir(outdir)):
        if not f.endswith('.html') or f == MAIN:
            continue
        base = f[:-5]
        chap, _, sec = base.partition('--')
        if not base:
            new = 'indice.html'                       # \tableofcontents
        elif not re.match(r'\d+_', chap):
            new = f                                   # bibliografia.html, ...
        elif not sec:
            new = strip_num(chap) + '/index.html'
        else:
            if sec.startswith('@'):
                # sezione senza file sorgente proprio: nome dal titolo
                title = titles.get(f) or page_title(os.path.join(outdir, f))
                sec = slug(title) or sec[1:]
            new = strip_num(chap) + '/' + strip_num(sec) + '.html'
        new = RENAME.get(new, new)
        stem, k = new[:-5], 2
        while new in used:
            new, k = '%s-%d.html' % (stem, k), k + 1
        used.add(new)
        names[f] = new
    return names

URL = re.compile(r"""((?:href|src)=)(['"])(.*?)\2|(\\href\{)([^}]*)(\})""")

def relocate(outdir):
    names = new_names(outdir)

    def fix(url, here):
        if not url or re.match(r'[a-z][a-z0-9+.-]*:|/|#', url, re.I):
            return url
        path, hash_, frag = url.partition('#')
        if frag in names or frag.endswith('.html'):
            hash_ = frag = ''  # link "su" di tex4ht: ancora inesistente nei mini-indici
        new = names.get(path, path)
        return os.path.relpath(new, os.path.dirname(here) or '.') + hash_ + frag

    for old, new in names.items():
        s = open(os.path.join(outdir, old), encoding='utf8').read()
        s = URL.sub(lambda m: m.group(1) + m.group(2) + fix(m.group(3), new) + m.group(2)
                    if m.group(1) else m.group(4) + fix(m.group(5), new) + m.group(6), s)
        os.remove(os.path.join(outdir, old))
        os.makedirs(os.path.dirname(os.path.join(outdir, new)), exist_ok=True)
        open(os.path.join(outdir, new), 'w', encoding='utf8').write(s)

def main(aux, outdir):
    labels = read_labels(aux)
    where = anchor_files(outdir)
    year = str(datetime.date.today().year)
    missing = set()

    def ref(m):
        cmd, lab = m.group(1), m.group(2).strip()
        if lab not in labels:
            missing.add(lab)
            return m.group(0)
        anchor, num = labels[lab]
        if cmd == 'eqref':
            num = '(%s)' % num
        link = '\\href{%s#%s}{\\text{%s}}' % (where.get(anchor, ''), anchor, num)
        if inside_text(m.string, m.start()):
            link = '$' + link + '$'
        return link

    for f in glob.glob(os.path.join(outdir, '*.html')):
        s = open(f, encoding='utf8').read()
        t = re.sub(r'\\(eqref|ref) ?\{([^}]*)\}', ref, s)
        t = re.sub(r'\\the ?\\year\b ?', year, t)
        if t != s:
            open(f, 'w', encoding='utf8').write(t)
    fix_minitocs(outdir)
    relocate(outdir)
    for lab in sorted(missing):
        print('postprocess: etichetta non trovata:', lab, file=sys.stderr)

if __name__ == '__main__':
    main(sys.argv[1], sys.argv[2])
