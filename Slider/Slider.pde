class Slider {
  float swidth, sheight;
  float startVal;
  float xpos, ypos;
  float currentPos;
  float xknobpos, newknobpos;
  float minval, maxval;
  float diameter = 20;
  String label;
  
  
  Slider(float x, float y, float maxVal, float minVal, float startVal, String label) {
    swidth = width / 5.0;
    sheight = height / 25.0;
    xpos = x;
    ypos = y;
    newknobpos = xknobpos;
    this.minval = minVal;
    this.maxval = maxVal;
    float pct = (maxVal-startVal)/(maxVal - minVal);
    currentPos = xpos + pct*swidth;
    this.label = label;
    println("Current pos "+currentPos);
  }
  
  float getCurrentVal(){
    float maxX = xpos + swidth;
    float pct = (maxX - currentPos) / (swidth - diameter/2);
    float currentVal = minval + pct * (maxval-minval);
    println("The current value is "+currentVal);
    return currentVal; 
  }
  
  boolean contains(){
    if(xpos <= mouseX && xpos + swidth >= mouseX){
      if(ypos <= mouseY && ypos + sheight >= mouseY){
        return true;  
      }
    }
    return false;  
  }
  
  boolean selected = false;
  
  void mousePressed(){
    if(contains()){
      selected = true;  
    }
  }
  
  void mouseReleased(){
    if(selected){
      currentPos = mouseX;  
      if(currentPos >= swidth){
        currentPos = swidth - diameter/2;  
      }
      if(currentPos < xpos){
        currentPos = xpos + diameter/2;  
      }
    }
    selected = false;  
  }
  
  
  void drawSlider(){
      if(contains()){
        fill(#cc7c7c);  
      }else{
        fill(255);  
      }     
      rectMode(CORNER);
      rect(xpos, ypos, swidth, sheight);
      fill(255);
      ellipseMode(CENTER);
      ellipse(currentPos, ypos + (sheight/2), diameter, diameter);
      textAlign(CENTER, TOP);
      fill(0);
      text(label, xpos + swidth/2, ypos + sheight);
      
  }
  
  
  
}