public class LogParser { 
  String f; //the file being parsed
  String[] lines; //the lines in the file
  
  public LogParser(String filename){
    print("Parsing logs from file " + filename + "\n");
    
    f = filename;
    lines = loadStrings(f);
  }
  
  public void printEvents(){
    for(String s : lines){
      String eventType = s.split(" ")[3].split(",")[0];
      if(eventType.equals("SPELL_DAMAGE")){
        String timestamp = s.split(" ")[1];
        String time = timestamp.substring(0, timestamp.length()-4);
        String character = s.split(",")[2].split("\"")[1].split("-")[0];
        String spell = s.split(",")[10].split("\"")[1];
        String target = s.split(",")[6].split("\"")[1];
        String damageDone = s.split(",")[25];
        
        print("At time " + time + ", " + character + " hit " + target + " with " + spell + ", causing " + damageDone + " damage.\n"); 
      }
    }
  }
  
  ParsedLogs getParsedLogs(){
    ParsedLogs pl = new ParsedLogs(lines);
    for(String line : lines){
      if(line.split(" ").length < 4){
        continue;
      }
      String eventType = line.split(" ")[3].split(",")[0];
      if(eventType.equals("SPELL_DAMAGE")){
        pl.addLine(line);
      }
    }
    return pl;
  }
}