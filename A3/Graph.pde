class Graph {
   float canvasw, canvash, sidebarw; 
   float x_origin, y_origin, yaxislength, xaxislength;
   ArrayList<DataPoint> dplist = new ArrayList<DataPoint>();
   int finalHeight;
   int numrows;
   float diameter;
   color col;
   boolean nomorelines;
   boolean bp1;
   boolean bp2;
   boolean bp3;
   boolean bp4;
   boolean bp5;
   boolean pb1;
   boolean pb2;
   boolean bl;
   Button linebutton;
   Button barbutton;
   Button piebutton;
   
   //side bar buttons
   
   
   public Graph(){
     canvasw = width * .75;
     canvash = height;
     sidebarw = width * 25;
     x_origin = 50;
     y_origin = height - 50;
     diameter = 300;
     col = color(22, 160, 133);
     nomorelines = false;
     bp1 = false;
     bp2 = false;
     bp3 = false;
     bp4 = false;
     bp5 = false;
     pb1 = false;
     pb2 = false;
     bl = false;
   }
   
  void display(){
      setupPoints();
      drawCanvas();
      drawAxis();
      //drawPieGraph();
      //drawLineGraph();
      //bartoPie();
  }
  
  void resetbools(){
       nomorelines = false;

      bp1 = false;
     bp2 = false;
     bp3 = false;
     bp4 = false;
     bp5 = false;
     pb1 = false;
     pb2 = false;
  }
   
  void bartoLine(int u){
    for(int i = 0; i < dplist.size(); i++) {
      DataPoint dp = dplist.get(i);  
      if((dp.barheight - u) > 1){
        fill(col);
        rect(dp.pointx - 10, dp.pointy, 15, dp.barheight - u);
      } else if(i == dplist.size() - 1){
        bl = true;
        }
      }
  }
  
  void bartoLine2(float z){
      float angle;  
      fill(col);
       for(int i = 0; i <dplist.size(); i++){
            DataPoint dp = dplist.get(i);
           ellipse(dp.pointx + 5, dp.pointy, 5, 5);
       }

      
      for(int i = 0; i <dplist.size() - 1; i++){
            DataPoint dp = dplist.get(i);
            DataPoint dpnext = dplist.get(i + 1);
          
            angle = atan(radians(abs(dp.pointy - dpnext.pointy)/abs(dpnext.pointx - dp.pointx)));
            if(dp.pointx + 5 + cos((angle)) * z < dpnext.pointx)
              line(dp.pointx + 5, dp.pointy, dp.pointx + 5 + cos(angle) * z, dp.pointy + sin(angle) * z);
            else
              line(dp.pointx + 5, dp.pointy, dpnext.pointx + 5, dpnext.pointy);
        }
  }
 
 //decrease height of bars
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
      } else{
        fill(col); //change to random colors later
        rect(dp.pointx - 10, dp.pointy, 15, dp.barheight2);
        bp1 = true;
      }
    }
  }
  
  //shorten bar width (maybe change to draw rectangle on side of rectangle?)
  void bartoPie2(int s){
      fill(col);
      float barwidth = 15 - (s * .3);
      for(int i = 0; i < dplist.size(); i++) {
        DataPoint dp = dplist.get(i);
        if(barwidth > 0){
          fill(col);
          rect(dp.pointx - 10, dp.pointy, barwidth, dp.barheight2);
        } else{
          strokeWeight(3);
          line(dp.pointx - 10, dp.pointy, dp.pointx - 10, dp.pointy + dp.barheight2);
          bp2 = true;
        }
      } 
      
  }
  
 //draw triangle slices
  void bartoPie3(int t) {
      fill(col);
      for(int i = 0; i < dplist.size(); i++){
         DataPoint dp = dplist.get(i);
         dp.slicex = dp.pointx + t;
         dp.slicey = (dp.pointy + dp.pointy + dp.barheight2)/2;
         if((dp.pointx + t) < (dp.pointx + diameter/2))
           triangle(dp.pointx, dp.pointy, dp.pointx, dp.pointy + dp.barheight2, dp.slicex, dp.slicey);
         else{
           triangle(dp.pointx, dp.pointy, dp.pointx, dp.pointy + dp.barheight2, dp.pointx + (diameter/2), (dp.pointy + dp.pointy + dp.barheight2)/2);
           bp3 = true;
         }
         //arc(dp.pointx, dp.pointy + (barheight2/2), 40, 40,
      }
      
  }
  
  //draw arcs
  void bartoPie4(int p) {
    fill(col);
    for(int i = 0; i < dplist.size(); i++){
      DataPoint dp = dplist.get(i);
      dp.arcstart = atan( (dp.barheight2 / 2)/ (diameter/2) );
      triangle(dp.pointx, dp.pointy, dp.pointx, dp.pointy + dp.barheight2, dp.pointx + (diameter/2), (dp.pointy + dp.pointy + dp.barheight2)/2);
      if(p < diameter)
        arc(dp.slicex, dp.slicey, p, p, PI - dp.arcstart, PI - dp.arcstart + radians(dp.degree));
      else{ 
        arc(dp.slicex, dp.slicey, diameter, diameter, PI - dp.arcstart, PI - dp.arcstart + radians(dp.degree));
        bp4 = true;
      }

    }
  }
  
  void setRandomColors(){
    for(int i = 0; i < dplist.size(); i++){
      DataPoint dp = dplist.get(i);
      dp.r = int(random(0, 255));
      dp.g = int(random(0, 255));
      dp.b = int(random(0, 255));
    }
     
  }
  
  //move slices to center
  void bartoPie5(float q){
    for(int i = 0; i < dplist.size(); i++){
    
      DataPoint dp = dplist.get(i);
      if(dp.slicey > canvash/2 - 3 && dp.slicey < canvash/2 + 3){
        if(dp.slicex > canvasw/2 - 3 && dp.slicex < canvasw/2 + 3){
          if(i == dplist.size() - 1){
              bp5 = true;
          }
          fill(dp.r, dp.g, dp.b);
          arc(dp.slicex, dp.slicey, diameter, diameter, PI - dp.arcstart, PI - dp.arcstart + radians(dp.degree));
          continue;
        }
      }
      
      if(dp.slicex < canvasw / 2){
          if(dp.slicex + q < canvasw / 2){
            dp.slicex += q;
          }
      } else if(dp.slicex > canvasw / 2){
        if(dp.slicex - q > canvasw / 2){
           dp.slicex -= q;
        }
      }
      
     
      if(dp.slicey > canvash/2){
          if(dp.slicey - q > canvash / 2){
            dp.slicey -= q;
          } 
      } else if(dp.slicey < canvash/2) {
          if(dp.slicey + q < canvash/2) {
             dp.slicey += q;
          }
      }
            
      fill(dp.r, dp.g, dp.b);
      arc(dp.slicex, dp.slicey, diameter, diameter, PI - dp.arcstart, PI - dp.arcstart + radians(dp.degree));
    }
   
  }
  
  void bartoPie6(int z){
    float lastAngle = radians(270);  
    
    for(int i = 0; i < dplist.size(); i++){
        DataPoint dp = dplist.get(i);
        dp.slicex = canvasw/2;
        dp.slicey = canvash/2;
        fill(dp.r, dp.g, dp.b);
        float startangle = (PI - dp.arcstart) + radians(z);
        float endangle = PI - dp.arcstart + radians(dp.degree) + radians(z);
        if(startangle < lastAngle)
          arc(dp.slicex, dp.slicey, diameter, diameter, startangle, endangle);
        else{
          arc(dp.slicex, dp.slicey, diameter, diameter, lastAngle, lastAngle + radians(dp.degree));
          dp.start = lastAngle;
          lastAngle += radians(dp.degree);
          dp.end = lastAngle;
        }

        
        //move slice to base position (startangle = radians(270);
        //increase start angle and end angle until in correct position 
    }
      
    /*
    rotate each arc until in correct position (how to determine this?)
    for(int i = 0; i < dplist.size(); i++){
      DataPoint dp = dplist.get(i);  
      arc(dp.slicex, dp.slicey, diameter, diameter, PI - arcstart, PI - arcstart + radians(dp.degree));
    }
    */
    
  }
    
  void pietoBar(float q){
    //resets bar heights
    for(int i = 0; i < dplist.size(); i++){
      DataPoint dp = dplist.get(i);
      
      if(dp.slicey > dp.pointy - 10 && dp.slicey < dp.pointy + 10){
        if(dp.slicex > dp.pointx - 10 && dp.slicex < dp.pointx + 10){
          if(i == dplist.size() - 1){
              pb1 = true;
          }
          fill(dp.r, dp.g, dp.b);
          arc(dp.slicex, dp.slicey, diameter, diameter, dp.start, dp.end);
          continue;
        }
      }
      
      if(dp.pointx > dp.slicex){
          if(dp.slicex + q < dp.pointx){
            dp.slicex += q;
          }
      } else if(dp.pointx < dp.slicex){
        if(dp.slicex - q > dp.pointx){
           dp.slicex -= q;
        }
      }
      
      if(dp.pointy < dp.slicey){
          if(dp.slicey - q > dp.pointy){
            dp.slicey -= q;
          } 
      } else if(dp.pointy > dp.slicey) {
          if(dp.slicey + q < dp.pointy) {
             dp.slicey += q;
          }
      }
            
      fill(dp.r, dp.g, dp.b);
      arc(dp.slicex, dp.slicey, diameter, diameter, dp.start, dp.end);
    }
    
  }
  
  void pietoBar2(int q){
    
    for(int i = 0; i < dplist.size(); i++){
      DataPoint dp = dplist.get(i);
      fill(col);
      arc(dp.slicex, dp.slicey, diameter - q, diameter - q, dp.start, dp.end);
      drawBarGraph(q);
    }
    
    
    /*
    for(int i = 0; i < dplist.size(); i++){
      DataPoint dp = dplist.get(i);
      if(dp.end < radians(180)){
        dp.end += radians(q);
        dp.start += radians(q);
      } else if(dp.end > radians(180)){
        dp.end -= radians(q);
        dp.start -= radians(q);
      }
      println("dp.end: " + dp.end + " dp.start: " + dp.start);

       fill(dp.r, dp.g, dp.b);
       arc(dp.slicex, dp.slicey, diameter, diameter, dp.start, dp.end);
    }
    */
  }
  
  void setupPoints(){
    //divide axis length by how many data points there are
    int xproportion = Math.round(xaxislength) / dplist.size(); 
    int counter = 1;
     //set pointx and pointy for each datapoint (only happens once)
    for(int i = 0; i < dplist.size(); i++) {
         DataPoint dp = dplist.get(i);   
         dp.pointx = x_origin + (counter * xproportion);
         dp.pointy = y_origin - dp.temp * 3;
         dp.barpointx = dp.pointx;
         dp.barpointy = dp.pointy;
         dp.barheight = y_origin - dp.pointy;
         dp.area = (15) * (dp.barheight);
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
    float rowsize = yaxislength / numrows;
    
    for(int j = 0; j < numrows; j++){
       line(x_origin, y_origin - (rowsize * j), canvasw - 50, y_origin - (rowsize * j)); 
       fill(50);
       textSize(7);
       text(Math.round(rowsize * j) / 3,x_origin - 20, y_origin -(rowsize * j));
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
    
    setRandomColors();
    linebutton = new Button((int) canvasw + 40, 100, 250, 75, "Line Graph");
    barbutton = new Button((int) canvasw + 40, 250, 250, 75, "Bar Graph");
    piebutton = new Button((int) canvasw + 40, 400, 250, 75, "Pie Graph");
    /*
    for(int i = 0; i < dplist.size(); i++) {
      println("Time: " + dplist.get(i).time + " Temp: " + dplist.get(i).temp);
    }
    */
  }




 }