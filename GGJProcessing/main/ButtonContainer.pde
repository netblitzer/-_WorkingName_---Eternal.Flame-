// a button that also can contain objects

class ButtonContainer extends VisiblePanel {
  
  protected color HighCol;
  protected color DarkCol;
  
  protected PImage High;
  protected PImage Dark;
  
  protected boolean leftClicked;
  protected boolean rightClicked;
  protected boolean heldDown;
  protected byte mode; // 0 for normal, 1 for hovered over, 2 for pressed down (LEFT), 3 for pressed down (RIGHT)
  
  ButtonContainer(PVector p, PVector s, color C) { // basic panel
    super(p, s, C);
    
    //HighCol = (int) (C * 1.25);
    //DarkCol = (int) (C * 0.75);
    
    // bitwise color mapping is far faster
    int HR = pixelConstrain((C>>16&0xFF)*5/4);
    int HG = pixelConstrain((C>>8&0xFF)*5/4);
    int HB = pixelConstrain((C&0xFF)*5/4);
    int DR = pixelConstrain((C>>16&0xFF)*3/4);
    int DG = pixelConstrain((C>>8&0xFF)*3/4);
    int DB = pixelConstrain((C&0xFF)*3/4);
    HighCol = 255<<24|HR<<16|HG<<8|HB;
    DarkCol = 255<<24|DR<<16|DG<<8|DB;
    
    leftClicked = false;
    rightClicked = false;
    heldDown = false;
    mode = 0;
  }
  
  ButtonContainer(PVector p, PVector s, color C, color HighC, color DarkC) { // 
    super(p, s, C);
    
    HighCol = HighC;
    DarkCol = DarkC;
  }
  
  
  /* DEPRECATED */
  ButtonContainer(PVector p, PVector s, String path) {
    super(p, s, path);
    
    HighCol = 255<<24|255<<16|255<<8|255;
    DarkCol = 255<<24|100<<16|100<<8|100;
  }
  /* DEPRECATED */
  
  
  ButtonContainer(PVector p, PVector s, PImage I) {
    super(p, s, I);
    
    HighCol = 255<<24|255<<16|255<<8|255;
    DarkCol = 255<<24|100<<16|100<<8|100;
  }
  
  
  /* DEPRECATED */
  ButtonContainer(PVector p, PVector s, String path, String HighPath, String DarkPath) {
    super(p, s, path);
    
    High = loadImage("textures/" + HighPath);
    Dark = loadImage("textures/" + DarkPath);
  }
  /* DEPRECATED */
  
  
  ButtonContainer(PVector p, PVector s, PImage I, PImage HI, PImage DI) {
    super(p, s, I);
    
    High = HI;
    Dark = DI;
  }
  
  //----------------------------------//
  /* INHERITED AND OVERRIDDEN METHODS */
  //----------------------------------//
  
  void updateAlpha(int a) {
    a = pixelConstrain(a);
    Col = a<<24|(Col>>16&0xFF)<<16|(Col>>8&0xFF)<<8|(Col&0xFF);
    if (Norm == null) {
      HighCol = a<<24|(HighCol>>16&0xFF)<<16|(HighCol>>8&0xFF)<<8|(HighCol&0xFF);
      DarkCol = a<<24|(DarkCol>>16&0xFF)<<16|(DarkCol>>8&0xFF)<<8|(DarkCol&0xFF);
    }
  }
  
  void updateRed(int r) {
    r = pixelConstrain(r);
    Col = (Col>>24&0xFF)<<24|r<<16|(Col>>8&0xFF)<<8|(Col&0xFF);
    if (Norm == null) {
      HighCol = (HighCol>>24&0xFF)<<24|r<<16|(HighCol>>8&0xFF)<<8|(HighCol&0xFF);
      DarkCol = (DarkCol>>24&0xFF)<<24|r<<16|(DarkCol>>8&0xFF)<<8|(DarkCol&0xFF);
    }
  }
  
  void updateGreen(int g) {
    g = pixelConstrain(g);
    Col = (Col>>24&0xFF)<<24|(Col>>16&0xFF)<<16|g<<8|(Col&0xFF);
    if (Norm == null) {
      HighCol = (HighCol>>24&0xFF)<<24|(HighCol>>16&0xFF)<<16|g<<8|(HighCol&0xFF);
      DarkCol = (DarkCol>>24&0xFF)<<24|(DarkCol>>16&0xFF)<<16|g<<8|(DarkCol&0xFF);
    }
  }
  
