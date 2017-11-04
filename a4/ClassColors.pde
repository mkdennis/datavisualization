public class ClassColors {
  HashMap<String, int[]> classColors = new HashMap<String, int[]>();
  public ClassColors(){
    colorMode(HSB,360,100,100);
    String[] lines = loadStrings("class-colors.txt");
    for(String line : lines){
      if(line.split(" ").length > 2){
        String c = line.split(" ")[0];
        int h = Integer.parseInt(line.split(" ")[1]);
        int s = Integer.parseInt(line.split(" ")[2]);
        int b = Integer.parseInt(line.split(" ")[3]);
        classColors.put(c, new int[]{h, s, b});
      }
    }
  }
  public color[] getColors(String c){
    int[] hsb = classColors.get(c);
    if(hsb == null){
      print(c + "\n");
      return null;
    }
    if(hsb[0] == 0){
      return new color[]{color(0,0,1000), color(0,0,95)};
    }
    return new color[]{color(hsb[0],hsb[1],hsb[2]), color(hsb[0],hsb[1]/2,hsb[2])};
  }
}