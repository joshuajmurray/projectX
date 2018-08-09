class SkyObject {

  boolean nightTime = false;
  int dayStart;
  int dayEnd;

  //sun info---
  float squareSize = 35;
  float orbSize = squareSize * 1.1;
  int angle = 45;
  float hypotenuse = sqrt(pow(squareSize,2) +  pow(squareSize,2));
  
  SkyObject(int hour, int start, int end) {
    isNightTime(hour);
    dayStart = start;
    dayEnd = end;
  }
  
  void build(PVector v1, int hour) {
    isNightTime(hour);
    
    if(!nightTime) {//display a sun
      fill(255, 255, 0, 255);//yellow
      noStroke();
      translate(v1.x, v1.y);
      ellipse(0, 0, orbSize, orbSize);
      rotate(radians(angle));
      rect(-(squareSize/2), -(squareSize/2), squareSize, squareSize);
      rotate(radians(angle));
      rect(-(squareSize/2), -(squareSize/2), squareSize, squareSize);
      fill(255, 255, 0, 200);
      angle = angle + 1;
    } else {//display a moon
      fill(248, 252, 224, 255);//moon color
      noStroke();
      translate(v1.x, v1.y);
      ellipse(0, 0, orbSize, orbSize);
    }
  }

  void isNightTime(int hour) {
    if(hour > dayStart && hour < dayEnd) {
      nightTime = false;
    } else {
      nightTime = true;
    }
  }  

}
