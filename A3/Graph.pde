class Graph {
   float canvasw, canvash, sidebarw; 
   float x_origin, y_origin, yaxislength, xaxislength;
   ArrayList<DataPoint> dplist = new ArrayList<DataPoint>();
   int finalHeight;
   int numrows;
   float diameter;
   color col;
   boolean nomorelines;
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
     diameter = 500;
     col = color(22, 160, 133);
     nomorelines = false;
   }
   
  void display(){
      setupPoints();
      drawCanvas();
      drawAxis();
      //drawPieGraph();
      //drawLineGraph();
      //bartoPie();
  }
 
  void bartoPie(int r){
    for(int i = 0; i < dplist.size(); i++){
        DataPoint dp = dplist.get(i);
        dp.barheight2 = 2 * PI * (diameter/2) * (dp.degree / 360);
    } //make sure to reset when you go from pie to bar
    
    
    for(int i = 0; i < dplist.size(); i++) {
      DataPoint dp = dplist.get(i);  
      if((dp.barheight - r) > dp.barheight2){
        fill(col);
        rect(dp.pointx - 10, dp.pointy, 15, dp.barheight - r);
      }else{
        fill(col); //change to random colors later
        rect(dp.pointx - 10, dp.pointy, 15, dp.barheight2);
      }
    }
    
    
    
    
    //align bars?
    //curve bars
    //arrange bars into pie
    //fill in bars
    
  }
  
  void pietoBar(){
    setupPoints(); //resets bar heights
    
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
         dp.barheight = y_origin - dp.pointy;
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
    fill(col);
    
    for(int i = 0; i < dplist.size(); i++) {
      DataPoint dp = dplist.get(i);
      arc(canvasw/2, canvash/2, 300, 300, lastAngle, lastAngle+radians(dp.degree));
      lastAngle += radians(dp.degree);
    }
    
    
    DataPoint dp = dplist.get(0);
    fill(#474973);
    arc(canvasw/2, canvash/2 - 200, 300, 300, 0, radians(dp.degree));
    
  }
  
  void drawBarGraph(int k){
    fill(col);
    for(int i = 0; i < dplist.size(); i++) {
         DataPoint dp = dplist.get(i);
         //keep drawing bar graph until height is too much
         if(k < dp.barheight)
          rect(dp.pointx - 10, dp.pointy, 15, k);
         else 
           rect(dp.pointx - 10, dp.pointy, 15, dp.barheight);
    }
  }
  
  void drawLineGraph(boolean start, int j){
     
    float ewidth = 5;
    float eheight = 5;
     
     strokeWeight(.5);
     if(start){
         //draw points
         strokeWeight(1);
         fill(col);
         for(int i = 0; i < dplist.size(); i++) {
           DataPoint dp = dplist.get(i);
           ellipse(dp.pointx, dp.pointy, ewidth, eheight);
         }
         //draw lines
         for(int i = 0; i < dplist.size() - 1; i++) {
           DataPoint dp = dplist.get(i);
           DataPoint nextdp = dplist.get(i+1);
           line(dp.pointx, dp.pointy, nextdp.pointx, nextdp.pointy);
     }
     } else {
         //draw points
         strokeWeight(1);
         fill(col);
         ewidth += (j * 002);
         eheight -= (j *.5);
         if(eheight > .05 || ewidth < 9){
           for(int i = 0; i < dplist.size(); i++) {
             DataPoint dp = dplist.get(i);
             ellipse(dp.pointx, dp.pointy, ewidth, eheight);
           }
         } else nomorelines = true;
         /*
         for(int i = 0; i < dplist.size() - 1; i++) {
           //run this until nextdp point == dp, turn on linediss
           DataPoint dp = dplist.get(i);
           DataPoint nextdp = dplist.get(i+1);
           //y = mx + b
           float m =(dp.pointy - nextdp.pointy)/(dp.pointx - nextdp.pointx);
           float b = dp.pointy - (m * dp.pointx);
            
           //x y of the next dp will be on line
           line(dp.pointx, dp.pointy, nextdp.pointx - (m*j), nextdp.pointy - (m*j));
         }
         */
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
     
     fill(#474973);
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
    numrows = 15;
    
    for(int j = 0; j < numrows; j++){
       line(x_origin, y_origin - (j*35), canvasw - 50, y_origin - (j*35)); 
       fill(50);
       textSize(7);
       text((j),x_origin - 15, y_origin -( j * 35));
    }
    
    for(int i = 0; i < dplist.size(); i++){
       DataPoint dp = dplist.get(i);
       fill(50);
       textSize(7);
       text(dp.time, dp.pointx - 10, y_origin + 20);
    }    
  }
  
  //get total temperature values of all data points
  float getTotal(){
    float totalValue = 0;
    for(int i = 0; i < dplist.size(); i++){
      totalValue += dplist.get(i).temp;
    }
    return totalValue;
  }

  void parse(String[] lines) {
    for(int i = 1; i < lines.length; i++) {
      String[] data = split(lines[i], ",");
      DataPoint datapoint = new DataPoint(data[0], Float.parseFloat(data[1]));
      dplist.add(datapoint);
    }
    
    linebutton = new Button((int) canvasw + 40, 100, (int)(sidebarw * .70), 75, "Line Graph");
    barbutton = new Button((int) canvasw + 40, 250, (int)(sidebarw * .70), 75, "Bar Graph");
    piebutton = new Button((int) canvasw + 40, 400, (int)(sidebarw * .70), 75, "Pie Graph");
    /*
    for(int i = 0; i < dplist.size(); i++) {
      println("Time: " + dplist.get(i).time + " Temp: " + dplist.get(i).temp);
    }
    */
  }





}