public class Elem {
  String elemKey;
  float elemVal;
  
  boolean hovering;
  
  public color c;
  public color c2;
  
  String type;

  public Elem(String k, float v, color co, color co2, String t){
    elemKey = k;
    elemVal = v;
    c = co;
    c2 = co2;
    type = t;
  }
  
  public void printElem(int h){
    textSize(20);
    textAlign(CENTER);
    fill(0);
    text(elemKey + ": " + Float.toString(elemVal), width/2, h);
  }
}