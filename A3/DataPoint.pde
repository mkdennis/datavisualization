class DataPoint {
  String time;
  float temp;
  
  //line graph attributes
  float pointx, pointy;
  float barpointx, barpointy;
  
  //bar graph attributes
  float barheight, barheight2;
  float area;

  //pie graph attributes
  float degree, arcstart;
  float slicex, slicey;
  float start, end;
  int r, g, b;
  
  public DataPoint(String t, float tmp){
    time = t;
    temp = tmp;
  }
  
}