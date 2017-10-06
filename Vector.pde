class Vector {
  
  float magnitude;
  float x;
  float y;
  
  float getTotalX(){
    return magnitude * x;
  }
  
  float getTotalY(){
    return magnitude * y;  
  }
  
  Vector add(Vector v){
    Vector result = new Vector();
    float x = getTotalX() + v.getTotalX();
    float y = getTotalY() + v.getTotalY();
    float total = sqrt(x*x + y*y);
    //calculate magnitude
    result.magnitude = total;
    //normalize to create unit portions
    x = x / magnitude;
    y = y / magnitude;
    result.x = x;
    result.y = y; 
    return result;
  }
  
  Vector reverse(){
    Vector v = new Vector();
    v.x = -x;
    v.y = -y;
    return v;
  }
}