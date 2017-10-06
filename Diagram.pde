class Diagram {
  
  ArrayList<Node>node_list = new ArrayList<Node>();
  color node_color = #FFFFFF;
  
  float getTotalEnergy(){
    float energy = 0;
    for(int i = 0; i < node_list.size(); i++){
      Node node = node_list.get(i);
      energy += node.getEnergy();
    }
    return energy;
  }
  
  void drawDiagram(){
    drawEdges();
    drawNodes();
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
          float maxWeight = 50;
          float pct = distance/e.length;
          strokeWeight(maxWeight * pct);  
        }
        line(start.x, start.y, end.x, end.y); 
      }
    }
    strokeWeight(1);
  }
  
  void drawNodes() {
      for(int i = 0; i < node_list.size(); i++){   
        Node node = node_list.get(i);
        float diameter = node.mass * 50; //should be proportional to screen size
        fill(colorPicker(node));
        ellipse(node.x, node.y, diameter, diameter);
        showLabel(node);
      }
  }
  
  boolean nodeExists(int search_id){
    for(int i = 0; i < node_list.size(); i++){
      if(node_list.get(i).id == search_id)
        return true;
    }
    return false;
  }
  
  
  boolean mouseHover(Node node) {
    if(dist(mouseX, mouseY, node.x, node.y) <= (node.mass * 50)/2){
         return true; 
    }
       return false;
  }
  
  void showLabel(Node node) {
    if(mouseHover(node)){
        fill(#000000);
        textAlign(CENTER,CENTER);
        text("ID: " + node.id + "\nMass: " + node.mass, node.x, node.y);
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
    int checkpoint = Integer.parseInt(data[0]) + 2; //start of second half of data
    for(int j = checkpoint; j < data.length; j++) {
      String[] line = split(data[j], ","); 
      int id = Integer.parseInt(line[0]);
      int connect_id = Integer.parseInt(line[1]);
      int springLength = Integer.parseInt(line[2]);
      println("ID "+id);
      println("connect "+connect_id);
      println("springLength "+springLength);
      //add edge to node_list[node @ id] 
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
  
  Node getNodeById(int id){
    for(Node node : node_list){
      if(node.id == id){
        return node;  
      }
    }
    return null;  
  }
}