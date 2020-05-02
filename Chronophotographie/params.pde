class Params {
  
  boolean play = false;

  boolean backgroundPostProcess = true;
  boolean resultPostProcess = true;
  
  float removalThreshold = 0.1;
  
  int bgBlurAmount = 10;
  float bgSaturation = 0.1;
  float bgVibrance = 0.1;
  
  int resBlurAmount = 10;
  float resSaturation = 0.1;
  float resVibrance = 0.1;
  float resSigma = 0.2;
  int resBlur = 20;
  float resThreshold = 25;
   
  // every max Frame draw nFrame at max opacity
  float minOpacity = 0.1;
  float maxOpacity = 1;
  float maxFrame = 25;
  float nFrame = 10;
  
  
  Params() {
  }
}
