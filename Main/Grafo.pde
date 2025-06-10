class Grafo{
  ArrayList<Nodo> vertici;
  ArrayList<Lato> lati;
  
  Grafo(){
    vertici = new ArrayList<Nodo>();
    lati = new ArrayList<Lato>();
  }
  
  void addNodo(Nodo r){
    vertici.add(r);
  }
  
  void addLato(Lato l){
    lati.add(l);
  }
  
  Nodo sorgente(){
    return vertici.get((int)random(vertici.size()));
  }
  
  Nodo coperto(){
    for(Nodo n: this.vertici){
      if(!n.visitato) return n;
    }
    return null;
  }
  
  void clear(){
    this.vertici.clear();
    this.lati.clear();
  }
}
