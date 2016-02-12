// abstract class that gives all GUIElements their main attributes and methods

abstract class GUIElement {
  
  boolean active;
  boolean available;
  boolean visible;
  PVector pos;
  PVector size;
  PVector actualPos;
  PVector actualSize;
  GUIElement parent;
  
  GUIElement(PVector p, PVector s) {
    pos = p.copy();
    size = s.copy();
    actualPos = pos.copy();
    actualSize = size.copy();
    
    active = false;
    available = false;
    visible = false;
    
    parent = null;
  }
  
  abstract void display(); // the draw method for each element
  abstract void updateActive(boolean state); // changes this element's active state and all children, if any
  abstract void updateAvailable(boolean state); // changes this element's available state and all children, if any
  abstract void updateVisible(boolean state); // changes this element's visible state and all children, if any
  abstract void updateScreenSpace(PVector screenAdjust); // changes this element's actual position and size
  
  // returns the active variable state
  boolean isActive() {
    return active;
  }
  
  // returns the available variable state
  boolean isAvailable() {
    return available;
  }
  
  // returns the visible variable state
  boolean isGUIVisible() {
    return visible;
  }
  
  // returns the global location of the element, not the local (used for drawing)
  PVector globalLocation() {
    PVector loc;
    if (parent != null) {
      loc = PVector.add(parent.globalLocation(), pos);
    } else {
      loc = pos.copy();
    }
    
    return loc;
  }
  
  // updates the position the element is at
  void updateLocation(PVector newLoc) {
    pos.set(newLoc.x, newLoc.y);
  }
}