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

void setup() {
  size(1280, 720, P2D);
  scrSize = new PVector(1280, 720);
  sizeAdjust = new PVector(scrSize.x / 1280, scrSize.y / 720);
  frameRate(60);
  
  mode = 0;
  time = 200.0;
  timeScale = 0.5; // amount of time passed each frame
  
  paused = false;
  //startB = new Button(new PVector(959, 300), new PVector(320, 70), color(170, 140, 100), 4, color(50, 43, 30));
  //optionsB = new Button(new PVector(979, 420), new PVector(300, 50), color(170, 140, 100), 3, color(50, 43, 30));
  //exitB = new Button(new PVector(979, 490), new PVector(300, 50), color(170, 140, 100), 3, color(50, 43, 30));
  
  startB = new Button("MainScreenButton.png", "MainScreenButtonPressed.png", "MainScreenButtonHighlighted.png", new PVector(945, 300), new PVector(345, 90), color(255, 0), 0, color(0));
  optionsB = new Button("MainScreenButton.png", "MainScreenButtonPressed.png", "MainScreenButtonHighlighted.png", new PVector(988, 415), new PVector(300, 75), color(255, 0), 0, color(0));
  exitB = new Button("MainScreenButton.png", "MainScreenButtonPressed.png", "MainScreenButtonHighlighted.png", new PVector(988, 490), new PVector(300, 75), color(255, 0), 0, color(0));
  MainTitle = new Title("MainTitle.png", new PVector(256, 0), new PVector(768, 384), color(255, 0), 0, color(0));
  
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
        if (!MainTitle.Active() && frameCount > 30) {
          MainTitle.FadeIn(2, sizeAdjust);
        } else if (MainTitle.Active()) {
          MainTitle.display(sizeAdjust);
          if (!startB.Active()) {
            startB.FadeIn(4, sizeAdjust);
            optionsB.FadeIn(4, sizeAdjust);
            exitB.FadeIn(4, sizeAdjust);
          } else {
            startB.display(sizeAdjust);
            optionsB.display(sizeAdjust);
            exitB.display(sizeAdjust);
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