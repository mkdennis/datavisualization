public class BoxPrimitive {
  public float xPos, yPos;
  public float boxWidth, boxHeight;
  color fill1, fill2;
  
  public BoxPrimitive(float x, float y, float w, float h, color c1, color c2){
    xPos = x;
    yPos = y;
    boxWidth = w;
    boxHeight = h;
    fill1 = c1;
    fill2 = c2;
  }
  
  public void drawBox(){
    fill(fill1);
    rect(xPos, yPos, boxWidth, boxHeight);
  }
  
  public void drawBoxHovering(){
    fill(fill2);
    rect(xPos, yPos, boxWidth, boxHeight);
  }
  
  public void drawBox(color c){
    fill(c);
    rect(xPos, yPos, boxWidth, boxHeight);
  }
  
  public boolean isHovering(){
    if(mouseX > xPos && mouseX < xPos + boxWidth){
      if(mouseY > yPos && mouseY < yPos + boxHeight){
        return true;
      }
    }
    return false;
  }
  
  public float getCenterX(){
    return xPos + (boxWidth/2);
  }
  
  public float getCenterY(){
    return yPos + (boxHeight/2);
  }
}