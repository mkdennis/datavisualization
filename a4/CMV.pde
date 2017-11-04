public class CMV {
  ParsedLogs parsedLogs;
  
  SunburstChart s;
  NetworkChart n;
  
  public CMV(String filename){
    LogParser lp = new LogParser(filename);
    parsedLogs = lp.getParsedLogs();
    parsedLogs.printLogsForEachCharacter();
    
    s = new SunburstChart(300, parsedLogs);
    n = new NetworkChart(parsedLogs);
  }
  
  public void draw(){
    //s.drawSunburstChart();
    n.drawNetworkChart();
  }
  
  public void mouseClicked(){
    s.mouseClicked();
  }
      
}