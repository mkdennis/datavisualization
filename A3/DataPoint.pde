class DataPoint {
  String time;
  float temp;
  
  //line graph attributes
  float pointx, pointy;
  
  //bar graph attributes
  float barheight, barheight2;

  //pie graph attributes
  float degree;
  float slicex, slicey;s
  
  public DataPoint(String t, float tmp){
    time = t;
    temp = tmp;
  }
  
}