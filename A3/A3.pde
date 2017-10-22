import java.util.ArrayList;
Graph graph;


void setup(){
  size(1200, 600);
  background(255);
  frameRate(80);
  smooth();
  surface.setResizable(true);
  String[] lines = loadStrings("./data.csv");
  graph = new Graph();
  graph.parse(lines);
}

int j = 0;
void draw(){
  graph.display();
  //include conditional, when j is greater than height of bar stop
  //graph.drawBarGraph(j++);
}