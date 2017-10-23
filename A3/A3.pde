import java.util.ArrayList;
Graph graph;


void setup(){
  size(1200, 600);
  background(255);
  frameRate(30);
  smooth();
  surface.setResizable(true);
  String[] lines = loadStrings("./data.csv");
  graph = new Graph();
  graph.parse(lines);
}

int j = 1;
int k = 0;

void draw(){
    graph.display();
    
    if(state == 1){
       graph.drawLineGraph(true, 0);
       j = 1;
    } else if(state == 3){
      graph.drawLineGraph(false, j++);
      if(graph.nomorelines) {
        graph.drawBarGraph(k);
        k += 3;
      }
    } else if(state == 4){
      graph.bartoPie();
    }
    
}

int state = 1;

void mousePressed(){
     if(graph.linebutton.overRect()){
         state = 1;
     } else if(graph.barbutton.overRect()){
        state = 3; 
     } else if(graph.piebutton.overRect()){
        state = 4; 
     }
}