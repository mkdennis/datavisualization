class Node{
  int id, id_connect;
  float mass, x, y;
  ArrayList<Edge> connected_nodes;
  Vector currentVelocity;
  
 float getEnergy(){
   //k = .5 * m * v^2
   float velocitySquared = currentVelocity.magnitude * currentVelocity.magnitude;
   float energy = .5 * mass * velocitySquared;
   return energy;
 }
  
 void addEdge(Edge e){
   this.connected_nodes.add(e); 
 }
  
  public Node(int a, int b, int c, int d, int e){
      id = a;
      mass = b;
      x = c;
      y = d;
      id_connect = e;
      connected_nodes = new ArrayList<Edge>();
      currentVelocity = new Vector();
  }
  
  public Node(int a, int b, int c, int d){
      id = a;
      mass = b;
      x = c;
      y = d;
      connected_nodes = new ArrayList<Edge>();
      currentVelocity = new Vector();
  }
  
  public Node() {
      connected_nodes = new ArrayList<Edge>();
      currentVelocity = new Vector();
  }
}