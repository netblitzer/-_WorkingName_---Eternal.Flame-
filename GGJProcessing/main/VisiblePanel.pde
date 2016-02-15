// a panel space that also can be drawn and displayed on the screen (think menu spaces)

class VisiblePanel extends Panel {
  
  protected color Col;
  
  protected PImage Norm;
  
  VisiblePanel(PVector p, PVector s, color C) { // basic panel
    super(p, s);
    
    Col = C;
  }
  
  VisiblePanel(PVector p, PVector s, String path) {
    super(p, s);
    
    Norm = loadImage("textures/" + path);
    
    Col = 255<<24|255<<16|255<<8|255;
  }
  
  void updateAlpha(int a) {
    a = pixelConstrain(a);
    Col = a<<24|(Col>>16&0xFF)<<16|(Col>>8&0xFF)<<8|(Col&0xFF);
  }
  
  void updateRed(int r) {
    r = pixelConstrain(r);
    Col = (Col>>24&0xFF)<<24|r<<16|(Col>>8&0xFF)<<8|(Col&0xFF);
  }
  
  void updateGreen(int g) {
    g = pixelConstrain(g);
    Col = (Col>>24&0xFF)<<24|(Col>>16&0xFF)<<16|g<<8|(Col&0xFF);
  }
  
  void updateBlue(int b) {
    b = pixelConstrain(b);
    Col = (Col>>24&0xFF)<<24|(Col>>16&0xFF)<<16|(Col>>8&0xFF)<<8|b;
  }
  
  void updateColor(int C) {
    C &= 0xFFFFFFFF;
    Col = (C>>24&0xFF)<<24|(C>>16&0xFF)<<16|(C>>8&0xFF)<<8|(C&0xFF);
  }
  
  void display() {
    if (visible) {
      if (Norm == null) { // no images at all
        fill(Col);
        rect(actualPos.x, actualPos.y, actualSize.x, actualSize.y);
      } else {
        tint(Col);
        image(Norm, actualPos.x, actualPos.y, actualSize.x, actualSize.y);
      }
    }
  }
  
}