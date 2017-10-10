class Diagram {
   
  ArrayList<Node>node_list = new ArrayList<Node>();
  color node_color = #FFFFFF;
  PVector coulombForce;
  
  float coulomb = 20;
  float hooke = 6;
  float dampening = 1.0; 
  float timeStep = .03;
  
  Node selectedNode = null;
  float startX, startY;
  float time = 0;
  
  float dampRatio = .9;
  
  
  void mousePressed(){
    selectedNode = null;
    for(Node node : node_list){
      if(mouseHover(node)){
       selectedNode = node;
       startX = selectedNode.x;
       startY = selectedNode.y;
       time = millis();
       break;
      }
    }
  }
  
  void mouseReleased(){
    if(selectedNode != null){
      float deltaX = selectedNode.x - startX;
      float deltaY = selectedNode.y - startY;
      float deltaT = millis() - time;
      PVector velocity = new PVector(deltaX, deltaY);
      selectedNode.nextVelocity = velocity.div(deltaT*1000*timeStep);
      selectedNode = null;  
    }
  }
  
      
  float getTotalEnergy(){
    float energy = 0;
    for(int i = 0; i < node_list.size(); i++){
      Node node = node_list.get(i);
      energy += node.getEnergy();
    }
    return energy;
  }
  
  PVector getTotalForce(Node node){
    PVector coulomb = getCoulombForce(node);
    PVector hooke = getHookesForce(node);
    return PVector.add(coulomb, hooke);
  }
  
  PVector getDirection(Node node, Node otherNode){
      float deltaX = node.x - otherNode.x;
      float deltaY = node.y - otherNode.y;
      PVector direction = new PVector(deltaX, deltaY);
      return direction;
  }
   
  PVector getCoulombForce(Node node){
    PVector totalForce = new PVector(0,0);
    for(int i = 0; i < node_list.size(); i++){
      Node otherNode = node_list.get(i); 
      if(otherNode.id != node.id){
      PVector direction = getDirection(node, otherNode);
      //f = c * q1 * q2 / distance^2
      float d = direction.mag();
      float charge = node.mass * otherNode.mass;
      float mag = coulomb * charge / (d * d);
      direction.setMag(mag);
      totalForce.add(direction);
      }
    }
    return totalForce;  
  }
  
  PVector getHookesForce(Node node){
    PVector totalForce = new PVector(0,0);
    for(int i = 0; i < node.connected_nodes.size(); i++){
      Edge e = node.connected_nodes.get(i);
      Node otherNode = e.node;
      //f = -k * delta 
      PVector direction = getDirection(node, otherNode);
      float distance = direction.mag();
      //may need to swap around?
      float delta = distance - e.length;
      float mag = -hooke * delta;
      direction.setMag(mag);
      totalForce.add(direction);
    }
    return totalForce;
  }
  
  void drawDiagram(){
    drawEdges();
    drawNodes();
    drawSliders();
  }
  
  void drawSliders(){
    //slider for size, hook, coul, damp, time step
    Slider sizeslider = new Slider(20, height-40);
    Slider hookslider = new Slider(20, height-80);
    Slider coulslider = new Slider(20, height-120);
    
    sizeslider.drawSlider();
    hookslider.drawSlider();
    coulslider.drawSlider();
  }
   
  void drawEdges(){
    for(int i = 0; i < node_list.size(); i++){
      Node start = node_list.get(i);
      for(int j = 0; j < start.connected_nodes.size(); j++){
        Edge e = start.connected_nodes.get(j);
        Node end = e.node;
        strokeWeight(1);
        float distance = dist(start.x, start.y, end.x, end.y);
        if(distance < e.length){
          float maxWeight = 25;
          float pct = (e.length-distance)/e.length;
          strokeWeight(maxWeight * pct);  
        }
        line(start.x, start.y, end.x, end.y); 
      }
    }
    strokeWeight(1);
  }
   
  void drawNodes() {
      updateNodePositions();
      for(int i = 0; i < node_list.size(); i++){   
        Node node = node_list.get(i);
        fill(colorPicker(node));
        ellipse(node.x, node.y, node.diam, node.diam);
        showLabel(node);
      }
  }
   
  void updateNodePositions(){
    for(int i = 0; i < node_list.size(); i++){   
        Node node = node_list.get(i);
        PVector totalForce = getTotalForce(node);
        PVector acceleration = totalForce.div(node.mass);
        node.acceleration = acceleration;
        node.nextX = node.getNextX(timeStep);
        node.nextY = node.getNextY(timeStep);
        node.nextVelocity = node.getNextVelocity(timeStep);
        node.nextVelocity = node.nextVelocity.mult(dampRatio);
        //if new x or y position is outside of the canvas, flip velocity
        
        //add in dampening
    }
    if(selectedNode != null){
      
      selectedNode.acceleration = new PVector(0,0);
      selectedNode.nextX = mouseX;
      selectedNode.nextY = mouseY;
      selectedNode.nextVelocity = new PVector(0,0);   
      if(outBounds(selectedNode)){
          outBoundsReset(selectedNode);
      }
    }
    for(int i = 0; i < node_list.size(); i++){
      //actually update the positions
      Node node = node_list.get(i);
      if(outBounds(node)){
          outBoundsReset(node);
      }
      node.x = node.nextX;
      node.y = node.nextY;
      node.velocity = node.nextVelocity;
      node.velocity = node.nextVelocity.mult(dampRatio);
    }
  }
  
boolean outBounds(Node node) {
   if(node.nextX - (node.diam/2) < 0 || node.nextX + (node.diam/2) > width || 
       node.nextY + (node.diam/2) > height || node.nextY - (node.diam/2) < 0){ 
        return true;
      }
       return false;
}

void outBoundsReset(Node node) {
    if(node.nextX - node.diam/2 <= 0){
      node.nextX = (node.diam/2);
      node.nextVelocity.x = node.nextVelocity.x * -1;
    } else if (node.nextX + node.diam/2 > width){
      node.nextX = width - (node.diam/2);
      node.nextVelocity.x = node.nextVelocity.x * -1;
    } 
    
    if (node.nextY + node.diam/2 >= height) {
      node.nextY = height - (node.diam/2);
      node.nextVelocity.y = node.nextVelocity.y * -1;
    } else if (node.nextY - node.diam/2 < 0) {
      node.nextY = (node.diam/2);
      node.nextVelocity.y = node.nextVelocity.y * -1;
    }  
}

   
  boolean mouseHover(Node node) {
    if(dist(mouseX, mouseY, node.x, node.y) <= (node.diam)/2){
         return true; 
    }
       return false;
  }
   
  void showLabel(Node node) {
    if(mouseHover(node)){
        fill(#000000);
        textAlign(CENTER,CENTER);
        text("ID: " + node.id + " Mass: " + node.mass, node.x, node.y);
    } 
  }
   
   
  color colorPicker(Node node) {
    if(mouseHover(node)){
            node_color = #cc7c7c; //pink
            
        } else {
            node_color = #FFFFFF;
        }
    return node_color;
  }
 
  void createEdges(String[] data){
    int checkpoint = Integer.parseInt(data[0]) + 2;
    for(int j = checkpoint; j < data.length; j++) {
      String[] line = split(data[j], ","); 
      int id = Integer.parseInt(line[0]);
      int connect_id = Integer.parseInt(line[1]);
      int springLength = Integer.parseInt(line[2]);
      Node startNode = getNodeById(id);
      Node endNode = getNodeById(connect_id);
      if(startNode != null && endNode != null){
        Edge e1 = new Edge(endNode, springLength);
        startNode.addEdge(e1);
        Edge e2 = new Edge(startNode, springLength);
        endNode.addEdge(e2);
      }
    }
  } 
  
  boolean nodeExists(int searchId){
    Node node = getNodeById(searchId);
    return node != null;
  }
   
  Node getNodeById(int id){
    for(Node node : node_list){
      if(node.id == id){
        return node;  
      }
    }
    return null;  
  }
}