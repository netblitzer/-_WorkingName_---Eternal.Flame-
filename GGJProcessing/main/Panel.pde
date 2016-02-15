// a space on screen to contain other elements

class Panel extends GUIElement {
  
  protected ArrayList<GUIElement> children;
  
  Panel(PVector p, PVector s) {
    super(p, s);
    
    children = new ArrayList<GUIElement>();    
  }
  
  //-------------------//
  /* INHERITED METHODS */
  //-------------------//
  
  void updateActive(boolean state) {
    active = state;
    
    for (int i = 0; i < children.size(); i++) {
      children.get(i).updateActive(state);
    }
  }
  
  void updateAvailable(boolean state) {
    available = state;
    
    for (int i = 0; i < children.size(); i++) {
      children.get(i).updateAvailable(state);
    }
  }
  
  void updateVisible(boolean state) {
    visible = state;
    
    for (int i = 0; i < children.size(); i++) {
      children.get(i).updateVisible(state);
    }
  }
  
  void updateScreenSpace(PVector screenAdjust) {
    actualPos = globalLocation().copy();
    actualPos.set(actualPos.x * screenAdjust.x, actualPos.y * screenAdjust.y);
    actualSize.set(size.x * screenAdjust.x, size.y * screenAdjust.y);
    
    for (int i = 0; i < children.size(); i++) {
      children.get(i).updateScreenSpace(screenAdjust);
    }
  }
  
  void display() {
    for (int i = 0; i < children.size(); i++) {
      children.get(i).display();
    }
  }
  
  //---------------//
  /* CLASS METHODS */
  //---------------//
  
  void addChild(GUIElement child) {
    children.add(child);
    child.parent = this;
  }
  
  GUIElement getChild(int loc) {
    if (loc >= children.size() || loc < 0) {
      return null;
    } else {
      return children.get(loc);
    }
  }
  
}