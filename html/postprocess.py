"""Post-elaborazione dell'HTML prodotto da make4ht.

Dentro le formule (passate a MathJax senza elaborarle) possono restare
comandi che MathJax non puo' risolvere da solo:
- \\eqref{...} e \\ref{...}: MathJax non conosce le etichette di LaTeX;
  li sostituiamo con il numero (preso dal file .aux) come link \\href;
- \\the\\year: sostituito con l'anno corrente.

Inoltre ricostruisce i mini-indici delle pagine dei capitoli a partire
dall'indice generale: quelli generati da tex4ht sono sfasati (prendono
voci di altri capitoli).

Uso: python3 postprocess.py build/AnalisiUnoHtml.aux out/
"""
import datetime
import glob
import os
import re
import sys

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

def fix_minitocs(outdir, main='AnalisiUnoHtml.html'):
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
    for lab in sorted(missing):
        print('postprocess: etichetta non trovata:', lab, file=sys.stderr)

if __name__ == '__main__':
    main(sys.argv[1], sys.argv[2])
