import java.util.*;

public class ParsedLogs {
  String filename;
  Character[] characters;
  String[] classes;
  String startTime;
  String endTime;
  String[] targets;
  
  
  int numChars;
  int numTargets;
  
  ClassColors classColors;
  
  int totalDamageDone;

  public ParsedLogs(String[] lines) {
    
    numChars = Integer.parseInt(lines[0]);
    characters = new Character[numChars];
    for(int i=1; i<numChars+1; i++){
      characters[i-1] = new Character(lines[i].split("-")[0], lines[i].split("-")[1]);
    }
    
    numTargets = Integer.parseInt(lines[numChars+1]);
    targets = new String[numTargets];
    for(int i=0; i<numTargets; i++){
      targets[i] = lines[i+numTargets+2];
    }
    for(String t : targets){
      print(t);
    }
    
    String startTimestamp = lines[numChars+2].split(" ")[1];
    startTime = startTimestamp.substring(0, startTimestamp.length()-4);
    
    String endTimestamp = lines[lines.length-1].split(" ")[1];
    endTime = endTimestamp.substring(0, endTimestamp.length()-4);
    
    classColors = new ClassColors();
  }

  public void addLine(String line) {
    String timestamp = line.split(" ")[1];
    String time = timestamp.substring(0, timestamp.length()-4);
    String character = line.split(",")[2].split("\"")[1].split("-")[0];
    String spell = line.split(",")[10].split("\"")[1];
    String target = line.split(",")[6].split("\"")[1];
    String damageDone = line.split(",")[25];
    
    Cast cast = new Cast(spell, time, character, target, damageDone);
    for(Character c : characters){
      if(c.name.equals(character)){
        c.addCast(cast);
      }
    }
  }
  
  public void printLogsForEachCharacter(){
    print("Printing logs for each character from " + startTime + " to " + endTime + "...\n");
    for(Character c : characters){
      print("Logs for " + c.name + "\n");
      HashMap<String, Integer> damageBySpell = new HashMap<String, Integer>();
      for(Cast cast : c.casts){
        if(cast != null){
          if(damageBySpell.containsKey(cast.spell)){
            damageBySpell.put(cast.spell, damageBySpell.get(cast.spell) + Integer.parseInt(cast.damageDone));
          } else {
            damageBySpell.put(cast.spell, Integer.parseInt(cast.damageDone));
          }
        }
      }
      for(String spell : damageBySpell.keySet()){
        print("Damage done by " + spell + ":" + damageBySpell.get(spell) + ".\n");
      }
    }
  }
  //view : Initial
  //need : totalDamage
  //       damagePerClass
  //       damagePerPlayer
  //       damagePerSpell
  
  public Elem[] getTotalDamage(){
    Elem[] totalDamageArray = new Elem[1];
    int totalDamage = 0;
    for(Character c : characters){
      for(Cast cast : c.casts){
        if(cast != null){
          totalDamage += Integer.parseInt(cast.damageDone);
        }
      }
    }
    totalDamageArray[0] = new Elem("Total", totalDamage, color(0,0,0), color(0,0,50), "total");
    return totalDamageArray;
  }
  
  public Elem[] getTotalDamagePerClass(){
    List classes = new ArrayList();
    for(Character c : characters){
      if(classes.indexOf(c.characterClass) == -1){
        classes.add(classes.size(), c.characterClass);
      }  
    }
    
    Elem[] totalDamagePerClassArray = new Elem[classes.size()];
    
    HashMap<String, Integer> damagePerClass = new HashMap<String, Integer>();
    for(Character c : characters){
      if(!damagePerClass.containsKey(c.characterClass)){
        damagePerClass.put(c.characterClass, 0);
      }
      for(Cast cast : c.casts){
        if(cast != null){
          damagePerClass.put(c.characterClass, damagePerClass.get(c.characterClass) + Integer.parseInt(cast.damageDone));
        }
      }
    }
    
    int classesAdded = 0;
    for(Object c : classes){
      String cString = c.toString();
      totalDamagePerClassArray[classesAdded] = new Elem(cString, damagePerClass.get(cString), classColors.getColors(cString)[0], classColors.getColors(cString)[1], "class");
      classesAdded++;
    }
    return totalDamagePerClassArray;
  }
  
