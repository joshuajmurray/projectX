class SkyObject {

  boolean nightTime = false;
  int dayStart;
  int dayEnd;

  //sun info---
  float squareSize = 35;
  float orbSize = squareSize * 1.1;
  int angle1 = 0;
  int angle2 = 45;
  float hypotenuse = sqrt(pow(squareSize,2) +  pow(squareSize,2));
  
  SkyObject(int hour, int start, int end) {
    isNightTime(hour);
    dayStart = start;
    dayEnd = end;
  }
  
  void build(PVector v1, int hour) {
    isNightTime(hour);
    
    if(!nightTime) {//display a sun and rotate it
      fill(245, map(v1.y,0,(height/2),245,100), 65, 255);//yellow = r245 g of 180 to 245 b65
      noStroke();
      translate(v1.x, v1.y);
      ellipse(0, 0, orbSize, orbSize);
      pushMatrix();
      rotate(radians(angle1));
      rect(-(squareSize/2), -(squareSize/2), squareSize, squareSize);
      popMatrix();
      rotate(radians(angle2));
      rect(-(squareSize/2), -(squareSize/2), squareSize, squareSize);
      fill(255, 255, 0, 200);
      angle1++;
      angle2++;
    } else {//display a moon
      fill(248, 252, 224, 255);//moon color
      noStroke();
      translate(v1.x, v1.y);
      ellipse(0, 0, orbSize, orbSize);
    }
  }

  void isNightTime(int hour) {
    nightTime = (hour > dayStart && hour < dayEnd) ? false : true;
  }  

}
