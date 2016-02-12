byte mode; // 0 for main menu, 1 for main game, 2 for running
PVector scrSize;
PVector sizeAdjust;
float time;
float timeScale;
boolean paused;
color skyColors[];
color curSkyColor;
color dark;
Button startB;
Button optionsB;
Button exitB;
Title MainTitle;

Panel StartScreen;
Panel OptionsMenu;

void setup() {
  size(1280, 720, P2D);
  scrSize = new PVector(1280, 720);
  sizeAdjust = new PVector(scrSize.x / 1280, scrSize.y / 720);
  frameRate(60);
  
  mode = 0;
  time = 200.0;
  timeScale = 0.5; // amount of time passed each frame
  
  paused = false;
  
  StartScreen = new Panel(new PVector(945, 150), new PVector(345, 265), color(60, 55, 65, 0), 4, color(20, 18, 22, 0));
  StartScreen.add(new Button("MainScreenButton.png", "MainScreenButtonPressed.png", "MainScreenButtonHighlighted.png", new PVector(0, 0), new PVector(345, 90), color(255, 0), color(0)));
  StartScreen.add(new Button("MainScreenButton.png", "MainScreenButtonPressed.png", "MainScreenButtonHighlighted.png", new PVector(98, 115), new PVector(245, 75), color(255, 0), color(0)));
  StartScreen.add(new Button("MainScreenButton.png", "MainScreenButtonPressed.png", "MainScreenButtonHighlighted.png", new PVector(98, 190), new PVector(245, 75), color(255, 0), color(0)));
  StartScreen.changeVisibility(true);
  StartScreen.changeThisVisibility(false);
  StartScreen.changeActiveState(false);
  
  OptionsMenu = new Panel(new PVector(490, 150), new PVector(300, 400), color(60, 55, 50, 240), 7, color(30, 27, 24, 240), 3);
  OptionsMenu.add(new Button(3, new PVector(276, 4), new PVector(20, 20), color(155, 65, 60), color(0)));
  OptionsMenu.changeVisibility(false);
  OptionsMenu.changeActiveState(false);
  
  //startB = new Button("MainScreenButton.png", "MainScreenButtonPressed.png", "MainScreenButtonHighlighted.png", new PVector(945, 150), new PVector(345, 90), color(255, 0), color(0));
  //optionsB = new Button("MainScreenButton.png", "MainScreenButtonPressed.png", "MainScreenButtonHighlighted.png", new PVector(1043, 265), new PVector(245, 75), color(255, 0), color(0));
  //exitB = new Button("MainScreenButton.png", "MainScreenButtonPressed.png", "MainScreenButtonHighlighted.png", new PVector(1043, 340), new PVector(245, 75), color(255, 0), color(0));
  MainTitle = new Title("MainTitle.png", new PVector(64, 64), new PVector(768, 384), color(255, 0), color(0));
  MainTitle.changeVisibility(true);
  
  skyColors = new color[2];
  skyColors[0] = color(40, 43, 46);
  skyColors[1] = color(140, 145, 150);
  curSkyColor = skyColors[0];
  dark = color(50, 50);
}

void draw() {
  background(0);
  
  if (width != scrSize.x || height != scrSize.y) {
    checkScreenSize();
  }
  
  switch(mode) {
    case 0:
    case 1:
      // background stuff not specific to either mode
      fill(84, 73, 64);
      rect(0,560 * sizeAdjust.y, 1280 * sizeAdjust.x, 160 * sizeAdjust.y);
      
      fill(curSkyColor);
      rect(0, 0, 1280 * sizeAdjust.x, 560 * sizeAdjust.y);
      
      fill(dark);
      rect(0, 0, scrSize.x, scrSize.y);
      
      // mode specific stuff
      if (mode == 0) {
        if (!MainTitle.isActive() && frameCount > 30) { //<>//
          MainTitle.fadeIn(6, sizeAdjust);
        } else if (MainTitle.isActive()) {
          MainTitle.display(sizeAdjust);
          if (!StartScreen.fadeIn(4, sizeAdjust));
        }
        
        if (StartScreen.isActive()) {
          StartScreen.display(sizeAdjust);
          
          if (((Button)StartScreen.get(2)).clicked) {
              exit();
            }
            if (((Button)StartScreen.get(1)).clicked) {
              OptionsMenu.changeActiveState(true);
              OptionsMenu.changeVisibility(true);
              StartScreen.changeActiveState(false);
            }
        }
        
        if (OptionsMenu.isGUIVisible()) {
          StartScreen.display(sizeAdjust);
          OptionsMenu.display(sizeAdjust);
          
          if (((Button)OptionsMenu.get(0)).clicked) {
            OptionsMenu.changeActiveState(false);
            OptionsMenu.changeVisibility(false);
            StartScreen.changeActiveState(true);
          }
        }
        
      } else if (mode == 1) {
        
      }
      
      break;
    case 2:
      
      break;
    default:
      
      break;
  }
  
  if (!paused) {
    time += timeScale;
    int darkness = 0;
    if (time >= 300.0 && time < 560.0) {
      
      curSkyColor = lerpColor(skyColors[0], skyColors[1], map(time - 300.0, 0.0, 260, 0.0, 1.0));
      darkness = (int)round(sin(map(time, 300.0, 560.0, 0.0, HALF_PI)) * 205 + 50);
      dark = 50<<24|darkness<<16|darkness<<8|darkness;
    } else if (time >= 560 && time < 1020) {
      
      curSkyColor = skyColors[1];
      dark = 50<<24|255<<16|255<<8|255;
    } else if (time >= 990 && time < 1110) {
      
      curSkyColor = lerpColor(skyColors[1], skyColors[0], map(time - 990.0, 0.0, 120, 0.0, 1.0));
      darkness = (int)round(sin(map(time, 990.0, 1110.0, HALF_PI, PI)) * 205 + 50);
      dark = 50<<24|darkness<<16|darkness<<8|darkness;
    } else {
      
      curSkyColor = skyColors[0];
      dark = 50<<24|50<<16|50<<8|50;
    }
    if (time >= 1440)
      { time = 0; }
  }
  
  //println(time);
}

void checkScreenSize() {
  
  scrSize = new PVector(width, height);
  sizeAdjust = new PVector(scrSize.x / 1280, scrSize.y / 720);
  
}