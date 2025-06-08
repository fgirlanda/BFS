// Autori: Girlanda Francesco e Marchetti Davide
// Versione 1.0

final int N = 50;
final int dim = 25;
final int minD = 100;
final int maxD = 250;
final int dimUI = 100;
final int displayWidth = 1000;
final int displayHeight = 1000 + dimUI;
Grafo g = new Grafo();
ArrayList<PVector> posizioni = new ArrayList<PVector>();

Queue q = new Queue();

void settings(){
  size(displayWidth, displayHeight);
}

void setup(){
  background(255);
  // Generazione posizioni
  int count = 0;
  while(posizioni.size() <= N && count < 1000){
    boolean troppoVicino = false;
    float x = random(50, width - 50);
    float y = random(50, height - 50 - dimUI);
    PVector nP = new PVector(x, y);
    
    for(PVector esistente: posizioni){
      float dist = PVector.dist(nP, esistente);
      if(dist<minD){
        troppoVicino = true;
        break;
      }
    }
    
    if(!troppoVicino) posizioni.add(nP);
    count++;
  }
  
  // Generazione nodi
  int id = 0;
  for(PVector p: posizioni){
    Nodo r = new Nodo(id++, p);
    g.addNodo(r);
  }
  
  // Generazione lati
  for(Nodo n1: g.vertici){
    if(n1.connesso()) continue;
    PVector pos1 = n1.pos;
    int connessioni = 0;
    for(Nodo n2: g.vertici){
      if(n2 == n1 || n2.connesso()) continue;
      if(connessioni == 2) break;
      PVector pos2 = n2.pos;
      float dist = PVector.dist(pos1, pos2);
      if(dist >= maxD) continue;
      
      if(!intersecaNodo(n1, n2)){
        Lato l = new Lato(n1, n2);
        g.addLato(l);
        n1.addVicino(n2);
        stroke(0);
        line(pos1.x, pos1.y, pos2.x, pos2.y);
        connessioni++;
      }
    }
  }
  
  // Init disegno
  for(Nodo n: g.vertici){
    n.disegna(255, 255, 255);
  }
  
  // Init BFS
  Nodo sorgente = g.sorgente();
  q.enqueue(sorgente);
}


// Algoritmo BFS
void bfs(){
  if(!q.isEmpty()){
    Nodo current = q.front();
    q.dequeue();
    current.visita();
    for(Nodo w: current.adiacenza()){
      if(w.visitato) continue;
      w.visita();
      q.enqueue(w);
      
      // Disegno
      stroke(255,0,0);
      line(current.pos.x, current.pos.y, w.pos.x, w.pos.y);
      w.disegna(0, 0, 255);
    }
    current.disegna(0,255,0);
  }else{
    // Eventuali nodi isolati/sotto-grafi
    Nodo rimasto = g.coperto();
    if(rimasto != null) q.enqueue(rimasto);
  }
}

// Input
void keyReleased(){
  if (key == ' '){
     bfs();
  }
  if (key == 'a'){
    g.vertici.clear();
    g.lati.clear();
    posizioni.clear();
    setup();
  }
}

// Funzione controllo intersezioni
boolean intersecaNodo(Nodo a, Nodo b){
  PVector pos1 = a.pos;
  PVector pos2 = b.pos;
  PVector ab = PVector.sub(pos1, pos2);
  
  float minX = min(pos1.x, pos2.x);
  float maxX = max(pos1.x, pos2.x);
  float minY = min(pos1.y, pos2.y);
  float maxY = max(pos1.y, pos2.y);
  for(Nodo c: g.vertici){
    if(c == a || c == b) continue;
    if(c.pos.x <= minX - dim || c.pos.x >= maxX + dim) continue;
    if(c.pos.y <= minY - dim || c.pos.y >= maxY + dim) continue;
    PVector ac = PVector.sub(pos1, c.pos);
    float ipotenusa = ac.mag();
    float theta = PVector.angleBetween(ab, ac);
    float dist = ipotenusa * sin(theta);
    if(dist < dim/2) return true;
  }
  return false;
}

void draw(){}
