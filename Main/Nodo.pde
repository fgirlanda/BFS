class Nodo{
  int val;
  PVector pos;
  ArrayList<Nodo> vicini;
  boolean visitato = false;
  
  final int raggio = 25;
  
  Nodo(int val, PVector pos){
    this.val = val;
    this.pos = pos;
    this.vicini = new ArrayList<Nodo>();
  }
  
  void addVicino(Nodo w){
    this.vicini.add(w);
    w.vicini.add(this);
  }
  
  void visita(){
    this.visitato = true;
  }
  
  ArrayList<Nodo> adiacenza(){
    return vicini;
  }
  
  void disegna(int r, int g, int b){
    color c = color(r, g, b);
    fill(c);
    ellipse(this.pos.x, this.pos.y, raggio, raggio);
  }
  
  boolean connesso(){
    return vicini.size() >= 3;
  }
  
}
