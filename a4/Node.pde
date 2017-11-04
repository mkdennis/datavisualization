public class Node {
  float radius;
  
  String name;
  float value;
  
  float xPos, yPos;
  
  color fill;
  
  public Node(float r, String n, float v, float x, float y, color f){
    radius = r;
    
    name = n;
    value = v;
    
    fill = f;
  }
  
  public void drawNode(){
    CirclePrimitive node = new CirclePrimitive(radius, xPos, yPos, fill);
    node.drawCircle();
  }
}