// a panel space that also can be drawn and displayed on the screen (think menu spaces)

class VisiblePanel extends Panel {
  
  color Col;
  
  PImage Norm;
  
  
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
    Col = a<<24|(Col>>16&0xFF)<<16|(Col>>8&0xFF)<<8|(Col&0xFF);
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