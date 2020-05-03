public ControlFrame cf;



public void setup_gui() {
  //cp5 = new ControlP5(this);
  cf = new ControlFrame(this, 300, 800, "Controls");
  surface.setLocation(320, 50);
}



public class ControlFrame extends PApplet {

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
    surface.setLocation(10, 50);
    cp5 = new ControlP5(this);

    Group g1 = cp5.addGroup("OPTIONS")
      .setBackgroundColor(color(0, 64))
      .setFont(createFont("roboto", 14))
      .setHeight(22)
      .setBackgroundHeight(170)
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
      /*
     cp5.addTextarea("switch resolution")
      .setPosition(5, 120)
      .setSize(w, 50)
      .setFont(createFont("roboto", 14))
      .setLineHeight(16)
      .setText("'1' for XGA   -   '2' for HD   -   '3' for fullHD")
      .moveTo(g1)
      ;*/
      
      cp5.addRadioButton("resolutionRadio")
         .setPosition(5,130)
         .setSize(40,20)
         .setColorForeground(color(120))
         .setColorActive(color(255))
         .setColorLabel(color(255))
         .setItemsPerRow(5)
         .setSpacingColumn(50)
         .addItem("SVGA",1)
         .addItem("HD",2)
         .addItem("FULLHS",3)
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
      .setValue(0.25)
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
  
  void resolutionRadio(int a){
    setResolution(a);
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
    shortcuts();
  }
}
