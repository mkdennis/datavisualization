CMV cmv;
ClassColors classColors;
void setup(){
  String file = "invasionRunPP.txt";
  classColors = new ClassColors();
  cmv = new CMV(file);
  size(2000,1000);
  surface.setResizable(true);
  
  int x = 100;
  for(String s : classColors.classColors.keySet()){
    print("Class: " + s + "\n");
  }
}

void draw(){
  clear();
  background(255);
  cmv.draw();
  int x = 100;
  for(String s : classColors.classColors.keySet()){
    BoxPrimitive b = new BoxPrimitive(x, 100, 50, 50, classColors.getColors(s)[0], classColors.getColors(s)[1]);
    if(b.isHovering()){
      b.drawBoxHovering();
    } else {
      b.drawBox();
    }
    x += 100;
  }
}

void mouseClicked(){
  cmv.mouseClicked();
}