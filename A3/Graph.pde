class Graph {
   float canvasw, canvash, sidebarw; 
   float x_origin, y_origin, yaxislength, xaxislength;
   ArrayList<DataPoint> dplist = new ArrayList<DataPoint>();
   int finalHeight;
   Button linebutton;
   Button barbutton;
   Button piebutton;
   
   //side bar buttons
   
   
   public Graph(){
     canvasw = width * .75;
     canvash = height;
     sidebarw = width *.25;
     x_origin = 50;
     y_origin = height - 50;
   }
  
  void parse(String[] lines) {
    for(int i = 1; i < lines.length; i++) {
      String[] data = split(lines[i], ",");
      DataPoint datapoint = new DataPoint(data[0], Float.parseFloat(data[1]));
      dplist.add(datapoint);
    }
    
    for(int i = 0; i < dplist.size(); i++) {
      println("Time: " + dplist.get(i).time + " Temp: " + dplist.get(i).temp);
    }
    
  }
  
  
  void display(){
     
      drawCanvas();
      drawAxis();
      setupPoints();
      drawLineGraph();
  }
  
  void setupPoints(){
    //divide axis length by how many data points there are
    int xproportion = Math.round(xaxislength) / dplist.size(); 
    int counter = 1;
     //set pointx and pointy for each datapoint (only happens once)
    for(int i = 0; i < dplist.size(); i++) {
         DataPoint dp = dplist.get(i);   
         dp.pointx = x_origin + (counter * xproportion);
         dp.pointy = y_origin - (dp.temp * yaxislength * .006);
         counter++;
     }
    
  }
  
  void drawBarGraph(int j){
    fill(22, 160, 133);
    for(int i = 0; i < dplist.size() - 1; i++) {
         DataPoint dp = dplist.get(i);
         //keep drawing bar graph until height is too much
         if(j < (y_origin - dp.pointy)){
           rect(dp.pointx - 10, dp.pointy, 20, j);
         }
    }
    
  }
  void drawLineGraph(){
     //draw points
     strokeWeight(1);
     for(int i = 0; i < dplist.size(); i++) {
       DataPoint dp = dplist.get(i);
       ellipse(dp.pointx, dp.pointy, 5, 5);
     }
     
     //draw connecting lines
     strokeWeight(.5);
     for(int i = 0; i < dplist.size() - 1; i++) {
       DataPoint dp = dplist.get(i);
       DataPoint nextdp = dplist.get(i+1);

       line(dp.pointx, dp.pointy, nextdp.pointx, nextdp.pointy);
     }    
  }
  
  void drawCanvas(){
     
     canvasw = width * .75;
     canvash = height;
     sidebarw = width *.25;
     x_origin = 50;
     y_origin = height - 50;  
     
     //create buttons
     //draw buttons
     
     
    strokeWeight(1);
      fill(255);
      rect(0, 0, canvasw, height); //canvas
      fill(117, 139, 151);
      rect(canvasw, 0, sidebarw, height); //sidebar
  }
  
  void drawAxis(){
    strokeWeight(2);
    line(x_origin, y_origin, canvasw - 50, y_origin); 
    line(x_origin, y_origin, x_origin, 50);
    xaxislength = canvasw - 100;
    yaxislength = y_origin - 50;
  }
  
}