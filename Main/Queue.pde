class Queue{
  ArrayList<Nodo> coda;
  
  Queue(){
    this.coda = new ArrayList<Nodo>();
  }
  
  Nodo front(){
    return coda.get(0);
  }
  
  void enqueue(Nodo s){
    coda.add(s);
  }
  
  void dequeue(){
    coda.remove(0);
  }
  
  boolean isEmpty(){
    return coda.size() == 0;
  }
}
