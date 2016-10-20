// PapARt library
import fr.inria.papart.procam.*;
import fr.inria.papart.procam.camera.*;
import org.bytedeco.javacpp.*;
import org.reflections.*;
import TUIO.*;
import toxi.geom.*;

import org.bytedeco.javacv.RealSenseFrameGrabber;
import processing.video.*;


Camera camera;
int resX = 1920;
int resY = 1080;


void settings(){
    size(800, 600, OPENGL);
    // size(resX, resY, OPENGL);
}

public void setup() {

    if (surface != null) {
	surface.setResizable(true);
    }

    // camera = CameraFactory.createCamera(Camera.Type.OPEN_KINECT, "0");
    // camera = CameraFactory.createCamera(Camera.Type.OPENCV, "0");
    // camera = CameraFactory.createCamera(Camera.Type.PROCESSING, "/dev/video1");
    // camera = CameraFactory.createCamera(Camera.Type.FLY_CAPTURE, 0);

    // camera = CameraFactory.createCamera(Camera.Type.FFMPEG, "/dev/video1");
    // camera = CameraFactory.createCamera(Camera.Type.FFMPEG, ":0.0+200,200", "x11grab");


    camera = CameraFactory.createCamera(Camera.Type.REALSENSE, "0");
    
    camera.setParent(this);
    camera.setSize(resX, resY);
    //    ((CameraFlyCapture) camera).setBayerDecode(true);
    camera.start();
    camera.setThread();

}

void draw() {
    PImage im = camera.getPImage();
    if(im != null)
	image(im, 0, 0, width, height);

}
