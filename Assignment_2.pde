Diagram diagram;

void setup()
{
  size(600, 600);
  String[] data = loadStrings("./data1.csv");
  diagram = createNodes(data);
  diagram.createEdges(data);
}

void mousePressed() {
  diagram.mousePressed();
}

void mouseReleased() {
  diagram.mouseReleased();
}

void draw()
{
  clear();  
  background(255);
  diagram.drawDiagram();
}

Diagram createNodes(String[] data){
    Diagram diagram = new Diagram();  
    int node_count = Integer.parseInt(data[0]);
    for(int i = 1; i < node_count + 1; i++){
      String[] line = split(data[i], ",");
      int id = Integer.parseInt(line[0]);
      int mass = Integer.parseInt(line[1]);
      float x = random(100, width - 100); //change later
      float y = random(100, height - 100);//change later
      Node node = new Node(id, mass, x, y);
      diagram.node_list.add(node);
    }   
    return diagram;
}