public class Destructor {
  private float x, y, w, h;
  private int fill_c, stroke_c;

  Destructor(float x_, float y_, float w_, float h_, int f_, int s_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    fill_c = f_;
    stroke_c = s_;

    BodyDef bd = new BodyDef();
    bd.position.set(box2d.coordPixelsToWorld(x, y)); 
    bd.type = BodyType.STATIC;
    Body b = box2d.createBody(bd);

    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    sd.setAsBox(box2dW, box2dH);
    b.createFixture(sd, 1);
    b.setUserData(this);
  }

  PVector getXY() {
    PVector xy = new PVector(x, y);
    return xy;
  }

  PVector getWH() {
    PVector wh = new PVector(w, h);
    return wh;
  }
}