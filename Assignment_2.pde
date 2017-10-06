import java.util.Collections;
import java.util.concurrent.ThreadLocalRandom;

Diagram diagram;

void setup()
{
  size(600, 600);
  String[] data = loadStrings("./data1.csv");
  diagram = createNodes(data);
  diagram.createEdges(data);

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
    int checkpoint = node_count + 2; //start of second half of data
    
    for(int i = 1; i < node_count + 1; i++){
      String[] line = split(data[i], ",");
      int id = Integer.parseInt(line[0]);
      int mass = Integer.parseInt(line[1]);
      int x = ThreadLocalRandom.current().nextInt(100, width - 100); //change later
      int y = ThreadLocalRandom.current().nextInt(100, height - 100);//change later
      Node node = new Node(id, mass, x, y);
      diagram.node_list.add(node);
    }
    
    //is 1 connected 2
    //  yes: don't do anything <- shouldn't happen though
    //  no: add edge to 1
    //is 2 connected to 3
    //is 3 connected to 1
    //  no: add edge to 3 (do i have to add edge to 1 as well?)
    //after all edges are added, reprocess every nodes x, y position based on edges
    //draw root node first, draw second node based on relationship to root
    //  if no relationship, draw anywhere
    
    /*
    //parsing second half of file - node edge relationships + length of edge
    for(int j = checkpoint; j < data.length; j++) {
      String[] line = split(data[j], ","); 
      int id = Integer.parseInt(line[0]);
      int id_connect = Integer.parseInt(line[1]);
      int x = ThreadLocalRandom.current().nextInt(100, width - 100); //change later
      int y = ThreadLocalRandom.current().nextInt(100, height - 100);//change later
    //run through node list, check if edge relationship exists, if not: add node ID + edge mass
      //if nodelist has id, add edge relationship
      //  if edge to be added doesn't exist, create Node, then add edge
      
      if(diagram.node_list.isEmpty()){ //can probably take this conditional out
        Node node = new Node(id, 1, x, y); //default mass = 1;
        diagram.node_list.add(node);
      } else {
          if(!diagram.nodeExists(id)){ //check if new node exists in master diagram node list
            Node node = new Node(id, 1, x, y);
            diagram.node_list.add(node);
          } else { //if new node already exists in master node list, move onto child stuff
            
            
          }
      }
    }
    */
    
    return diagram;
}