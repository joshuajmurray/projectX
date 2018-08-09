class KinectTracker {

  float minThreshold = 200;
  float maxThreshold = 500;
  float rawDepth = 0;
  boolean nightTime = false;
  String dayImage;
  String nightImage;
  int dayStart;
  int dayEnd;

  PVector loc;//Raw location
  PVector interpolatedLocation;//Interpolated location

  int[] depth;//Depth data
  
  PImage display;
  PImage currentBackground;

  KinectTracker(String day, String night, int hour, int start, int end) {
    kinect.initDepth();
    kinect.enableMirror(true);
    display = createImage(kinect.width, kinect.height, RGB);// Make a blank image
    loc = new PVector(0, 0);
    interpolatedLocation = new PVector(0, 0);
    dayImage = day;
    nightImage = night;
    dayStart = start;
    dayEnd = end;
    isNightTime(hour);
    setBackGroundImage(nightTime);
  }

  void track() {
    depth = kinect.getRawDepth();

    if (depth == null) return;

    float sumX = 0;
    float sumY = 0;
    float count = 0;

    for (int x = 0; x < kinect.width; x++) {
      for (int y = 0; y < kinect.height; y++) {
        rawDepth = depth[x + y*kinect.width];
        if (rawDepth < maxThreshold && rawDepth > minThreshold) {
          sumX += x;
          sumY += y;
          count++;
        }
      }
    }
    
    if (count != 0) {// As long as we found something
      loc = new PVector(sumX/count, sumY/count);
    }

    // Interpolating the location, doing it arbitrarily for now
    interpolatedLocation.x = PApplet.lerp(interpolatedLocation.x, loc.x, 0.3f);
    interpolatedLocation.y = PApplet.lerp(interpolatedLocation.y, loc.y, 0.3f);
  }

  PVector getInterpolatedPosition() {
    return interpolatedLocation;
  }

  PVector getPos() {
    return loc;
  }

  void display(int hour) {
    PImage img = kinect.getDepthImage();
    isNightTime(hour);
    setBackGroundImage(nightTime);

    display.loadPixels();
    for (int x = 0; x < kinect.width; x++) {
      for (int y = 0; y < kinect.height; y++) {

        int offset = x + y * kinect.width;
        int rawDepth = depth[offset];// Raw depth
        int pix = x + y * display.width;
        
        if (rawDepth < maxThreshold && rawDepth > minThreshold) {
          display.pixels[pix] = color(255, 50, 50);// A red color instead
        } else {
          display.pixels[pix] = img.pixels[offset];
        }
        
        if (rawDepth > maxThreshold) {//set the pixle as transparent
          PImage temp = currentBackground.get(x,y,1,1);
          display.set(x,y,temp);
        }
        
      }
    }

    display.updatePixels();
    image(display, 0, 0);// Draw the image
  }

  float getMinThreshold() {
    return minThreshold;
  }

  void setMinThreshold(float t) {
    minThreshold =  t;
  }

  float getMaxThreshold() {
    return maxThreshold;
  }

  void setMaxThreshold(float t) {
    maxThreshold =  t;
  }
  
  void setBackGroundImage(boolean night) {
    if(night) {
      currentBackground = loadImage(nightImage);
    } else {
      currentBackground = loadImage(dayImage);
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
