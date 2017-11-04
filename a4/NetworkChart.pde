//public class NetworkChart {
//  float radius;
  
//  //HashMap<String, HashMap<String, Integer> perTargetDamage;
  
//  float xPos;
//  float yPos;
  
//  float chartHeight;
  
//  ParsedLogs logs;
  
//  public NetworkChart(ParsedLogs pl) {
//    logs = pl;
//    //perTargetDamage = logs.getPerTargetDamageByClass();
//  }
  
//  public void drawNetworkChart(){
//    if(cmv.s.classFocus == ""){
//      //class to target
      
//      //first index is character name, second index is target name
//      //perTargetDamage = logs.getPerTargetDamageByClass();
      
//      //1. calculate damage done to each target
//      int damageDoneToTargets[] = new int[logs.numTargets];
//      for(int i=0; i<logs.numTargets; i++){
//        damageDoneToTargets[i] = logs.getDamageToTarget(i);
//      }
      
//      //2. calculate the size of the target nodes, based on total damage done and chart height
//      int totalDamage = logs.totalDamageDone;
      
//      int yPos = 100;
//      for(int i=0; i<logs.numTargets; i++){
//        Node n = new Node(height * (damageDoneToTargets[i]/totalDamage), logs.targets[i], damageDoneToTargets[i], width/2, yPos, color(random(255), random(255), random(255));
//        n.drawNode();
//      }
          
      
//    } else if (cmv.s.characterFocus == ""){
//      //perTargetDamage = logs.getPerTargetDamageByPlayer(cmv.s.classFocus);
//    } else {
//      //spell to target
//      //perTargetDamage = logs.getPerTargetDamageBySpell(cmv.s.classFocus, cmv.s.characterFocus);
//    }
      
//  }
  
//  float getSum(Elem[] elems){
//    float sum = 0;
//    for(Elem e : elems){
//      if(e != null){
//        sum += e.elemVal;
//      }
//    }
//    return sum;
//  }   
  
//  boolean isClass(String s){
//    for(String c : CLASSES){
//      if(c.equals(s)){
//        return true;
//      }
//    }
//    return false;
//  }
  
//}