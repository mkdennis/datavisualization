class Node{
  int id;
  float mass, x, y, c, diam, size; //c = coulomb's constant
  ArrayList<Edge> connected_nodes;
  PVector acceleration;
  PVector velocity;
  PVector nextVelocity;
  float nextX, nextY;
 
PVector getNextVelocity(float timeStep){
  //currentVelocity = integral of (a * dt) 
  PVector aDeltaT = acceleration.mult(timeStep);
  PVector nextVelocity = PVector.add(velocity, aDeltaT);
  return nextVelocity;
}
 
float getNextX(float timeStep){
  //.5 * a (dt)squared + vt + old position
  float acc = .5 * acceleration.x * timeStep * timeStep;
  float vel = velocity.x * timeStep;
  return acc + vel + x;
}

float getNextY(float timeStep){
  float acc = .5 * acceleration.y * timeStep * timeStep;
  float vel = velocity.x * timeStep;
  return acc + vel + y;
}
 
 float getEnergy(){
   //k = .5 * m * v^2
   float velocitySquared = velocity.mag() * velocity.mag();
   float energy = .5 * mass * velocitySquared;
   return energy;
 }
   
 void addEdge(Edge e){
   this.connected_nodes.add(e); 
 }
   
 public Node(int id, int mass, float x, float y){
      this.id = id;
      this.mass = mass;
      this.x = x;
      this.y = y;
      connected_nodes = new ArrayList<Edge>();
      velocity = new PVector();
      nextVelocity = new PVector();
      acceleration = new PVector();
      nextX = x;
      nextY = y;
      size = .0001;
      diam = mass * size *(width * height);
  }
}