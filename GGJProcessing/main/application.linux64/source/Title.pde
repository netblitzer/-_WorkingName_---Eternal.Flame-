// for big text

class Title extends GUIElement {
  
  
  
  Title(String path, PVector p, PVector s, color c, int borderThickness, color borderC) {
     super(p, s, c, borderThickness, borderC);
     
     img = loadImage("textures/" + path);
  }
  
  
  void display(PVector sizeAdjust) {
    tint(Col);
    image(img, pos.x * sizeAdjust.x, pos.y * sizeAdjust.y, size.x * sizeAdjust.x, size.y * sizeAdjust.y);
  }
}