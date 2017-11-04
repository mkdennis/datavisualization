String[] CLASSES = new String[]{"DEATHKNIGHT", "DEMONHUNTER", "DRUID", "HUNTER", "MAGE", "MONK", "PALADIN", "PRIEST", "ROGUE", "SHAMAN", "WARLOCK", "WARRIOR"};

public class Character {
  String name;
  String characterClass;
  Cast[] casts;
  int numCasts;
  color characterColor;
  color characterColorHover;
  
  public Character(String n, String c){
    casts = new Cast[10];
    name = n;
    characterClass = c;
    
    numCasts = 0;
    
    color[] colors = classColors.getColors(characterClass);

    characterColor = colors[0];
    characterColorHover = colors[1];
  }
  
  public void addCast(Cast c){
    if(numCasts == casts.length){
      expandCastsArray();
    }
    casts[numCasts] = c;
    numCasts++;
  }
  
  public void expandCastsArray(){
    Cast[] newArray = new Cast[casts.length * 2];
    System.arraycopy(casts, 0, newArray, 0, casts.length);
    casts = newArray;
  }

}