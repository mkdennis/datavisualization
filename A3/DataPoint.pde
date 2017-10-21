class DataPoint {
  String time;
  float temp;
  
  //line graph attributes
  float pointx, pointy;
  
  //bar graph attributes
  float barHeight;

  //pie graph attributes
  
  public DataPoint(String t, float tmp){
    time = t;
    temp = tmp;
  }
  
}