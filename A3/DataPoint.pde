class DataPoint {
  String time;
  float temp;
  
  //line graph attributes
  float pointx, pointy;
  
  //bar graph attributes
  float barheight;

  //pie graph attributes
  float degree;
  
  public DataPoint(String t, float tmp){
    time = t;
    temp = tmp;
  }
  
}