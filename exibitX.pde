import org.openkinect.freenect.*;
import org.openkinect.processing.*;

private static final int DAYSTART = 6;
private static final int DAYEND = 20;
  
KinectTracker tracker;
Kinect kinect;
SkyObject celestialBody;

void setup() {
  size(640, 520);
  kinect = new Kinect(this);  
  tracker = new KinectTracker("sisters.jpg", "milkyway.jpg", hour(), DAYSTART, DAYEND);
  tracker.setMinThreshold(800);
  tracker.setMaxThreshold(900);
  celestialBody = new SkyObject(hour(), DAYSTART, DAYEND);
}

void draw() {
  int h = hour();
  translate(0, 0);
  background(255);
  tracker.track();//Run the tracking analysis
  tracker.display(h);//Show the image
  celestialBody.build(tracker.getInterpolatedPosition(), h);//show the sun/moon
}
