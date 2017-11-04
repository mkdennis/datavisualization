public class CMV {
  ParsedLogs parsedLogs;
  
  SunburstChart s;
  
  public CMV(String filename){
    LogParser lp = new LogParser(filename);
    parsedLogs = lp.getParsedLogs();
    parsedLogs.printLogsForEachCharacter();
    
    s = new SunburstChart(300, parsedLogs);
  }
  
  public void draw(){
    //s.drawSunburstChart();
  }
  
  public void mouseClicked(){
    s.mouseClicked();
  }
      
}