// Compone le formule con KaTeX al momento della compilazione: sostituisce
// ogni formula delle pagine HTML (\(...\), \[...\], \begin{...}...\end{...},
// lasciate intatte da tex4ht in modalita' mathjax) con l'HTML prodotto da
// KaTeX, e aggiunge a ogni pagina il CSS di KaTeX (copiato in katex/).
//
// Uso: node katex_render.js macros.tex cartella-html
// (macros.tex e' generato da tex_macros.py)
const fs = require('fs'), path = require('path');
const katex = require('katex');

const [macroFile, dir] = process.argv.slice(2);
const KATEX_CSS = 'katex/katex.min.css';  // relativo a dir

const macros = {
  '\\MoveEqLeft': '&\\hspace{-2em}',  // mathtools: prima riga sporgente a sinistra
  '\\colon': '\\mathpunct{:}',        // KaTeX mette troppo spazio prima dei due punti
};
const opts = display => ({displayMode: display, macros, throwOnError: false,
  trust: true, strict: 'ignore', output: 'html'});

// una definizione per riga; \newcommand su comandi gia' esistenti in KaTeX
// (es. \phi) diventa \renewcommand
for (const line of fs.readFileSync(macroFile, 'utf8').split('\n').filter(l => l.trim())) {
  for (const l of [line, line.replace(/^\\newcommand/, '\\renewcommand')]) {
    try {
      katex.renderToString(l, {...opts(false), throwOnError: true, globalGroup: true});
      break;
    } catch (e) {
      if (l !== line) console.error('katex: macro non definita:', line);
    }
  }
}

const unesc = s => s.replace(/&lt;/g, '<').replace(/&gt;/g, '>')
  .replace(/&quot;/g, '"').replace(/&#39;/g, "'").replace(/&amp;/g, '&');
// differenze con LaTeX
const fix = s => s.replace(/\\renewcommand\s*\{\\arraystretch\s*\}/g, '\\def\\arraystretch');

const MATH = /\\\(([\s\S]*?)\\\)|\\\[([\s\S]*?)\\\]|(\\begin\{([a-z]+\*?)\}[\s\S]*?\\end\{\4\})/g;
const walk = d => fs.readdirSync(d, {withFileTypes: true}).flatMap(e =>
  e.isDirectory() ? walk(path.join(d, e.name))
  : e.name.endsWith('.html') ? [path.join(d, e.name)] : []);

let n = 0, errors = 0;
for (const f of walk(dir)) {
  const html = fs.readFileSync(f, 'utf8');
  const b = html.indexOf('<body');
  let head = html.slice(0, b), body = html.slice(b);
  body = body.replace(MATH, (m, inl, disp, env) => {
    n++;
    const src = fix(unesc(inl ?? disp ?? env));
    const out = katex.renderToString(src, opts(inl === undefined));
    if (out.includes('katex-error')) {
      errors++;
      console.error(`katex: ${path.relative(dir, f)}: ${src.slice(0, 100).replace(/\n/g, ' ')}`);
    }
    return out;
  });
  const css = path.relative(path.dirname(f), path.join(dir, KATEX_CSS));
  head = head
    // configurazione di MathJax che tex4ht aggiunge comunque: non serve
    .replace(/<script>window\.MathJax = [\s\S]*?<\/script>\s*/, '')
    .replace('</head>', `<link rel='stylesheet' href='${css}' />\n</head>`);
  fs.writeFileSync(f, head + body);
}
console.log(`katex: ${n} formule, ${errors} errori`);
if (errors) process.exitCode = 1;
