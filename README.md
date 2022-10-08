
Queste note sono nate come appunti per il corso di Analisi Matematica 
del corso di studi in Fisica dell'Università 
di Pisa negli anni accademici dal 2017/18 al 2022/23. 
 
Le note (come il corso a cui fanno riferimento) 
riguardano l'analisi delle funzioni di una variabile 
reale. 
Gli argomenti trattati sono serie e successioni numeriche, 
successioni ricorsive, 
il calcolo differenziale e il calcolo integrale. 
Viene fatta un minimo di analisi funzionale allo scopo di considerare, 
come ultimo argomento, lo studio delle equazioni differenziali ordinarie. 
Da subito vengono introdotti i numeri complessi che vengono utilizzati 
laddove possono aiutare a dare una visione più unitaria e concettualmente 
più semplice degli argomenti trattati (in particolare nello studio delle serie 
di potenze, nella definizione delle funzioni trigonometriche, nella risoluzione delle equazioni differenziali lineari). 

Le note sono estensive, non c'è alcun tentativo di concisione. 
L'obiettivo è quello di raccogliere tutti quei risultati che non sempre è 
possibile esporre in maniera dettagliata e rigorosa a lezione. 
Troveremo, ad esempio, 
definizioni equivalenti della funzione esponenziale e 
delle funzioni trigonometriche (con $e$ e $\pi$). 
Proponiamo la dimostrazione del teorema fondamentale dell'algebra, 
della formula di Stirling e di Wallis, 
e dell'irrazionalità di $e$ e di $\pi$. 
Viene proposta una definizione formale dei simboli di Landau 
$o$-piccolo e $O$-grande con i relativi teoremi per trattare queste espressioni. 
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
Le figure non sono frequenti ma a margine di molte di esse  
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
# compiling 

files `README.md` and `docs/index.html` are created from sources with the command:

    bash make-docs.sh

the `pdf` file can be obtained with the command:

    latexmk --pdf AnalisiUno

The `Makefile` should automate the previous commands.

# compilation with docker

    docker run -it -w /app -v "${PWD}:/app" ghcr.io/xu-cheng/texlive-full latexmk --pdf AnalisiUno -file-line-error -halt-on-error -interaction=nonstopmode