  public Elem[] getTotalDamagePerCharacter(){
    Elem[] totalDamagePerCharacter = new Elem[characters.length];
    
    int charsAdded = 0;
    for(Character c : characters){
      totalDamagePerCharacter[charsAdded] = new Elem(c.name, 0, c.characterColor, c.characterColorHover, "player");
      for(Cast cast : c.casts){
        if(cast != null){
          totalDamagePerCharacter[charsAdded].elemVal += Integer.parseInt(cast.damageDone);
        }
      }
      charsAdded++;
    }
    
    return totalDamagePerCharacter;
  }
  
  public Elem[] getTotalDamagePerSpell(){
    HashMap<String, HashMap<String, Integer>> damageBySpellByCharacter = new HashMap<String, HashMap<String, Integer>>();
    
    for(Character c : characters){
      HashMap<String, Integer> damageBySpell = new HashMap<String, Integer>();
      for(Cast cast : c.casts){
        if(cast != null){
          if(damageBySpell.containsKey(cast.spell)){
            damageBySpell.put(cast.spell, damageBySpell.get(cast.spell) + Integer.parseInt(cast.damageDone));
          } else {
            damageBySpell.put(cast.spell, Integer.parseInt(cast.damageDone));
          }
        }
      }
      damageBySpellByCharacter.put(c.name, damageBySpell);
    }
    
    int totalUniqueSpells = 0;
    for(Character c : characters){
      totalUniqueSpells += damageBySpellByCharacter.get(c.name).size();
    }
    Elem[] totalDamageBySpell = new Elem[totalUniqueSpells];
    
    int elemsAdded = 0;
    for(Character c : characters){
      for(String k : damageBySpellByCharacter.get(c.name).keySet()){
        totalDamageBySpell[elemsAdded] = new Elem(k, damageBySpellByCharacter.get(c.name).get(k), c.characterColor, c.characterColorHover, "spell");
        elemsAdded++;
      }
    }

    return totalDamageBySpell;
  }
  
  //view: focus on class
  //need: damageForClass
  //      damagePerPlayerForClass
  //      damagePerSpellForClass
  
  public Elem[] getTotalDamageForClass(String s){
    Elem[] totalDamageForClassArray = new Elem[1];
    
    int totalDamage = 0;
    for(Character c : characters){
      if(c.characterClass == s){
        for(Cast cast : c.casts){
          if(cast != null){
            totalDamage += Integer.parseInt(cast.damageDone);
          }
        }
      }
    }
    
    totalDamageForClassArray[0] = new Elem(s, totalDamage, classColors.getColors(s)[0], classColors.getColors(s)[1], "class");
    return totalDamageForClassArray;
  }  
  
  public Elem[] getTotalDamagePerPlayerForClass(String s){
    int totalCharactersOfClass = 0;
    for(Character c : characters){
      if(c.characterClass.equals(s)){
        totalCharactersOfClass++;
      }
    }
    Elem[] totalDamagePerCharacterForClassArray = new Elem[totalCharactersOfClass];
    
    int charsAdded = 0;
    for(Character c : characters){
      if(c.characterClass.equals(s)){
        totalDamagePerCharacterForClassArray[charsAdded] = new Elem(c.name, 0, c.characterColor, c.characterColorHover, "player");
        for(Cast cast : c.casts){
          if(cast != null){
            totalDamagePerCharacterForClassArray[charsAdded].elemVal += Integer.parseInt(cast.damageDone);
          }
        }
        charsAdded++;
      }
    }
    
    return totalDamagePerCharacterForClassArray;
  }
  
