class Button {
  int posX, posY;
  int w, h;
  color col;
  boolean Over;
  String label;
  
  public Button(int a, int b, int c, int d, String f){
     posX = a;
     posY = b;
     w = c;
     h = d;
     col = #CDA2AB;
     label = f;
     Over = false;
  }
  
  void display(){
    strokeWeight(0);
    fill(col);
    rect(posX, posY, w, h);
    
    fill(255);
    textSize(20);
    text(label, posX + 55, posY + 45);
  }
  
  boolean overRect() {
     if(mouseX >= posX && mouseX <= posX + w && mouseY >= posY && mouseY <= posY+h){
        return true; 
     } else
       return false;
  }
  
}