Panel startMenu;
PVector posi;
PVector screenAdjust;
PVector screenSize;

void setup() {
  size(1280, 720, P2D);
  screenSize = new PVector(1280, 720);
  screenAdjust = new PVector(1, 1);
  
  startMenu = new Panel(new PVector(200, 200), new PVector(600, 400));
  startMenu.addChild(new VisiblePanel(new PVector(0, 0), new PVector(300, 200), color(50)));
  startMenu.addChild(new VisiblePanel(new PVector(300, 200), new PVector(300, 200), "MainScreenButton.png"));
  ((Panel) startMenu.getChild(0)).updateVisible(true);
  ((Panel) startMenu.getChild(1)).updateVisible(true);
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
  
  posi.set(sin(frameCount/50.0) * 100 + 200, cos(frameCount/50.0) * 100 + 200);
  
  ((VisiblePanel) startMenu.getChild(0)).updateAlpha((int)(sin(frameCount/20.0) * 100 + 155));
  println((int)(sin(frameCount/20.0) * 100 + 155));
  
  startMenu.updateLocation(posi);
}

void checkScreenSize() {
  screenSize = new PVector(width, height);
  screenAdjust = new PVector(screenSize.x / 1280, screenSize.y / 720);
}