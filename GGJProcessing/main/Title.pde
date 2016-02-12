// for big text

class Title extends GUIElement {
  
  
  Title(String path, PVector p, PVector s, color c, color borderC) {
     super(p, s, c, borderC);
     
     img = loadImage("textures/" + path);
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
    tint(Col);
    if (visible) {
      image(img, pos.x * sizeAdjust.x, pos.y * sizeAdjust.y, size.x * sizeAdjust.x, size.y * sizeAdjust.y);
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