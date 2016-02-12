// gives basic functions for gui elements to extend off of

abstract class GUIElement {
  
  PVector pos;
  PVector size;
  int fade;
  PShape shp;
  PImage img;
  public boolean active;
  color Col;
  color BCol;

  GUIElement(PVector p, PVector s, color c, int borderThickness, color borderC) {
    pos = p.copy();
    size = s.copy();
    
    Col = c;
    BCol = borderC;
    
    fade = 0;    
    active = false;
  }
  
  abstract void display(PVector sizeAdjust);
  
  boolean FadeIn(int speed, PVector sizeAdjust) {
    boolean returnType = false;
    display(sizeAdjust);
    if (fade >= 255) {
      active = true;
      returnType = true;
    } else {
      fade = clamp(fade + speed, 255, 0);
    }
    Col = fade<<24|(Col>>16&0xFF)<<16|(Col>>8&0xFF)<<8|Col&0xFF;
    BCol = fade<<24|(BCol>>16&0xFF)<<16|(BCol>>8&0xFF)<<8|BCol&0xFF;
    return returnType;
  }
  
  boolean FadeOut(int speed) {
    boolean returnType = false;
    display(sizeAdjust);
    if (fade <= 0) {
      returnType = true;
    } else {
      active = false;
      fade = clamp(fade - speed, 255, 0);
    }
    Col = fade<<24|(Col>>16&0xFF)<<16|(Col>>8&0xFF)<<8|Col&0xFF;
    BCol = fade<<24|(BCol>>16&0xFF)<<16|(BCol>>8&0xFF)<<8|BCol&0xFF;
    return returnType;
  }
  
  boolean Active() {
    return active;
  }
  
  int clamp(int val, int max, int min) {
    if(val > max)
      return max;
    else if(val < min)
      return min;
    else
      return val;
  }
}