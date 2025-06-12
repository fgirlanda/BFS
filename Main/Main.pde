// Autori: Girlanda Francesco e Marchetti Davide
// Versione 1.1

import controlP5.*;

boolean esecuzioneAutomatica = false;
int N = 25;
int ultimaGenerazione = N;
final int dim = 25;
final int minD = 100;
final int maxD = 250;
final int dimUI = 100;
final int displayWidth = 1000;
final int displayHeight = 1000 + dimUI;
Grafo g = new Grafo();
ArrayList<PVector> posizioni = new ArrayList<PVector>();
Queue q = new Queue();

ControlP5 cp5;
Slider slider;

void settings(){
  size(displayWidth, displayHeight);
}

void setup(){
  background(255);
  generaGrafo();
  
  cp5 = new ControlP5(this);
  
  // Slider
  slider = cp5.addSlider("N")
                     .setPosition(50, 1020)
                     .setSize(300, 10)
                     .setRange(1, 50)     
                     .setDecimalPrecision(0)
                     .setValue(26)
                     .setNumberOfTickMarks(50)  
                     .setSliderMode(Slider.FLEXIBLE)
                     .showTickMarks(false);
  
  slider.getCaptionLabel().setVisible(false);
  slider.getValueLabel().setVisible(false);
  
  // Bottone esecuzione algoritmo automatica
  Button auto = cp5.addButton("automatic")
                   .setPosition(400, 1010)
                   .setSize(110, 30)
                   .setLabel("Esegui BFS");
  auto.getCaptionLabel().setFont(createFont("Verdana", 8));
  
  System.out.println("N >" + N + "\nultimaGenerazione >" + ultimaGenerazione);
}

void draw(){
  fill(255);           
  noStroke();
  rect(0, 1000, width, 100);
  fill(0);
  textAlign(CENTER, CENTER);
  text("Numero di nodi: " + N, 200, 1040);
  if(esecuzioneAutomatica){
    bfs();
    if(g.coperto() == null){
      esecuzioneAutomatica = false;
      frameRate(120);
    }
  }
}

void mouseReleased(){
  if(ultimaGenerazione != N){
    g.clear();
    posizioni.clear();
    q.clear();
    background(255);
    generaGrafo();
  }
}

void controlEvent(ControlEvent e) {
  if (e.isFrom("N")) { 
    fill(0);
    textAlign(CENTER, CENTER);
    text("Numero di nodi: " + N, 200, 1040);
  }
}

void automatic(){
  frameRate(10);
  esecuzioneAutomatica = true;
}



void generaGrafo(){
  ultimaGenerazione = N;
  // Generazione posizioni
  int count = 0;
  while(posizioni.size() <= N && count < 10000){
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
    background(255);
    generaGrafo();
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
