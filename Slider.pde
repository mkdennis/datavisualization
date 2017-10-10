class Slider {
  float swidth, sheight;
  float startVal;
  float xpos, ypos;
  float currentPos;
  float xknobpos, newknobpos;
  float minval, maxval;
  boolean over;
  
  Slider(float x, float y, float maxVal, float minVal, float startVal) {
    swidth = width / 5.0;
    sheight = height / 25.0;
    xpos = x;
    ypos = y;
    newknobpos = xknobpos;
    this.minval = minVal;
    this.maxval = maxVal;
    currentPos = xpos + (maxVal-startVal)/(maxVal - minVal)/2.0;
  }
  
  float getCurrentVal(){
    return currentPos; 
  }
  
  boolean contains(){
    if(xpos - swidth/2 <= mouseX && xpos + swidth/2 >= mouseX){
      if(ypos - sheight/2 <= mouseY && ypos + sheight/2 >= mouseY){
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
    }
    selected = false;  
  }
  
  
  void drawSlider(){
      if(contains()){
        fill(#cc7c7c);  
      }else{
        fill(255);  
      }     
      rect(xpos, ypos, swidth, sheight);
      ellipse(currentPos, ypos + (sheight/2), 20, 20);
  }
  
  
  
}