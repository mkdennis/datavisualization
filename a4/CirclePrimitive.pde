public class CirclePrimitive {
  float radius;
  float xPos, yPos;
  
  color fill;
  
  public CirclePrimitive(float r, float x, float y, color f) {
    radius = r;
    
    xPos = x;
    yPos = y;
    
    fill = f;
  }
  
  public void drawCircle(){
    fill(fill);
    arc(xPos, yPos, radius, radius, 0, TWO_PI);
    fill(0);
  }
  
  public boolean isHovering(){
    return dist(xPos, yPos, mouseX, mouseY) <= radius;
  }
}