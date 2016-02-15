// a button that also can contain objects

class ButtonContainer extends VisiblePanel {
  
  protected color HighCol;
  protected color DarkCol;
  
  protected PImage High;
  protected PImage Dark;
  
  protected boolean leftClicked;
  protected boolean rightClicked;
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
    mode = 0;
  }
  
  ButtonContainer(PVector p, PVector s, color C, color HighC, color DarkC) { // 
    super(p, s, C);
    
    HighCol = HighC;
    DarkCol = DarkC;
  }
  
  ButtonContainer(PVector p, PVector s, String path) {
    super(p, s, path);
    
    HighCol = 255<<24|255<<16|255<<8|255;
    DarkCol = 255<<24|100<<16|100<<8|100;
  }
  
  ButtonContainer(PVector p, PVector s, String path, String HighPath, String DarkPath) {
    super(p, s, path);
    
    High = loadImage("textures/" + HighPath);
    Dark = loadImage("textures/" + DarkPath);
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
            image(Norm, actualPos.x, actualPos.y, actualSize.x, actualSize.x);
          } else { // highlighted and normal images present
            tint(Col);
            image(High, actualPos.x, actualPos.y, actualSize.x, actualSize.x);
          }
        }
      } else if (mode == 2 || mode == 3) { // pressed down (right or left click)
        if (Norm == null) { // no images at all
          fill(DarkCol);
          rect(actualPos.x, actualPos.y, actualSize.x, actualSize.y);
        } else { // normal image present
          if (Dark == null) { // no pressed image
            tint(DarkCol);
            image(Norm, actualPos.x, actualPos.y, actualSize.x, actualSize.x);
          } else { // pressed and normal images present
            tint(Col);
            image(Dark, actualPos.x, actualPos.y, actualSize.x, actualSize.x);
          }
        }
      } else { // nothing occuring on the button
        if (Norm == null) { // no images present
          fill(Col);
          rect(actualPos.x, actualPos.y, actualSize.x, actualSize.y);
        } else { // normal image present
          tint(Col);
          image(Norm, actualPos.x, actualPos.y, actualSize.x, actualSize.x);
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
    
    if (mouseX > actualPos.x && mouseX < actualPos.x + actualSize.x && mouseY > actualPos.y && mouseY < actualPos.y + actualSize.y) {
      // mouse over
      if (mouseButton == LEFT && mousePressed) {
        mode = 2;
      } else if (mouseButton == RIGHT && mousePressed) {
        mode = 3;
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
    
    for (int i = 0; i < children.size(); i++) {
      children.get(i).updateScreenSpace(screenAdjust);
    }
  } 
  
  boolean isLeftClicked() {
    return leftClicked;
  }
  
  boolean isRightClicked() {
    return rightClicked;
  }
}