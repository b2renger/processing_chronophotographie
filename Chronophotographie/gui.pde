public ControlFrame cf;

int accHeight = 230;

public void setup_gui() {
  //cp5 = new ControlP5(this);
  cf = new ControlFrame(this, 300, accHeight*3, "Controls");
  surface.setLocation(320, 50);
}



public class ControlFrame extends PApplet {

  int w, h;
  PApplet parent;
  ControlP5 cp5;
  Toggle render;
  Toggle play;
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
    surface.setLocation(10, 50);
    cp5 = new ControlP5(this);
    ///////////////////////////////////
    // BASIC OPTIONS
    Group g1 = cp5.addGroup("OPTIONS")
      .setBackgroundColor(color(0, 64))
      .setFont(createFont("roboto", 14))
      .setHeight(22)
      .setBackgroundHeight(accHeight)
      ;

    play = cp5.addToggle("play_pause") 
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
    cp5.addTextarea("txtLoad")
      .setPosition(5, 90)
      .setSize(w, 50)
      .setFont(createFont("roboto", 14))
      .setLineHeight(16)
      .setText("'L' to load a video")
      .moveTo(g1)
      ;

    cp5.addRadioButton("resolutionRadio")
      .setPosition(5, 120)
      .setSize(40, 20)
      .setColorForeground(color(120))
      .setColorActive(color(255))
      .setColorLabel(color(255))
      .setItemsPerRow(5)
      .setSpacingColumn(50)
      .addItem("SVGA", 1)
      .addItem("HD", 2)
      .addItem("FULLHD", 3)
      .moveTo(g1)
      ;

    cp5.addTextfield("file_name")
      .setPosition(5, 170)
      .setSize(200, 25)
      .setFont(createFont("roboto", 14))
      .setFocus(true)
      .setColor(color(255, 0, 0))
      ;


    render = cp5.addToggle("record")
      .setPosition(5, 200)
      .setSize(100, 25)
      .setFont(createFont("roboto", 14))
      .moveTo(g1);
    render.getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);

    render = cp5.addToggle("render")
      .setPosition(195, 200)
      .setSize(100, 25)
      .setFont(createFont("roboto", 14))
      .moveTo(g1);
    render.getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);

    ///////////////////////////////////
    // CHRONO OPTIONS
    Group g2 = cp5.addGroup("CHRONO-EFFECT")
      .setHeight(22)
      .setBackgroundColor(color(0, 64))
      .setBackgroundHeight(accHeight/2)
      .setFont(createFont("roboto", 14))
      ;

    cp5.addSlider("removal_threshold")
      .setRange(0, 1)
      .setValue(0.25)
      .setPosition(5, 5)
      .setSize(w-10, 30)
      .moveTo(g2)
      .setFont(createFont("roboto", 14))
      .getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER);

    cp5.addTextarea("txt3")
      .setPosition(5, 40)
      .setSize(w, 50)
      .setFont(createFont("roboto", 14))
      .setLineHeight(16)
      .setText("Display only every nFrame over maxFrame :")
      .moveTo(g2)
      ;

    cp5.addRange("nFrame_maxFrame")
      .setBroadcast(false) 
      .setPosition(5, 65)
      .setSize(290, 40)
      .setHandleSize(20)
      .setRange(1, 300)
      .setRangeValues(1, 30)
      .setBroadcast(true)
      .setFont(createFont("roboto", 14))
      .moveTo(g2)
      ;



    ///////////////////////////////////
    // POST-PORCESS OPTIONS
    Group g3 = cp5.addGroup("POST-PROCESSING")
      .setHeight(22)
      .setBackgroundColor(color(0, 64))
      .setBackgroundHeight(accHeight)
      .setFont(createFont("roboto", 14))
      ;

    cp5.addSlider("saturation")
      .setRange(0, 2)
      .setValue(0.15)
      .setPosition(5, 5)
      .setSize(w-10, 30)
      .moveTo(g3)
      .setFont(createFont("roboto", 14))
      .getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER);

    cp5.addSlider("vibrance")
      .setRange(0, 2)
      .setValue(0.4)
      .setPosition(5, 45)
      .setSize(w-10, 30)
      .moveTo(g3)
      .setFont(createFont("roboto", 14))
      .getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER);

    cp5.addKnob("blur")
      .setRange(0, 100)
      .setValue(10)
      .setPosition(100, 95)
      .setRadius(50)
      .setNumberOfTickMarks(50)
      .setTickMarkLength(4)
      .snapToTickMarks(true)
      .setColorActive(color(255, 255, 0))
      .setDragDirection(Knob.HORIZONTAL)
      .moveTo(g3)
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
    fill(255);
    text("fps : " + nf(fr, 2, 2), 5, accHeight*3 - 20);

    if (recording) {
      noStroke();
      fill(255, 0, 0, sin(frameCount/10.)*255);
      ellipse(w-25, accHeight*3-20, 20, 20);
    }
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
    nFrame =0;
  }

  void resolutionRadio(int a) {
    setResolution(a);
  }

  public void file_name(String theText) {
    recordingName = theText;
    videoExport = new VideoExport(this, recordingName + ".mp4");
    videoExport.startMovie();
  }


  void render(boolean v) {
    videoExport.endMovie();
  }

  void record(boolean v) {
    recording = !recording;
    println("Recording is " + (recording ? "ON" : "OFF"));
  }


  ///////////////////////////////
  // callbacks chrono
  void removal_threshold(float v) {
    params.removalThreshold = v;
  }

  void controlEvent(ControlEvent theControlEvent) {
    if (theControlEvent.isFrom("nFrame_maxFrame")) {
      params.nFrame = int(theControlEvent.getController().getArrayValue(0));
      params.maxFrame = int(theControlEvent.getController().getArrayValue(1));
      //println("range update, done.");
    }
  }



  ///////////////////////////////
  // callbacks post process
  void saturation(float v) {
    params.resSaturation = v;
  }

  void vibrance(float v) {
    params.resVibrance = v;
  }

  void blur(int v) {
    params.resBlurAmount = v;
  }



  void keyReleased() {
    shortcuts();
  }
}
