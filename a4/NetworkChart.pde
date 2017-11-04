public class NetworkChart {
  float radius;
  
  //HashMap<String, HashMap<String, Integer> perTargetDamage;
  
  float xPos;
  float yPos;
  
  float chartHeight;
  
  ParsedLogs logs;
  
  color[] targetColors;
  
  public NetworkChart(ParsedLogs pl) {
    logs = pl;
    
    targetColors = new color[logs.numTargets];
    for(int i=0; i<logs.numTargets; i++){
      targetColors[i] = color(random(255), random(255), random(255));
    }
    //perTargetDamage = logs.getPerTargetDamageByClass();
  }
  
  public void drawNetworkChart(){
    if(cmv.s.classFocus == ""){
      //class to target
      
      //first index is character name, second index is target name
      //perTargetDamage = logs.getPerTargetDamageByClass();
      
      
      //1. calculate damage done to each target
      int damageDoneToTargets[] = logs.getDamageDoneToTargets();
      
      //2. calculate the size of the target nodes, based on total damage done and chart height
      float totalDamage = logs.getTotalDamage()[0].elemVal;
      
      float yPos = 0;
      for(int i=0; i<logs.numTargets; i++){
        float diameter = height * (damageDoneToTargets[i]/totalDamage);
        Node n = new Node(diameter, logs.targets[i], damageDoneToTargets[i], width/2, yPos + diameter/2, targetColors[i]);
        n.drawNode();
        yPos += diameter;
      }
          
      
    } else if (cmv.s.characterFocus == ""){
      //perTargetDamage = logs.getPerTargetDamageByPlayer(cmv.s.classFocus);
    } else {
      //spell to target
      //perTargetDamage = logs.getPerTargetDamageBySpell(cmv.s.classFocus, cmv.s.characterFocus);
    }
      
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