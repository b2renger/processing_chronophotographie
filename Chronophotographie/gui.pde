ControlFrame cf;



void setup_gui() {
  //cp5 = new ControlP5(this);
  cf = new ControlFrame(this, 300, 800, "Controls");
  surface.setLocation(10, 10);
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

    Group g1 = cp5.addGroup("OPTIONS")
      .setBackgroundColor(color(0, 64))
      .setFont(createFont("roboto", 14))
      .setHeight(22)
      .setBackgroundHeight(130)
      ;

    cp5.addToggle("play_pause") 
      .setSize(90, 20)
      .setFont(createFont("roboto", 14))
      .setPosition(5, 5)
      .setValue(true)
      .setMode(ControlP5.SWITCH)
      .moveTo(g1)
      ;

    cp5.addButton("reset") 
      .setSize(90, 20)
      .setFont(createFont("roboto", 14))
      .setPosition(205, 5)
      .moveTo(g1)
      ;

    cp5.addTextarea("txt1")
      .setPosition(5, 60)
      .setSize(w, 50)
      .setFont(createFont("roboto", 14))
      .setLineHeight(16)
      .setText("'S' to save a frame")
      .moveTo(g1)
      ;
    cp5.addTextarea("txt2")
      .setPosition(5, 90)
      .setSize(w, 50)
      .setFont(createFont("roboto", 14))
      .setLineHeight(16)
      .setText("'L' to load a video")
      .moveTo(g1)
      ;




    Group g2 = cp5.addGroup("CHRONO-EFFECT")
      .setHeight(22)
      .setBackgroundColor(color(0, 64))
      .setBackgroundHeight(150)
      .setFont(createFont("roboto", 14))
      ;

    cp5.addSlider("removal_threshold")
      .setRange(0, 1)
      .setValue(params.removalThreshold)
      .setPosition(5, 5)
      .setSize(w-10, 30)
      .moveTo(g2)
      .getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER);
      


    Group g3 = cp5.addGroup("POST-PROCESSING")
      .setHeight(22)
      .setBackgroundColor(color(0, 64))
      .setBackgroundHeight(150)
      .setFont(createFont("roboto", 14))
      ;



    Accordion accordion;
    accordion = cp5.addAccordion("acc")
      .setPosition(0, 0)
      .setWidth(400)
      .addItem(g1)
      .addItem(g2)
      .addItem(g3);
    accordion.open(0, 1, 2);
  }

  void draw() {
    background(190);
  }

  ///////////////////////////////
  // callbacks video


  void play_pause(boolean v) {
    params.play = v;
  }

  void reset(boolean v) {
    movie.jump(0);
    background(0);
    initLayers();
    initShader();
    firstFrame= true;
  }
  
   ///////////////////////////////
  // callbacks chrono
  void removal_threshold(float v) {
    params.removalThreshold = v;
  }
  

  ///////////////////////////////
  // callbacks post process


  void result_vibrance(float v) {
    params.resVibrance = v;
  }



  void keyReleased() {
    if (key == 'l' || key =='L') {
      selectInput("Select a file to process:", "fileSelected");
    }
    if (key == 's' || key =='S') {
      saveFrame(nf(year(), 4, 0) + "-" + nf(month(), 2, 0) + "-" + nf(day(), 2, 0) + "-" +
        nf(hour(), 2, 0) + "h" + nf(minute(), 2, 0) + "m" + nf(second(), 2, 0) + "s.png");
    }
  }
}
