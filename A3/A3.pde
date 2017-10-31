import java.util.ArrayList;
Graph graph;


void setup(){
  size(1300, 600);
  background(255);
  frameRate(100);
  smooth();
  surface.setResizable(true);
  String[] lines = loadStrings("./data.csv");
  graph = new Graph();
  graph.parse(lines);
}

int j = 1;
int k = 0;
int r = 0;
int s = 0;
int t = 0;
int p = 0;
float q = 0;
int z = 0;
int u = 0;
int a = 0;
float g = 0;
float x = 0;

void draw(){
    graph.display();
    //graph.drawPieGraph();
    if(state == 1){
       graph.drawLineGraph(true, 0);
       j = 1;
    } else if(state == 2){               //line to bar
      graph.drawLineGraph(false, j++);   //triggers flattening dot animation
      if(graph.nomorelines) {
        graph.drawBarGraph(k);           //draw bar bar graph downwards
        k += 3;
      }
    } else if(state == 3){ 
          if(graph.bp2){
            graph.bartoPie3();
          } else if(graph.bp1){
            graph.bartoPie2(q);
            q += .01;
          } else
            graph.bartoPie(r++);
            
          /*if(graph.bp5){
             graph.bartoPie6(z++);
          }
          else if(graph.bp4){
             graph.bartoPie5(q); 
             q += .01;
          }
          else if(graph.bp3){
             graph.bartoPie4(p);
             p+=4;
          }
          else if(graph.bp2){
            graph.bartoPie3(t++);
          }
          else if(graph.bp1){ //when bar resize is done, shrink width of bar to line         
            graph.bartoPie2(s++);         
          } else {
             graph.bartoPie(r); //shrink bars
             r += 4; 
          }
          */
    } else if(state == 4){
      if(graph.pb1){
          graph.pietoBar2(a++);
      } else {
        graph.pietoBar(g);
        g += .01;
      }
      //pietoBar();
    } else if(state == 5){
      if(graph.bl){
        graph.bartoLine2(x);
        x += .7;
      }
      graph.bartoLine(u++);
    }
}

int state = 1;

void resetTimer(){
    j = 1;
    k = 0;
    r = 0;
    s = 0;
    t = 0;
    p = 0;
    q = 0;
    z = 0;
    u = 0;
    a = 0;
    g = 0;
    x = 0;
    graph.resetbools();
}

void mousePressed(){
  
    if (graph.linebutton.overRect() && state == 4){
        state = 5; // bar to line 
     } else if(graph.barbutton.overRect() && state == 5){
         resetTimer();
         state = 2;
     } else if(graph.barbutton.overRect() && state == 1){
        state = 2; //line to bar
     } else if(graph.piebutton.overRect() && state == 2){
        state = 3; //bar to pie
     } else if(graph.barbutton.overRect() && state == 3){
        state = 4; //pie to bar
        k = 0;
     }
}