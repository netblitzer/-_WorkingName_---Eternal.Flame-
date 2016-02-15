Panel startMenu;
PVector posi;
PVector screenAdjust;
PVector screenSize;

void setup() {
  size(1280, 720, P2D);
  screenSize = new PVector(1280, 720);
  screenAdjust = new PVector(1, 1);
  
  startMenu = new Panel(new PVector(0, 0), new PVector(1280, 720));
  startMenu.addChild(new VisiblePanel(new PVector(0, 0), new PVector(300, 200), color(50)));
  startMenu.addChild(new ButtonContainer(new PVector(300, 200), new PVector(300, 200), color(220,100,80)));
  ((Panel) startMenu.getChild(0)).updateVisible(true);
  ((Panel) startMenu.getChild(1)).updateVisible(true);
  
  
  // testing speeeeeeds
  /*int size = 10;
  for (int i = 0; i < 128; i++) {
    for (int j = 0; j < 72; j++) {
      startMenu.addChild(new ButtonContainer(new PVector(0 + size * i, 0 + size * j), new PVector(size, size), color(0)));
      ((Panel) startMenu.getChild(i * 72 + j)).updateVisible(true);
    }
  } */
      
  
  //startMenu.addChild(new VisiblePanel(new PVector(350, 25), new PVector(200, 150)));
  //startMenu.addChild(new Panel(new PVector(50, 200), new PVector(200, 200)));
  //startMenu.addChild(new Panel(new PVector(300, 200), new PVector(100, 100)));
  
  
  posi = new PVector(0, 0);
}

void draw() {
  if (width != screenSize.x || height != screenSize.y) {
    checkScreenSize();
  }
  
  background(255);
  startMenu.updateScreenSpace(screenAdjust);
  startMenu.display();
  
  // speeeeed tests
  /*for (int i = 0; i < 128; i++) {
    for (int j = 0; j < 72; j++) {
      ((VisiblePanel) startMenu.getChild(i * 72 + j)).updateColor(255<<24|(int)(sin(frameCount/(i * 1 + 1)) * 100 + 155)<<16|(int)(cos(frameCount/(i * 2 + 1)) * 100 + 155)<<8|(int)(sin(frameCount/(j * 2 + 1)) * 100 + 155));
    }
  }*/
  
  //println(frameRate);
  
  ((VisiblePanel) startMenu.getChild(1)).updateColor(255<<24|(int)(sin(frameCount/20.0) * 100 + 155)<<16|(int)(cos(frameCount/20.0) * 100 + 155)<<8|(int)(sin(frameCount/10.0) * 100 + 155));
  //println((int)(sin(frameCount/20.0) * 100 + 155));
  
  //startMenu.updateLocation(posi);
}

void checkScreenSize() {
  screenSize = new PVector(width, height);
  screenAdjust = new PVector(screenSize.x / 1280, screenSize.y / 720);
}