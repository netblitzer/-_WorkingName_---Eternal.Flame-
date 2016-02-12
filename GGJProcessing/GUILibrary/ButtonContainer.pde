// a button that also can contain objects

class ButtonContainer extends VisiblePanel {
  
  color HighCol;
  color DarkCol;
  
  PImage High;
  PImage Dark;
  
  boolean leftClicked;
  boolean rightClicked;
  byte mode; // 0 for normal, 1 for hovered over, 2 for pressed down (LEFT), 3 for pressed down (RIGHT)
  
  ButtonContainer(PVector p, PVector s, color C) { // basic panel
    super(p, s, C);
    
    HighCol = (int) (C * 1.25);
    DarkCol = (int) (C * 0.75);
    
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
    
    PImage High = loadImage("textures/" + HighPath);
    PImage Dark = loadImage("textures/" + DarkPath);
  }
  
  void display() {
    
    
  }
  
  void updateScreenSpace(PVector screenAdjust) {
    actualPos = globalLocation().copy();
    actualPos.set(actualPos.x * screenAdjust.x, actualPos.y * screenAdjust.y);
    actualSize.set(size.x * screenAdjust.x, size.y * screenAdjust.y);
    
    if (mouseX > actualPos.x && mouseX < actualPos.x + actualSize.x && mouseY > actualPos.y && mouseY < actualPos.y + actualSize.y) {
      // mouse over
      if (mousePressed && mouseButton == LEFT) {
        mode = 2;
      } else if (mousePressed && mouseButton == RIGHT) {
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
  
}