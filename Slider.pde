class Slider {
  int swidth, sheight;
  float xpos, ypos;
  float xknobpos, newknobpos;
  float minval, maxval;
  boolean over;
  
  Slider(float a, float b) {
    
    swidth = width / 5;
    sheight = height / 25;
    xpos = a;
    ypos = b;
    xknobpos = xpos + (swidth/2);
    newknobpos = xknobpos;
    minval = 0;
    maxval = 50;
  }
  
  void drawSlider(){
      rect(xpos, ypos, swidth, sheight);
      ellipse(xknobpos, ypos + (sheight/2), 20, 20);
  }
  
  
  
}