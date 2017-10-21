class Graph {
   float canvasw, canvash, sidebarw; 
   float x_origin, y_origin, yaxislength, xaxislength;
   ArrayList<DataPoint> dplist = new ArrayList<DataPoint>();
   
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
      drawLineGraph();
  }
  
  void drawLineGraph(){
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
     strokeWeight(1);
     for(int i = 0; i < dplist.size(); i++) {
       DataPoint dp = dplist.get(i);
       ellipse(dp.pointx, dp.pointy, 5, 5);
     }
     
     strokeWeight(.5);
     for(int i = 0; i < dplist.size() - 1; i++) {
       DataPoint dp = dplist.get(i);
       DataPoint nextdp = dplist.get(i+1);

       line(dp.pointx, dp.pointy, nextdp.pointx, nextdp.pointy);
     }
     
     //run through arraylist and draw every point
    
  }
  
  void drawCanvas(){
     canvasw = width * .75;
     canvash = height;
     sidebarw = width *.25;
     x_origin = 50;
     y_origin = height - 50;  
    
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