// basic "click" button, can be used for things like scroll bars too

class Button extends GUIElement {
  
  PImage pressed;
  PImage high;
  color hghCol;
  color drkCol;
  color hghBCol;
  color drkBCol;
  
  Button(PVector p, PVector s, color c, int th, color bC) {
    super(p, s, c, th, bC);
    
    shp = createShape(RECT, 0, 0, size.x, size.y);
    shp.setFill(c);
    shp.setStroke(bC);
    shp.setStrokeWeight(th);
    
    hghBCol = (int)(bC * 1.25);
    drkBCol = (int)(bC * 0.75);
    hghCol = (int)(c * 1.25);
    drkCol = (int)(c * 0.75);
  }
  Button(String path, PVector p, PVector s, color c, int th, color bC) {
    super(p, s, c, th, bC);
    
    img = loadImage("textures/" + path);
    hghCol = (int)(c * 1.25);
    drkCol = (int)(c * 0.75);
  }
  Button(String path, String downPath, String highPath, PVector p, PVector s, color c, int th, color bC) {
    super(p, s, c, th, bC);
    
    img = loadImage("textures/" + path);
    high = loadImage("textures/" + highPath);
    pressed = loadImage("textures/" + downPath);
  }
  
  void display(PVector sizeAdjust) {
    if (shp == null && img != null) {
      tint(Col);
      image(img, pos.x * sizeAdjust.x, pos.y * sizeAdjust.y, size.x * sizeAdjust.x, size.y * sizeAdjust.y);
    } else if (img == null && shp != null) {
      shp.setFill(Col);
      shp.setStroke(BCol);
      pushMatrix();
      
      translate(pos.x * sizeAdjust.x, pos.y * sizeAdjust.y);
      scale(sizeAdjust.x, sizeAdjust.y);
      shape(shp);
      
      popMatrix();
    }
  }
}