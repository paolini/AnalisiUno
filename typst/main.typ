// --- CONFIGURAZIONE PAGINA E TIPOGRAFIA ---
#set page(
  paper: "a4",
  margin: (x: 2.5cm, top: 3cm, bottom: 2.5cm),
  header: align(right)[
    #text(8pt, fill: luma(120))[Capitolo 1. Analisi Reale]
  ],
  footer: [
    #align(center)[#context counter(page).display()]
  ]
)

#set text(font: "New Computer Modern", size: 11pt, lang: "it")
#set par(justify: true)

// --- NUMERAZIONE CAPITOLI E CONTATORE UNICO ---
#set heading(numbering: "1.1")

#show heading.where(level: 1): it => {
  counter("matematica").update(0)
  it
}

// --- FUNZIONE DI FORMATTAZIONE PER LA NUMERAZIONE ---
#let formato-matematica(..n) = context {
  let cap = counter(heading).get().first()
  let num = counter("matematica").get().first()
  str(cap) + "." + str(num)
}

// --- FUNZIONI PER I RIQUADRI MATEMATICI ---

#let teorema(titolo, corpo) = {
  figure(
    kind: "teorema",
    supplement: "Teorema",
    caption: none,
    numbering: formato-matematica,
    context {
      counter("matematica").step()
      let cap = counter(heading).get().first()
      let num = counter("matematica").get().first()
      let id = str(cap) + "." + str(num)
      
      block(
        fill: rgb("2b7fff").lighten(92%),
        stroke: 1pt + rgb("2b7fff"),
        inset: 10pt,
        radius: 4pt,
        width: 100%,
        align(left)[
          #text(weight: "bold", fill: rgb("2b7fff").darken(20%))[
            Teorema #id #if titolo != "" [ (#titolo)]
          ]
          #v(4pt)
          #corpo
        ]
      )
    }
  )
}

#let definizione(titolo, corpo) = {
  figure(
    kind: "definizione",
    supplement: "Definizione",
    caption: none,
    numbering: formato-matematica,
    context {
      counter("matematica").step()
      let cap = counter(heading).get().first()
      let num = counter("matematica").get().first()
      let id = str(cap) + "." + str(num)
      
      block(
        fill: rgb("707070").lighten(92%),
        stroke: 1pt + rgb("707070"),
        inset: 10pt,
        radius: 4pt,
        width: 100%,
        align(left)[
          #text(weight: "bold", fill: rgb("707070").darken(20%))[
            Definizione #id #if titolo != "" [ (#titolo)]
          ]
          #v(4pt)
          #corpo
        ]
      )
    }
  )
}

#let dimostrazione(corpo) = block(
  spacing: 1.5em,
  [
    _Dimostrazione._ #corpo
    #align(right)[$square$]
  ]
)

// --- CONTENUTO DEL DOCUMENTO ---

= Limiti e Continuità

#definizione("Continuità Puntuale")[
  Sia $f: A -> RR$ e sia $x_0 in A$. La funzione $f$ si dice *continua* nel punto $x_0$ se:
  $ forall epsilon > 0, exists delta > 0 : forall x in A, |x - x_0| < delta => |f(x) - f(x_0)| < epsilon $
] <def-continuita>

Possiamo ora passare al risultato principale riguardante l'esistenza dei massimi e minimi per funzioni continue su insiemi compatti.

#teorema("Weierstrass")[
  Sia $f: [a, b] -> RR$ una funzione continua nell'intervallo chiuso e limitato $[a, b]$. 
  Allora $f$ ammette *massimo assoluto* e *minimo assoluto* nell'intervallo.
] <th-weierstrass>

#dimostrazione[
  La dimostrazione del @th-weierstrass si basa sulla @def-continuita e sulla proprietà di compattezza dell'intervallo $[a, b]$.
]

= Calcolo Differenziale

#definizione("Derivata")[
  Sia $f: (a, b) -> RR$ e sia $x_0 in (a, b)$. La funzione $f$ si dice *derivabile* in $x_0$ se esiste finito il limite del rapporto incrementale:
  $ f'(x_0) = lim_(h -> 0) (f(x_0 + h) - f(x_0)) / h $
] <def-derivata>

#teorema("Rolle")[
  Sia $f: [a, b] -> RR$ una funzione continua in $[a, b]$, derivabile in $(a, b)$ e tale che $f(a) = f(b)$.
  Allora existe almeno un punto $c in (a, b)$ tale che $f'(c) = 0$.
] <th-rolle>

Come conseguenza diretta della @def-derivata e del @th-rolle, possiamo analizzare i punti stazionari della funzione.