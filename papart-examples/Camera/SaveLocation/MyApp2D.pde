MyApp app;

public class MyApp extends PaperScreen {

  public void settings() {
    setDrawingSize(297, 210);
    loadMarkerBoard(Papart.markerFolder + "A3-small1.svg", 297, 210);
    setDrawOnPaper();
  }

  public void setup() {
    app = this;
  }

  public void drawOnPaper() {
    background(100, 0, 0);
    fill(200, 100, 20);
    rect(10, 10, 100, 30);
  }
}