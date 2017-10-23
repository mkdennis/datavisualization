import java.util.ArrayList;
Graph graph;


void setup(){
  size(1200, 600);
  background(255);
  frameRate(40);
  smooth();
  surface.setResizable(true);
  String[] lines = loadStrings("./data.csv");
  graph = new Graph();
  graph.parse(lines);
}

int j = 1;
int k = 0;
int r = 0;

void draw(){
    graph.display();
    graph.drawPieGraph();
    
    if(state == 1){
       graph.drawLineGraph(true, 0);
       j = 1;
    } else if(state == 2){
      graph.drawLineGraph(false, j++);
      if(graph.nomorelines) {
        graph.drawBarGraph(k);
        k += 3;
      }
    } else if(state == 3){
      graph.bartoPie(r);
      r += 4;
    } else if(state == 4){
      graph.drawPieGraph();
      //pietoBar();
    } else if(state == 5){
      //bartoLine();
      state = 1;
    }
    
}

int state = 1;

void mousePressed(){
     if(graph.linebutton.overRect()){
         state = 1; //start
     } else if(graph.barbutton.overRect() && state == 1){
        state = 2; //line to bar
     } else if(graph.piebutton.overRect() && state == 2){
        state = 3; //bar to pie
     } else if(graph.barbutton.overRect() && state == 3){
        state = 4; //pie to bar
     } else if (graph.linebutton.overRect() && state == 4){
        state = 5; // bar to line 
     }
     
    println("state: " + state);
}