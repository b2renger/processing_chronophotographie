// add option to set resolution


import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;
import processing.video.*;
import controlP5.*;

public ControlP5 cp5;
PostFX fx;
public Params params;
Movie movie;
String file = "C0052.mp4";

boolean firstFrame = true;

// removal algorithm
PShader bgRemove;
// two Pgraphics one for the bg one for the current image to remove from
PGraphics bg, current;
// on to hold results
PGraphics result;


void settings() {
  size(1280, 720, P2D);
}

void setup() {

  background(0);
  pixelDensity(1);
  params = new Params();
 
  surface.setResizable(true);
  setup_gui();

  // prompt user to select a video file
  //selectInput("Select a file to process:", "fileSelected");

  // Load and play a default video
  movie = new Movie(this, file);
  movie.loop();

  initLayers();
  initShader();


  // post processing
  fx = new PostFX(this);
}


void draw() {
  background(0);
  
  
  if (params.play) {
    movie.loop();
  } else {
    movie.pause();
  }

  if (firstFrame) {
    bg.beginDraw();  
    bg.image(movie, 0, 0, bg.width, bg.height);
    bg.endDraw();

    firstFrame = false;
  } else {

    current.beginDraw();  
    current.image(movie, 0, 0, current.width, current.height);
    current.endDraw();

    float op;
    if (frameCount%params.maxFrame < params.nFrame) {
      op = params.maxOpacity;
    } else {
      op = params.minOpacity;
    }
    // pass uniforms to shader
    bgRemove.set( "threshold", params.removalThreshold);
    bgRemove.set( "opacity", op);
    // pass textures
    bgRemove.set( "bg", bg ); 
    bgRemove.set( "current", current );

    // draw result in buffer
    result.beginDraw();
    result.shader(bgRemove);
    result.rect(0, 0, width, height);
    result.endDraw();

    // blend bg and result together
    blendMode(BLEND);
    image(bg, 0, 0);
    image(result, 0, 0);

    // post processing on bg and result
    blendMode(SCREEN);
    if (params.backgroundPostProcess) {
      fx.render(bg)    
        .saturationVibrance(params.bgSaturation, params.bgVibrance)
        .blur(params.bgBlurAmount, params.bgBlurAmount)
        .compose();
    }
    if (params.resultPostProcess) {
      fx.render(result)    
        .saturationVibrance(params.resSaturation, params.resVibrance)
        .blur(params.resBlurAmount, params.resBlurAmount)
        .bloom(params.resThreshold, params.resBlur, params.resSigma)
        .compose();
    }
    
     fx.render()    
        .saturationVibrance(params.resSaturation, params.resVibrance)
        .blur(params.resBlurAmount, params.resBlurAmount)
        .bloom(params.resThreshold, params.resBlur, params.resSigma)
        .compose();
    
  }
}

void movieEvent(Movie m) {
  m.read();
}


void keyReleased() {
  shortcuts();
}

public void shortcuts(){
  if (key == 'l' || key =='L') {
      selectInput("Select a file to process:", "fileSelected");
    }
    if (key == 's' || key =='S') {
      saveFrame(nf(year(), 4, 0) + "-" + nf(month(), 2, 0) + "-" + nf(day(), 2, 0) + "-" +
        nf(hour(), 2, 0) + "h" + nf(minute(), 2, 0) + "m" + nf(second(), 2, 0) + "s.png");
    }
    if (key == '1') setResolution(0);
    if (key == '2') setResolution(1);
    if (key == '3') setResolution(2);
}

public void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    file = selection.getAbsolutePath();
   
    movie = new Movie(this, file);
    movie.loop();
    firstFrame = true;
    //surface.setSize(movie.width, movie.height);
    initLayers();
    initShader();

  }
}


public void setResolution(int a) {
  if (a == 1) {
    surface.setSize(800, 600);
  } else if (a == 2) {
    surface.setSize(1280, 720);
  } else if (a ==3){
    surface.setSize(1920, 1080);
  }
  background(0);
  initLayers();
  initShader();
  firstFrame= true;
  fx = new PostFX(this);
}

void initLayers() {
  bg = createGraphics(width, height, P2D);
  current = createGraphics(width, height, P2D);
  result = createGraphics(width, height, P2D);
}

void initShader(){
  bgRemove = loadShader( "removal.glsl" );
  bgRemove.set( "sketchSize", float(width), float(height) );
  bgRemove.set( "bg", bg ); 
  bgRemove.set( "current", current );
  bgRemove.set( "topLayerResolution", float( width ), float( height ) );
  bgRemove.set( "lowLayerResolution", float( width ), float( height ) );
}
