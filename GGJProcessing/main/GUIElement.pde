// gives basic functions for gui elements to extend off of

abstract class GUIElement {
  
  public PVector pos;
  PVector actualPos;
  PVector size;
  PVector actualSize;
  int fade;
  PShape shp;
  PImage img;
  boolean active;
  boolean available;
  boolean visible;
  color Col;
  color BCol;
  GUIElement parent;

  GUIElement(PVector p, PVector s, color c, color borderC) {
    pos = p.copy();
    size = s.copy();
    actualPos = pos.copy();
    actualSize = size.copy();
    
    Col = c;
    BCol = borderC;
    
    fade = 0;    
    active = false;
    available = false;
    parent = null;
  }
  
  abstract void display(PVector sizeAdjust);
  abstract void changeActiveState(boolean state);
  abstract void parentFading(int f, boolean a);
  abstract void changeVisibility(boolean state);
  
  PVector globalLocation(PVector sizeAdjust) {
    PVector loc;
    if (parent != null) {
      loc = PVector.add(parent.globalLocation(sizeAdjust), pos);
    } else {
      loc = pos.copy();
    }
    
    return loc;
  }
  
  boolean isActive() {
    return active;
  }
  
  boolean isAvailable() {
    return available;
  }
  
  boolean isGUIVisible() {
    return visible;
  }
  
  
}