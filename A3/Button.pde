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
     col = #9b59b6;
     label = f;
     Over = false;
  }
  
  void display(){
    strokeWeight(0);
    fill(col);
    println("posX: " + posX + "posY: " + posY);
    rect(posX, posY, w, h);
    
    fill(50);
    textSize(20);
    text(label, posX + 50, posY + 45);

  }
}