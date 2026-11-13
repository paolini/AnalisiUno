"""Estrae da AnalisiUno-custom.tex le macro matematiche e scrive
mathjax-config.js, che le definisce in MathJax (con \\newcommand e \\let)
prima di comporre la pagina.
Uso: python3 mathjax_macros.py AnalisiUno-custom.tex mathjax-config.js
"""
import json
import re
import sys

LANG = 'italian'

def group(s, i):
    """s[i] == '{': restituisce (contenuto, indice dopo la '}')"""
    assert s[i] == '{', s[i:i+20]
    depth = 0
    for j in range(i, len(s)):
        if s[j] == '{':
            depth += 1
        elif s[j] == '}':
            depth -= 1
            if depth == 0:
                return s[i+1:j], j+1
    raise ValueError('graffa non chiusa')

def skip_ws(s, i):
    while i < len(s) and s[i] in ' \t\n':
        i += 1
    return i

def resolve_iflanguage(s):
    out, i = '', 0
    while True:
        k = s.find('\\iflanguage', i)
        if k < 0:
            return out + s[i:]
        out += s[i:k]
        j = skip_ws(s, k + len('\\iflanguage'))
        lang, j = group(s, j)
        yes, j = group(s, skip_ws(s, j))
        no, j = group(s, skip_ws(s, j))
        out += yes if lang == LANG else no
        i = j

def convert(src):
    src = src.split('%% thmtools')[0]
    src = '\n'.join(l.split('%')[0] if not l.lstrip().startswith('\\%') else l
                    for l in src.splitlines())
    src = resolve_iflanguage(src)
    out = []
    pos = 0
    pat = re.compile(r'\\(newcommand|renewcommand|DeclareMathOperator|let)\b')
    while True:
        m = pat.search(src, pos)
        if not m:
            break
        cmd, i = m.group(1), skip_ws(src, m.end())
        if cmd == 'let':
            mm = re.match(r'(\\[a-zA-Z]+)\s*(\\[a-zA-Z]+)', src[i:])
            out.append('\\let%s%s' % mm.groups())
            pos = i + mm.end()
            continue
        name, i = group(src, i)
        i = skip_ws(src, i)
        nargs = ''
        mm = re.match(r'\[(\d)\]', src[i:])
        if mm:
            nargs = mm.group(0)
            i = skip_ws(src, i + mm.end())
        body, i = group(src, i)
        if cmd == 'DeclareMathOperator':
            body = '\\operatorname{%s}' % body
        if 'regex' in body or 'mathcal' not in body and '\\ExplSyntax' in body:
            pos = i
            continue
        body = re.sub(r'\s*\n\s*', ' ', body).strip()
        out.append('\\newcommand{%s}%s{%s}' % (name, nargs, body))
        pos = i
    # integrale medio (definito con \def nel sorgente)
    out.append(r'\newcommand{\dashint}{{-}\kern-0.9em\int}')
    return '\n'.join(out) + '\n'

if __name__ == '__main__':
    src = open(sys.argv[1], encoding='utf8').read()
    defs = convert(src)
    js = (
        "// generato da mathjax_macros.py: non modificare\n"
        "window.MathJax = window.MathJax || {};\n"
        "window.MathJax.tex = Object.assign(window.MathJax.tex || {}, {tags: 'none'});\n"
        "window.MathJax.startup = {\n"
        "  pageReady() {\n"
        "    // definisce le macro prima di comporre la pagina\n"
        "    return MathJax.tex2chtmlPromise(%s).then(() => MathJax.startup.defaultPageReady());\n"
        "  }\n"
        "};\n") % json.dumps(defs)
    open(sys.argv[2], 'w', encoding='utf8').write(js)
