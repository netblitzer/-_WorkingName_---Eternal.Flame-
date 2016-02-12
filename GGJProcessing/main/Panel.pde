// a dedicated space that can move around and carry elements with it
  // panels default to not being visible

class Panel extends GUIElement{
  
  int borderRadius;
  ArrayList<GUIElement> children;
  
  Panel(PVector p, PVector s, color c, int th, color bC) {
    super(p, s, c, bC);
    
    shp = createShape(RECT, 0, 0, size.x, size.y);
    shp.setFill(c);
    shp.setStroke(bC);
    shp.setStrokeWeight(th);
    
    borderRadius = 0;
    
    children = new ArrayList<GUIElement>();
    visible = false;
  }
  
  Panel(PVector p, PVector s, color c, int th, color bC, int bR) {
    super(p, s, c, bC);
    
    shp = createShape(RECT, 0, 0, size.x, size.y, bR);
    shp.setFill(c);
    shp.setStroke(bC);
    shp.setStrokeWeight(th);
    
    borderRadius = bR;
    
    children = new ArrayList<GUIElement>();
    visible = false;
  }
  
  Panel(String path, PVector p, PVector s, color c, int th, color bC) {
    super(p, s, c, bC);
    
    img = loadImage("textures/" + path);
    
    borderRadius = 0;
    
    children = new ArrayList<GUIElement>();
    visible = false;
  }
  
  void add(GUIElement newChild) {
    children.add(newChild);
    newChild.parent = this;
  }
  
  GUIElement get(int position) {
    if (position > children.size()) {
      return null;
    } else if (position < 0) {
      return null;
    } else {
      return children.get(position);
    }
  }
  
  boolean fadeIn(int speed, PVector sizeAdjust) {
    boolean returnType = active;
    if (!returnType) {
      display(sizeAdjust);
      if (fade >= 255) {
        active = true;
        returnType = true;
      } else {
        fade = constrain(fade + speed, 0, 255);
      }
      Col = fade<<24|(Col>>16&0xFF)<<16|(Col>>8&0xFF)<<8|Col&0xFF;
      BCol = fade<<24|(BCol>>16&0xFF)<<16|(BCol>>8&0xFF)<<8|BCol&0xFF;
      
      for(int i = 0; i < children.size(); i++) {
        children.get(i).parentFading(fade, active);
        //children.get(i).display(sizeAdjust);
      }
    }
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
    
    for(int i = 0; i < children.size(); i++) {
      children.get(i).parentFading(fade, active);
      children.get(i).display(sizeAdjust);
    }
    return returnType;
  }
  
  void display(PVector sizeAdjust) {
    pushMatrix();
    
    translate(pos.x * sizeAdjust.x, pos.y * sizeAdjust.y);
    scale(sizeAdjust.x, sizeAdjust.y);
    
    if (visible) {
      if (shp == null && img != null) {
        tint(Col);
        image(img, 0, 0, size.x, size.y);
      } else if (img == null && shp != null) {
        shp.setFill(Col);
        shp.setStroke(BCol);;
        shape(shp);
      }
    }
    
    for(int i = 0; i < children.size(); i++) {
      children.get(i).display(sizeAdjust);
    }
    
    popMatrix();
  }
  
  void parentFading(int f, boolean a) {
    fade = f;
    Col = fade<<24|(Col>>16&0xFF)<<16|(Col>>8&0xFF)<<8|Col&0xFF;
    BCol = fade<<24|(BCol>>16&0xFF)<<16|(BCol>>8&0xFF)<<8|BCol&0xFF;
    active = a;
    
    for(int i = 0; i < children.size(); i++) {
      children.get(i).parentFading(f, a);
    }
  }
  
  void changeActiveState(boolean state) {
    active = state;
    for(int i = 0; i < children.size(); i++) {
      children.get(i).changeActiveState(state);
    }
  }
  
  // change this and all children's visibilty
  void changeVisibility(boolean state) {
    visible = state;
    for(int i = 0; i < children.size(); i++) {
      children.get(i).changeVisibility(state);
    }
  }
  
  // dedicated function to make panels and ONLY panels visibility change
  void changeThisVisibility(boolean state) {
    visible = state;
  }
}