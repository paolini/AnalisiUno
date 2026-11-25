[![DOI](https://zenodo.org/badge/105351342.svg)](https://doi.org/10.5281/zenodo.24164701)

Questo testo è nato dagli appunti per il corso di Analisi Matematica 
del corso di studi in Fisica dell'Università 
di Pisa svolto negli anni accademici dal 2017/18 al 2026/27. 
 
Le note (come il corso a cui fanno riferimento) 
riguardano l'analisi delle funzioni di una variabile 
reale. 
Gli argomenti trattati sono serie e successioni numeriche, 
successioni ricorsive, 
il calcolo differenziale e il calcolo integrale. 
Viene fatta un minimo di analisi funzionale allo scopo di introdurre la convergenza uniforme. Vengono introdotte le equazioni differenziali ordinarie. 
Da subito vengono presentati i numeri complessi che vengono utilizzati 
laddove possono aiutare a dare una visione più unitaria e concettualmente 
più semplice degli argomenti trattati (in particolare nello studio delle serie 
di potenze, nella definizione delle funzioni trigonometriche, nella risoluzione delle equazioni differenziali lineari). 

Le note sono estensive, non c'è alcun tentativo di concisione. 
L'obiettivo è quello di raccogliere tutti quei risultati che non sempre è 
possibile esporre in maniera dettagliata e rigorosa a lezione. 
Troveremo, ad esempio, 
delle definizioni 
formali della funzione esponenziale, delle funzioni trigonometriche, e dei loro limiti notevoli. 
Proponiamo anche la dimostrazione del teorema fondamentale dell'algebra, 
della formula di Stirling e di Wallis, 
e dell'irrazionalità di $e$ e di $\pi$. 
Esponiamo i teoremi di scambio della derivata con l'integrale e con il limite. Questi teoremi vengono usati per il calcolo di alcuni integrali non elementari come $\int_0^{+\infty} \frac{\sin x}{x} dx$ e $\int_0^{+\infty} e^{-x^2} dx$. 
In un lungo esercizio (che utilizza quasi tutto il materiale del corso) vengono calcolati i primi termini dello sviluppo in serie del periodo delle piccole oscillazioni di un pendolo. 
 
Viene proposta una definizione formale dei simboli di Landau 
$o$-piccolo e $O$-grande con i relativi teoremi per manipolare queste espressioni. 
Lo stesso viene fatto per il simbolo di integrale indefinito. 
Vengono trattati quei risultati algebrici che permettono di 
giustificare gli algoritmi per il calcolo delle primitive 
delle funzioni razionali e per risolvere le equazioni differenziali 
lineari con il metodo di similarità. 
 
Il primo capitolo, dedicato ai sistemi formali, alla costruzione 
degli insiemi numerici e alla definizione delle funzioni elementari, 
vorrebbe dare fondamento matematico a tutte quelle nozioni che 
lo studente dovrebbe avere già appreso nel curriculum scolastico. 
Alcuni argomenti trattati nel primo capitolo possono risultare 
di difficile comprensione in quanto molto tecnici: 
si potranno comunque saltare in quanto trattano di concetti 
che almeno intuitivamente dovrebbero risultare già noti. 
In particolare la definizione assiomatica dell'insieme 
dei numeri reali risulta probabilmente molto diversa da 
come viene usualmente svolta nella maggior parte dei libri di testo 
che introducono all'analisi matematica: 
invece di assumere le proprietà di campo (e quindi l'esistenza 
a priori delle due operazioni di addizione e moltiplicazione) 
si considera solamente l'operazione di addizione 
mentre la moltiplicazione viene costruita di conseguenza. 
Questo approccio è giustificato dall'osservazione che 
la costruzione della moltiplicazione è esattamente la stessa 
costruzione che viene usualmente utilizzata per costruire 
l'operazione di elevamento a potenza. 
Dunque lo stesso teorema astratto 
(isomorfismo dei gruppi totalmente ordinati densi e continui) 
viene utilizzato per costruire la moltiplicazione, 
le funzioni esponenziali e le funzioni trigonometriche. 
 
Le figure non sono frequenti. A margine di alcune di esse 
è presente un *QR-code* (un quadrato formato da una nuvola di pixel) 
che permette di accedere alla figura  
*online* e modicarne i parametri.  
Di seguito in questa pagina trovate l'elenco 
con i collegamenti alle figure interattive. 
 
Queste note sono rese disponibili liberamente sia in formato PDF che 
in forma di sorgente 
LaTeX. 
Il materiale è costantemente in evoluzione 
e certamente contiene errori e incoerenze. Ogni suggerimento o commento è 
benvenuto! 

# LICENZA 

© [2014-2026] [Emanuele Paolini] 
Quest'opera è rilasciata sotto licenza [Creative Commons Attribuzione - Condividi allo stesso modo 4.0 Internazionale (CC BY-SA 4.0)](https://creativecommons.org/licenses/by-sa/4.0/deed.it). 

# release

Releases (PDF format) are available at the github repository: <https://github.com/paolini/AnalisiUno/tags>

# compiling 

file `README.md` is created from sources with the command:

    bash make-docs.sh

the `pdf` file can be obtained with the command:

    latexmk --pdf AnalisiUno

The `Makefile` should automate the previous commands.
The HTML version (published at <https://paolini.github.io/AnalisiUno/>) is built with `make html`.

# compilation with docker

    docker run -it -w /app -v "${PWD}:/app" ghcr.io/xu-cheng/texlive-full latexmk --pdf AnalisiUno -file-line-error -halt-on-error -interaction=nonstopmode

