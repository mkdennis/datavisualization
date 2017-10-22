class Graph {
   float canvasw, canvash, sidebarw; 
   float x_origin, y_origin, yaxislength, xaxislength;
   ArrayList<DataPoint> dplist = new ArrayList<DataPoint>();
   int finalHeight;
   float diameter;
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
     diameter = 300;
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
      //drawPieGraph();
      //drawLineGraph();
      barToPie();
  }
  
  void barToPie(){
    for(int i = 0; i < dplist.size(); i++){
        DataPoint dp = dplist.get(i);
        dp.barheight = 2 * PI * (diameter/2) * (dp.degree / 360);
    }
    
    for(int i = 0; i < dplist.size(); i++) {
      DataPoint dp = dplist.get(i);  
      rect(dp.pointx - 10, dp.pointy, 20, dp.barheight);
    }
    
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
     
     for(int i = 0; i < dplist.size(); i++) {
         DataPoint dp = dplist.get(i);
         dp.degree = (360 * dp.temp) / getTotal();
         //println("temp: " + dp.temp + " degree: " + dp.degree);
     }
    
  }
  
  void drawPieGraph() {
    
    float lastAngle = 0;
    fill(#317c4f);
    for(int i = 0; i < dplist.size(); i++) {
      DataPoint dp = dplist.get(i);
      arc(canvasw/2, canvash/2, 300, 300, lastAngle, lastAngle+radians(dp.degree));
      lastAngle += radians(dp.degree);
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
     println("sidebarw: " + sidebarw);
     Button linebutton = new Button((int) canvasw + 40, 50, (int)(sidebarw * .70), 75, "Line Graph");
     Button barbutton = new Button((int) canvasw + 40, 200, (int)(sidebarw * .70), 75, "Bar Graph");
     Button piebutton = new Button((int) canvasw + 40, 350, (int)(sidebarw * .70), 75, "Pie Graph");
     fill(117, 139, 151);
     rect(canvasw, 0, sidebarw, height); //sidebar
     
     linebutton.display();
     barbutton.display();
     piebutton.display();
     
    strokeWeight(1);
      fill(255);
      rect(0, 0, canvasw, height); //canvas
     
  }
  
  void drawAxis(){
    line(x_origin, y_origin, canvasw - 50, y_origin); 
    line(x_origin, y_origin, x_origin, 50);
    xaxislength = canvasw - 100;
    yaxislength = y_origin - 50;
  }
  
  float getTotal(){
    float totalValue = 0;
    for(int i = 0; i < dplist.size(); i++){
      totalValue += dplist.get(i).temp;
    }
    return totalValue;
  }
}