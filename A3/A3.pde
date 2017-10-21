import java.util.ArrayList;
Graph graph;


void setup(){
  size(1200, 600);
  background(255);
  surface.setResizable(true);
  String[] lines = loadStrings("./data.csv");
  graph = new Graph();
  graph.parse(lines);
}


void draw(){
  graph.display();
}