  void updateBlue(int b) {
    b = pixelConstrain(b);
    Col = (Col>>24&0xFF)<<24|(Col>>16&0xFF)<<16|(Col>>8&0xFF)<<8|b;
    if (Norm == null) {
      HighCol = (HighCol>>24&0xFF)<<24|(HighCol>>16&0xFF)<<16|(HighCol>>8&0xFF)<<8|b;
      DarkCol = (Col>>24&0xFF)<<24|(DarkCol>>16&0xFF)<<16|(DarkCol>>8&0xFF)<<8|b;
    }
  }
  
  void updateColor(int C) {
    C &= 0xFFFFFFFF;
    Col = (C>>24&0xFF)<<24|(C>>16&0xFF)<<16|(C>>8&0xFF)<<8|(C&0xFF);
    
    if (Norm == null) {
      int HR = pixelConstrain((C>>16&0xFF)*5/4);
      int HG = pixelConstrain((C>>8&0xFF)*5/4);
      int HB = pixelConstrain((C&0xFF)*5/4);
      int DR = pixelConstrain((C>>16&0xFF)*3/4);
      int DG = pixelConstrain((C>>8&0xFF)*3/4);
      int DB = pixelConstrain((C&0xFF)*3/4);
      HighCol = 255<<24|HR<<16|HG<<8|HB;
      DarkCol = 255<<24|DR<<16|DG<<8|DB;
    }
  }
  
  void display() {
    if (visible) {
      if (mode == 1) { // highlighted
        if (Norm == null) { // no images at all
          fill(HighCol);
          rect(actualPos.x, actualPos.y, actualSize.x, actualSize.y);
        } else { // normal image present
          if (High == null) { // no highlighted image
            tint(HighCol);
            image(Norm, actualPos.x, actualPos.y, actualSize.x, actualSize.y);
          } else { // highlighted and normal images present
            tint(Col);
            image(High, actualPos.x, actualPos.y, actualSize.x, actualSize.y);
          }
        }
      } else if (mode == 2 || mode == 3) { // pressed down (right or left click)
        if (Norm == null) { // no images at all
          fill(DarkCol);
          rect(actualPos.x, actualPos.y, actualSize.x, actualSize.y);
        } else { // normal image present
          if (Dark == null) { // no pressed image
            tint(DarkCol);
            image(Norm, actualPos.x, actualPos.y, actualSize.x, actualSize.y);
          } else { // pressed and normal images present
            tint(Col);
            image(Dark, actualPos.x, actualPos.y, actualSize.x, actualSize.y);
          }
        }
      } else { // nothing occuring on the button
        if (Norm == null) { // no images present
          fill(Col);
          rect(actualPos.x, actualPos.y, actualSize.x, actualSize.y);
        } else { // normal image present
          tint(Col);
          image(Norm, actualPos.x, actualPos.y, actualSize.x, actualSize.y);
        }
      }
    }
  }
  
  void updateScreenSpace(PVector screenAdjust) {
    actualPos = globalLocation().copy();
    actualPos.set(actualPos.x * screenAdjust.x, actualPos.y * screenAdjust.y);
    actualSize.set(size.x * screenAdjust.x, size.y * screenAdjust.y);
    
    leftClicked = false;
    rightClicked = false;
    
    if (visible) {
      if (active) {
        if (available) {
          if (mouseX > actualPos.x && mouseX < actualPos.x + actualSize.x && mouseY > actualPos.y && mouseY < actualPos.y + actualSize.y) {
            // mouse over
            if (mouseButton == LEFT && mousePressed) {
              mode = 2;
              heldDown = true;
            } else if (mouseButton == RIGHT && mousePressed) {
              mode = 3;
              heldDown = true;
            } else if (mode == 2) {
              leftClicked = true;
              mode = 1;
            } else if (mode == 3) {
              rightClicked = true;
              mode = 1;
            } else if (mode == 0) {
              mode = 1;
            }
          } else {
            mode = 0;
          }
        } else {
          mode = 0;
        }
      } else {
        mode = 2;
      }
    }
    
    for (int i = 0; i < children.size(); i++) {
      children.get(i).updateScreenSpace(screenAdjust);
    }
  } 
  
  //---------------//
  /* CLASS METHODS */
  //---------------//
  
  boolean isLeftClicked() {
    return leftClicked;
  }
  
  boolean isRightClicked() {
    return rightClicked;
  }
  
  boolean isHeldDown() {
    return heldDown;
  }
  
  void updateImage(String newPath) {
    Norm = loadImage("textures/" + newPath);
  }
  
  void updateImage(String newPath, String newHighPath, String newDarkPath) {
    Norm = loadImage("textures/" + newPath);
    High = loadImage("textures/" + newHighPath);
    Dark = loadImage("textures/" + newDarkPath);
  }
}