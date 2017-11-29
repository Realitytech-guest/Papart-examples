import fr.inria.papart.procam.ColorDetection;
import fr.inria.papart.utils.MathUtils;
import fr.inria.papart.utils.*;
import fr.inria.papart.multitouch.detection.*;
import fr.inria.papart.multitouch.*;
import fr.inria.papart.calibration.*;

import java.util.Arrays;

public class MyApp extends PaperScreen {

  TouchDetectionColor touchDetectionColor ;
  float scale;
  ColorTracker colorTracker;
  Skatolo skatoloInside;
  public void settings() {
    setDrawingSize(280, 210);
    loadMarkerBoard(Papart.markerFolder + "A4-default.svg", 280, 210);
  }

  public void setup() {
    scale = 1;
    colorTracker = new ColorTracker(this, scale);
    skatoloInside = new Skatolo(parent, this);
    skatoloInside.setAutoDraw(false);
    // Disable the mouse as pointer. 
    skatoloInside.getMousePointer().disable();

    skatoloInside.addHoverButton("hover")
      .setPosition(120, 120)
      .setSize(30, 30);
    PlanarTouchCalibration calib = new PlanarTouchCalibration();
    calib.loadFrom(parent, "TouchColorCalibration.xml");
    // touchDetectionColor.setCalibration(calib);
  }

  void hover() {
    println("Hover activ");
  }

  public void drawOnPaper() {
    background(200, 100);

    colorTracker.setThresholds(threshHue, threshSat, threshIntens);


    int detected = 0; // color detected
    if(currentColor.equals("red")){
	colorTracker.setRedThreshold(redThresh);
	detected = redColor;
    }
    if(currentColor.equals("blue")){
	colorTracker.setBlueThreshold(blueThresh);
	detected = blueColor;
    }
    
    ArrayList<TrackedElement> te = colorTracker.
      findColor(currentColor, 
      detected, 
      millis(), erosionAmount);

    // Draw the Image captured. 
    // Sometimes the image is bad, it is a known bug. 
    // Change the paperScreen size or the scale of the ColorTracker to avoid it.
    PImage img = colorTracker.getTrackedImage();

    // DEBUG: show the captured image for tracking.
    // image(img, 180, 0, 80, 40);

    TouchList touchs = colorTracker.getTouchList();
    
    // Draw the touch found by the tracker. 
    fill(0, 100, 100);
    for (Touch t : touchs) {
      ellipse(t.position.x, t.position.y, 10, 10);
      text(t.id, t.position.x, t.position.y);
    }

    // Add the mouse as pointer. Right click to disable
    Touch t = createTouchFromMouse();
    touchs.add(t);

    // Feed the touchs to Skatolo
    // Skatolo will dispatch events according to button press etc...
    SkatoloLink.updateTouch(touchs, skatoloInside); 
  
    // Draw the pointers known by skatolo. 
    for (tech.lity.rea.skatolo.gui.Pointer p : skatoloInside.getPointerList()) {
      fill(0, 200, 0);
      rect(p.getX(), p.getY(), 3, 3);
    }

    skatoloInside.draw(getGraphics());
  }
}