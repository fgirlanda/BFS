
# Algoritmo di visita in ampiezza di un grafo 

Esercizio universitario per il corso di Algoritmi e Strutture Dati presso Università degli studi dell'Insubria







## Introduzione

Questo progetto serve come approfondimento di alcune delle conoscenze acquisite durante il corso di Algoritmi e Strutture Dati. L'obiettivo primario è quello di implementare visivamente un algoritmo di visita in ampiezza (BFS) su un grafo. Da questo concetto è stata sviluppata la logica e la struttura del codice, aprendo la strada a ulteriori approfondimenti sui concetti di grafo, di algoritmo e di implementazione. 
## Funzionalità

### Generazione nodi

Idea: generare delle posizioni casuali (PVector) e verificare la compatibilità con le posizioni esistenti, sulla base della dimensione prevista per il singolo nodo.

Per ogni posizione viene poi creato un nuovo nodo e aggiunto al grafo.


### Generazione lati

Idea: generare casualmente le connessioni, limitandone il numero, in ingresso e in uscita, per ogni singolo nodo attraverso due controlli, il primo sul nodo corrente, il secondo sui collegamenti originati da quest'ultimo.

### Algoritmo di visita in ampiezza

Idea: il classico ciclo while viene suddiviso in step (while -> if), ogni step viene eseguito al rilascio della barra spaziatrice.


Nota: nella generazione casuale del grafo, a volte risultano nodi singoli o sottografi isolati rispetto a quello principale, l'algoritmo di visita viene reiterato automaticamente su eventuali nodi ancora non considerati, fino ad esaurirli completamente.

### Grafica

Durante la generazione del grafo, per evitare sovrapposizioni tra lati e nodi, è stato implementato un controllo apposito.

Ad ogni step il nodo corrente viene colorato di verde, mentre i nodi presenti nella sua lista di adiacenza vengono colorati di blu e i lati associati in rosso. Al termine della visita si ottiene, in rosso, un albero di copertura per ogni sottografo presente.

### Slider

È possibile utilizzare lo slider per modificare il numero massimo di nodi da generare, il programma genera un nuovo grafo ogni volta che lo slider viene modificato

### Esecuzione automatica

Premendo il bottone "ESEGUI BFS" l'algoritmo verrà eseguito automaticamente


## Bug noti

- All'apertura del programma, facendo click su qualsiasi parte della finestra, il grafo viene rigenerato anche senza modificare lo slider (una sola volta)

- Grafica: se viene generato un grafo connesso, l'esecuzione automatica si ferma lasciando gli ultimi nodi in blu, anzichè verde

## Uso

- Installare Processing ([download](https://processing.org/download))
- Aprire uno qualsiasi dei file .pde
- Avviare il file Main
## Obiettivi futuri

- Possibilità di selezionare il nodo sorgente
- Possibilità di scegliere tra visualizzazione automatica/a step
- Implementazione algoritmo di visita in profondità (DFS)
## Autori

- [@dvdmarchetti](https://www.github.com/dvdmarchetti)
- [@fgirlanda](https://www.github.com/fgirlanda)

