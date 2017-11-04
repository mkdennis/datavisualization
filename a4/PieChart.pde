public class PieChart {
  float radius;
  Elem[] data;
  float sum;
  
  float xPos;
  float yPos;
  
  float innerRadius;
  
  public PieChart(float r, float ir, Elem[] d) {
    radius = r;
    innerRadius = ir;
    data = d;  

    sum = getSum();
    xPos = width*.75;
    yPos = height*.65;
  }
  
  public void drawPieChart(){
    float lastAngle = 0;
    for(Elem e : data){

      strokeWeight(2);
      if(e.hovering){
        fill(e.c2);
        e.hovering = false;
      } else {
        fill(e.c);
      }
      line(xPos, yPos, radius*cos(lastAngle) + xPos, radius*sin(lastAngle) + yPos);
      line(xPos, yPos, radius*cos(lastAngle+(TWO_PI/sum * e.elemVal)) + xPos, radius*sin(lastAngle+(TWO_PI/sum * e.elemVal)) + yPos);
      arc(xPos, yPos, radius*2, radius*2, lastAngle, lastAngle+TWO_PI/sum * e.elemVal);
      lastAngle += TWO_PI/sum * e.elemVal;
      
      strokeWeight(1);
      fill(0);
      e.hovering = false;
    }
    noFill();
    strokeWeight(5);
    arc(xPos, yPos, radius*2, radius*2, 0, TWO_PI);
    strokeWeight(1);
    fill(0);
  }
  
  public void checkHovering(float outerRadius){
    float distance = dist(mouseX, mouseY, xPos, yPos);
    float angle = atan((mouseY-yPos)/(mouseX-xPos));
    if(mouseX < xPos){
      angle +=PI;
    } else if (mouseY < yPos){
      angle +=TWO_PI;
    }
    
    float lastAngle = 0;
    
    if(distance < outerRadius && distance > innerRadius){
      for(Elem e : data){
        if(angle > lastAngle && angle < lastAngle + (TWO_PI/sum) * e.elemVal){
          labelsDrawn++;
          e.printElem(labelsDrawn*height/10);
          e.hovering = true;
        }
        lastAngle += TWO_PI/sum * e.elemVal;
      }   
    }
  }
  
  public Elem getHoveredElem(float outerRadius){
    float distance = dist(mouseX, mouseY, xPos, yPos);
    float angle = atan((mouseY-yPos)/(mouseX-xPos));
    if(mouseX < xPos){
      angle +=PI;
    } else if (mouseY < yPos){
      angle +=TWO_PI;
    }
    
    float lastAngle = 0;
    
    if(distance < outerRadius && distance > innerRadius){
      for(Elem e : data){
        if(angle > lastAngle && angle < lastAngle + (TWO_PI/sum) * e.elemVal){
          return e;
        }
        lastAngle += TWO_PI/sum * e.elemVal;
      }   
    }
    return null;
  }
  
  float getSum(){
    float sum = 0;
    if(data == null){
      return 0;
    }
    for(Elem e : data){
      sum += e.elemVal;
    }
    return sum;
  }
}