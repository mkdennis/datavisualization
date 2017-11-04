int labelsDrawn = 0;
public class SunburstChart {
  float radius;
  
  Elem[] level1;
  Elem[] level2;
  Elem[] level3;
  Elem[] level4;
  
  float xPos;
  float yPos;
  
  int numLevels;
  int centerRadius;
  
  ParsedLogs logs;
  
  PieChart p1;
  PieChart p2;
  PieChart p3;
  PieChart p4;
  
  String classFocus;
  String characterFocus;
  
  public SunburstChart(float r, ParsedLogs pl) {
    radius = r;
    logs = pl;
    
    
    
    p1 = new PieChart(radius/4, 0, level1);
    p2 = new PieChart(radius/2, radius/4, level2);
    p3 = new PieChart(3*radius/4, radius/2, level3);
    p4 = new PieChart(radius, 3*radius/4, level4);
    
    classFocus = "";
    characterFocus = "";
  }
  
  public void drawSunburstChart(){
    labelsDrawn = 0;
    xPos = width*.5;
    yPos = height*.6;

    if(classFocus == ""){
      level1 = logs.getTotalDamage();
      level2 = logs.getTotalDamagePerClass();
      level3 = logs.getTotalDamagePerCharacter();
      level4 = logs.getTotalDamagePerSpell();
      
      p1 = new PieChart(radius/4, 0, level1);
      p2 = new PieChart(radius/2, radius/4, level2);
      p3 = new PieChart(3*radius/4, radius/2, level3);
      p4 = new PieChart(radius, 3*radius/4, level4);
      
      p1.checkHovering(radius/4);
      p2.checkHovering(radius);
      p3.checkHovering(radius);
      p4.checkHovering(radius);
      
      p4.drawPieChart();
      p3.drawPieChart();
      p2.drawPieChart();
      p1.drawPieChart();
    } else if (characterFocus == ""){
      level1 = logs.getTotalDamageForClass(classFocus);
      level2 = logs.getTotalDamagePerPlayerForClass(classFocus);
      level3 = logs.getTotalDamagePerSpellForClass(classFocus);
      
      p1 = new PieChart(radius/3, 0, level1);
      p2 = new PieChart(2*radius/3, radius/3, level2);
      p3 = new PieChart(radius, 2*radius/3, level3);
      
      p1.checkHovering(radius/3);
      p2.checkHovering(radius);
      p3.checkHovering(radius);
      
      p3.drawPieChart();
      p2.drawPieChart();
      p1.drawPieChart();
    } else {
      level1 = logs.getTotalDamageForPlayer(characterFocus);
      level2 = logs.getTotalDamagePerSpellForPlayer(characterFocus);
      
      p1 = new PieChart(radius/2, 0, level1);
      p2 = new PieChart(radius, radius/2, level2);
      
      p1.checkHovering(radius/2);
      p2.checkHovering(radius);
      
      p2.drawPieChart();
      p1.drawPieChart();
      
    }
      
  }
  void mouseClicked(){
    Elem clickedElem = getHoveredElem();
    if(clickedElem == null){
      return;
    }
    if(clickedElem.type == "class"){
      if(classFocus != ""){
        classFocus = "";
        return;
      } 
        
      print("ZOOMING TO " + clickedElem.elemKey + "\n");
      classFocus = clickedElem.elemKey;
    }
    if(clickedElem.type == "player"){
      if(characterFocus != ""){
        characterFocus = "";
        return;
      }
      print("ZOOMING TO " + clickedElem.elemKey + "\n");
      if(classFocus == ""){
        classFocus = getHoveredElem(2).elemKey;
        print("Also zooming through classFocus == " + classFocus + "\n");
      }
      characterFocus = clickedElem.elemKey;
    }
        
  }
  
  Elem getHoveredElem(){
    if(p4.getHoveredElem(radius) != null){
      print(p4.getHoveredElem(radius).elemKey);
      return p4.getHoveredElem(radius);
    }
    
    if(p3.getHoveredElem(radius) != null){
      print(p3.getHoveredElem(radius).elemKey);
      return p3.getHoveredElem(radius);
    }
    
    if(p2.getHoveredElem(radius) != null){
      print(p2.getHoveredElem(radius).elemKey);
      return p2.getHoveredElem(radius);
    }
    
    if(p1.getHoveredElem(radius) != null){
      print(p1.getHoveredElem(radius).elemKey);
      return p1.getHoveredElem(radius);
    }
    return null;
  }
  
  Elem getHoveredElem(int level){
    if(level == 4){
      return p4.getHoveredElem(radius);
    }
    
    if(level == 3){
      return p3.getHoveredElem(radius);
    }
    
    if(level == 2){
      return p2.getHoveredElem(radius);
    }
    
    if(level == 1){
      return p1.getHoveredElem(radius);
    }
    return null;
  }
  
  
  
  float getSum(Elem[] elems){
    float sum = 0;
    for(Elem e : elems){
      if(e != null){
        sum += e.elemVal;
      }
    }
    return sum;
  }   
  
  boolean isClass(String s){
    for(String c : CLASSES){
      if(c.equals(s)){
        return true;
      }
    }
    return false;
  }
  
}