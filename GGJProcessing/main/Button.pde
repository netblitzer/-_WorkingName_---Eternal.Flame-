// basic "click" button, can be used for things like scroll bars too

class Button extends GUIElement {
  
  PImage pressed;
  PImage high;
  color hghCol;
  color drkCol;
  color hghBCol;
  color drkBCol;
  byte mode; // 0 for normal, 1 for hovered over, 2 for pressed down (LEFT), 3 for pressed down (RIGHT)
  public boolean clicked;
  
  Button(PVector p, PVector s, color c, int th, color bC) {
    super(p, s, c, bC);
    
    shp = createShape(RECT, 0, 0, size.x, size.y);
    shp.setFill(c);
    shp.setStroke(bC);
    shp.setStrokeWeight(th);
    
    hghBCol = (int)(bC * 1.25);
    drkBCol = (int)(bC * 0.75);
    hghCol = (int)(c * 1.25);
    drkCol = (int)(c * 0.75);
    
    mode = 0;
    clicked = false;
  }
  Button(int bR, PVector p, PVector s, color c, color bC) {
    super(p, s, c, bC);
    
    shp = createShape(RECT, 0, 0, size.x, size.y, bR);
    shp.setFill(c);
    shp.setStroke(bC);
    shp.setStrokeWeight(0);
    
    hghBCol = (int)(bC * 1.25);
    drkBCol = (int)(bC * 0.75);
    hghCol = (int)(c * 1.25);
    drkCol = (int)(c * 0.75);
    
    mode = 0;
    clicked = false;
  }
  Button(String path, PVector p, PVector s, color c, color bC) {
    super(p, s, c, bC);
    
    img = loadImage("textures/" + path);
    hghCol = (int)(c * 1.25);
    drkCol = (int)(c * 0.75);
  }
  Button(String path, String downPath, String highPath, PVector p, PVector s, color c, color bC) {
    super(p, s, c, bC);
    
    img = loadImage("textures/" + path);
    high = loadImage("textures/" + highPath);
    pressed = loadImage("textures/" + downPath);
  }
  
  boolean fadeIn(int speed, PVector sizeAdjust) {
    boolean returnType = false;
    display(sizeAdjust);
    if (fade >= 255) {
      active = true;
      returnType = true;
    } else {
      fade = constrain(fade + speed, 0, 255);
    }
    Col = fade<<24|(Col>>16&0xFF)<<16|(Col>>8&0xFF)<<8|Col&0xFF;
    BCol = fade<<24|(BCol>>16&0xFF)<<16|(BCol>>8&0xFF)<<8|BCol&0xFF;
    return returnType;
  }
  
  boolean fadeOut(int speed) {
    boolean returnType = false;
    display(sizeAdjust);
    if (fade <= 0) {
      returnType = true;
    } else {
      active = false;
      fade = constrain(fade - speed, 0, 255);
    }
    Col = fade<<24|(Col>>16&0xFF)<<16|(Col>>8&0xFF)<<8|Col&0xFF;
    BCol = fade<<24|(BCol>>16&0xFF)<<16|(BCol>>8&0xFF)<<8|BCol&0xFF;
    return returnType;
  }
  
  void display(PVector sizeAdjust) {
    updateState(sizeAdjust);
    
    translate(pos.x * sizeAdjust.x, pos.y * sizeAdjust.y);
    if (visible) {
      if (shp == null && img != null) {
        tint(Col);
        if (active) {
          if (mode == 0) {
            image(img, 0, 0, size.x, size.y);
            //image(img, pos.x * sizeAdjust.x, pos.y * sizeAdjust.y, size.x * sizeAdjust.x, size.y * sizeAdjust.y);
          } else if (mode == 1) {
            image(high, 0, 0, size.x, size.y);
            //image(high, pos.x * sizeAdjust.x, pos.y * sizeAdjust.y, size.x * sizeAdjust.x, size.y * sizeAdjust.y);
          } else if (mode == 2) {
            image(pressed, 0, 0, size.x, size.y);
            //image(pressed, pos.x * sizeAdjust.x, pos.y * sizeAdjust.y, size.x * sizeAdjust.x, size.y * sizeAdjust.y);
          }
        } else {
            image(pressed, 0, 0, size.x, size.y);
        }
      } else if (img == null && shp != null) {
        if (active) {
          if (mode == 0) {
            shp.setFill(Col);
            shp.setStroke(BCol);;
            shape(shp);
          } else if (mode == 1) {
            shp.setFill(hghCol);
            shp.setStroke(hghBCol);;
            shape(shp);
          } else if (mode == 2) {
            shp.setFill(drkCol);
            shp.setStroke(drkBCol);;
            shape(shp);
          }
        } else {
          shp.setFill(drkCol);
          shp.setStroke(drkBCol);;
          shape(shp);
        }
      }
    }
    
    translate(-pos.x * sizeAdjust.x, -pos.y * sizeAdjust.y);
    
  }
  
  void updateState(PVector sizeAdjust) {
    actualPos = globalLocation(sizeAdjust).copy();
    actualSize.set(size.x * sizeAdjust.x, size.y * sizeAdjust.y);
    
    if (mouseX > actualPos.x && mouseX < actualPos.x + actualSize.x && mouseY > actualPos.y && mouseY < actualPos.y + actualSize.y) {
      // mouse over
      if (mousePressed && mouseButton == LEFT) {
        mode = 2;
      } else if (mode == 2) {
        clicked = true;
        mode = 1;
      } else if (mode == 0) {
        mode = 1;
      }
    } else {
      mode = 0;
    }
  }
  
  void parentFading(int f, boolean a) {
    fade = f;
    Col = fade<<24|(Col>>16&0xFF)<<16|(Col>>8&0xFF)<<8|Col&0xFF;
    BCol = fade<<24|(BCol>>16&0xFF)<<16|(BCol>>8&0xFF)<<8|BCol&0xFF;
    active = a;
  }
  
  void changeActiveState(boolean state) {
    active = state;
  }
  
  void changeVisibility(boolean state) {
    visible = state;
  }
}