// Daniel Shiffman
// Tracking the average location beyond a given depth threshold
// Thanks to Dan O'Sullivan

// https://github.com/shiffman/OpenKinect-for-Processing
// http://shiffman.net/p5/kinect/

import org.openkinect.freenect.*;
import org.openkinect.processing.*;

// The kinect stuff is happening in another class
KinectTracker tracker;
Kinect kinect;


void setup() {
  size(640, 520);
  kinect = new Kinect(this);
  tracker = new KinectTracker();
  //tracker = new KinectTracker("sisters.jpg");
  tracker.setMaxThreshold(900);
  //tracker.setBackGroundImage("sisters.jpg");
  tracker.setBackGroundImage("milkyway.jpg");
}
  //sun info---
  float squareSize = 35;
  float orbSize = squareSize * 1.1;
  int angle = 45;
  float hypotenuse = sqrt(pow(squareSize,2) +  pow(squareSize,2));

void draw() {
  translate(0, 0);
  background(255);
  tracker.track();  // Run the tracking analysis
  tracker.display();  // Show the image

  PVector v1 = tracker.getInterpolatedPosition();
  fill(255, 255, 0, 200);//yellow
  noStroke();
  translate(v1.x, v1.y);
  ellipse(0, 0, orbSize, orbSize);
  rotate(radians(angle));
  rect(-(squareSize/2), -(squareSize/2), squareSize, squareSize);
  rotate(radians(angle));
  rect(-(squareSize/2), -(squareSize/2), squareSize, squareSize);
  fill(255, 255, 0, 200);
  angle = angle + 1;
}