  public Elem[] getTotalDamagePerSpellForClass(String s){
    HashMap<String, HashMap<String, Integer>> damagePerSpellByCharacterForClass = new HashMap<String, HashMap<String, Integer>>();
    
    for(Character c : characters){
      if(c.characterClass.equals(s)){
        HashMap<String, Integer> damageBySpell = new HashMap<String, Integer>();
        for(Cast cast : c.casts){
          if(cast != null){
            if(damageBySpell.containsKey(cast.spell)){
              damageBySpell.put(cast.spell, damageBySpell.get(cast.spell) + Integer.parseInt(cast.damageDone));
            } else {
              damageBySpell.put(cast.spell, Integer.parseInt(cast.damageDone));
            }
          }
        }
        damagePerSpellByCharacterForClass.put(c.name, damageBySpell);
      }
    }
    
    int totalUniqueSpells = 0;
    for(Character c : characters){
      if(c.characterClass.equals(s)){
        totalUniqueSpells += damagePerSpellByCharacterForClass.get(c.name).size();
      }
    }
    Elem[] totalDamageBySpell = new Elem[totalUniqueSpells];
    
    int elemsAdded = 0;
    for(Character c : characters){
      if(c.characterClass.equals(s)){
        for(String k : damagePerSpellByCharacterForClass.get(c.name).keySet()){
          totalDamageBySpell[elemsAdded] = new Elem(k, damagePerSpellByCharacterForClass.get(c.name).get(k), c.characterColor, c.characterColorHover, "spell");
          elemsAdded++;
        }
      }
    }

    return totalDamageBySpell;
  }
  
  public Elem[] getTotalDamageForPlayer(String s){
    for(Character c : characters){
      if(c.name.equals(s)){
        int totalDamage = 0;
        for(Cast cast : c.casts){
          if(cast != null){
            totalDamage += Integer.parseInt(cast.damageDone);
          }
        }
        return new Elem[]{new Elem(s, totalDamage, c.characterColor, c.characterColorHover, "player")};
      }
    }
    return null;
  } 
  
  public Elem[] getTotalDamagePerSpellForPlayer(String s){
    for(Character c : characters){
      if(c.name.equals(s)){
        HashMap<String, Integer> damagePerSpellForCharacter = new HashMap<String, Integer>();
        
        for(Cast cast : c.casts){
          if(cast != null){
            if(damagePerSpellForCharacter.containsKey(cast.spell)){
              damagePerSpellForCharacter.put(cast.spell, damagePerSpellForCharacter.get(cast.spell) + Integer.parseInt(cast.damageDone));
            } else {
              damagePerSpellForCharacter.put(cast.spell, Integer.parseInt(cast.damageDone));
            }
          }
        }
        
        Elem[] totalDamagePerSpellForPlayerArray = new Elem[damagePerSpellForCharacter.size()];
        
        int elemsAdded = 0;
        for(String spell : damagePerSpellForCharacter.keySet()){
          totalDamagePerSpellForPlayerArray[elemsAdded] = new Elem(spell, damagePerSpellForCharacter.get(spell), c.characterColor, c.characterColorHover, "spell");
          elemsAdded++;
        }
        
        return totalDamagePerSpellForPlayerArray;
      }
    }
    return null;
  }
  
      
  //NETWORK CHART METHODS
  public Elem[][] getPerTargetDamageByClass(){
    HashMap<String, HashMap<String, Integer>> perTargetDamageByClass = new HashMap<String, HashMap<String, Integer>>();
    int classCounter=0;
    for(String classString : CLASSES){
      for(Character c : characters){
        HashMap<String, Integer> perTargetDamage;
        while(c.characterClass != CLASSES[classCounter]){
          classCounter++;
        }
        
        if(perTargetDamageByClass.containsKey(classString)){
          perTargetDamage = perTargetDamageByClass.get(classString);
          for(String t : targets){
            perTargetDamage.put(t, perTargetDamage.get(t) + damageDoneByPlayerToTarget(c, t));
          }
          perTargetDamageByClass.put(classString, perTargetDamage);
        } else {
          perTargetDamage = new HashMap<String, Integer>();
          for(String t : targets){
            perTargetDamage.put(t, damageDoneByPlayerToTarget(c, t));
          }
          perTargetDamageByClass.put(classString, perTargetDamage);
        }
      }
    }
      
    Elem[][] perTargetDamageByClassArray;
    return null;
  }
  public int damageDoneByPlayerToTarget(Character c, String target){
    int totalDamage = 0;
    
    for(Cast cast : c.casts){
      if(cast.target == target){
        totalDamage += Integer.parseInt(cast.damageDone);
      }
    }
    
    return totalDamage;
  }
} 