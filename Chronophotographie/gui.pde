ControlFrame cf;

void setup_gui() {
  //cp5 = new ControlP5(this);
  cf = new ControlFrame(this, 200, 800, "Controls");
  surface.setLocation(200, 10);
}



class ControlFrame extends PApplet {

  int w, h;
  PApplet parent;
  ControlP5 cp5;

  public ControlFrame(PApplet _parent, int _w, int _h, String _name) {
    super();   
    parent = _parent;
    w=_w;
    h=_h;
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
  }

  public void settings() {
    size(w, h, P2D);
  }

  public void setup() {
    surface.setLocation(10, 10);
    cp5 = new ControlP5(this);

    cp5.addSlider("result_vibrance")
      .setRange(0, 3)
      .setValue(0.01)
      .setPosition(10, 240)
      .setSize(180, 30);
  }

  void draw() {
    background(190);
  }

  ///////////////////////////////
  // callbacks
  
  void result_vibrance(float v){
    params.resVibrance = v;
  }
}
