// Daniel Shiffman
// Tracking the average location beyond a given depth threshold
// Thanks to Dan O'Sullivan

// https://github.com/shiffman/OpenKinect-for-Processing
// http://shiffman.net/p5/kinect/

class KinectTracker {

  float minThreshold = 200;
  float maxThreshold = 500;
  float rawDepth = 0;

  PVector loc;// Raw location
  PVector interpolatedLocation;// Interpolated location

  int[] depth;// Depth data
  
  PImage display;
  PImage dayBackGround;
  PImage nightBackGround;
   
  KinectTracker() {
    kinect.initDepth();
    kinect.enableMirror(true);
    display = createImage(kinect.width, kinect.height, RGB);// Make a blank image
    dayBackGround = loadImage("sisters.jpg");
    loc = new PVector(0, 0);
    interpolatedLocation = new PVector(0, 0);
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

  void display() {
    PImage img = kinect.getDepthImage();

    // Being overly cautious here
    if (depth == null || img == null) return;

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
          //display.pixels[pix] = color(0,0,0,0);
          PImage temp = dayBackGround.get(x,y,1,1);
          display.set(x,y,temp);
        }
        
      }
    }
    display.updatePixels();

    // Draw the image
    image(display, 0, 0);
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

}
