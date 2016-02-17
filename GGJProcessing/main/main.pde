byte mode; // 0 for main menu, 1 for main game, 2 for running
PVector screenAdjust;
PVector screenSize;
float time;
float timeScale;
boolean paused;
color skyColors[];
color curSkyColor;
color dark;

byte screenSizeChoice;
PVector screenSizeOptions[];
ArrayList<PVector> availableScreenSizeOptions;
Panel startMenu;
VisiblePanel optionsMenu;

void setup() {
  
  //----------------//
  /* INITIAL SETUPS */
  //----------------//
  
  size(1280, 720, P2D);
  screenSize = new PVector(1280, 720);
  screenAdjust = new PVector(1, 1);
  frameRate(60);
  
  mode = 0;
  time = 200.0;
  timeScale = 0.5; // amount of time passed each frame
  
  paused = false;
  
  skyColors = new color[2];
  skyColors[0] = color(40, 43, 46);
  skyColors[1] = color(140, 145, 150);
  curSkyColor = skyColors[0];
  dark = color(50, 50);
  
  // total screen size list (based on common resolutions on Steam)
  screenSizeOptions = new PVector[14];
  screenSizeOptions[0] = (new PVector( 800, 600 ));
  screenSizeOptions[1] = (new PVector( 1024, 768 ));
  screenSizeOptions[2] = (new PVector( 1280, 720 ));
  screenSizeOptions[3] = (new PVector( 1280, 1024 ));
  screenSizeOptions[4] = (new PVector( 1366, 768 ));
  screenSizeOptions[5] = (new PVector( 1440, 900 ));
  screenSizeOptions[6] = (new PVector( 1536, 864 ));
  screenSizeOptions[7] = (new PVector( 1600, 900 ));
  screenSizeOptions[8] = (new PVector( 1680, 1050 ));
  screenSizeOptions[9] = (new PVector( 1920, 1080 ));
  screenSizeOptions[10] = (new PVector( 1920, 1200 ));
  screenSizeOptions[11] = (new PVector( 2560, 1440 ));
  screenSizeOptions[12] = (new PVector( 2560, 1600 ));
  screenSizeOptions[13] = (new PVector( 3840, 2160 ));
  
  availableScreenSizeOptions = new ArrayList<PVector>();
  for (int i = 0; i < screenSizeOptions.length; i++) {
    if (screenSizeOptions[i].x < displayWidth && screenSizeOptions[i].y < displayHeight) {
      availableScreenSizeOptions.add(screenSizeOptions[i]);
    }
  }
  
  screenSizeChoice = 2; // default to 720p
  
    // initialize the start menu
    
  startMenu = new Panel(new PVector(945, 150), new PVector(1280, 720));
  startMenu.addChild(new ButtonContainer(new PVector(0, 0), new PVector(345, 90), "MainScreenButton.png", "MainScreenButtonHighlighted.png", "MainScreenButtonPressed.png"));
  startMenu.addChild(new ButtonContainer(new PVector(98, 115), new PVector(245, 75), "MainScreenButton.png", "MainScreenButtonHighlighted.png", "MainScreenButtonPressed.png"));
  startMenu.addChild(new ButtonContainer(new PVector(98, 190), new PVector(245, 75), "MainScreenButton.png", "MainScreenButtonHighlighted.png", "MainScreenButtonPressed.png"));
  startMenu.updateVisible(true);
  startMenu.updateActive(true);
  startMenu.updateAvailable(true);
  
  
    // initialize the options menu
      // stays the same for every mode
      
  optionsMenu = new VisiblePanel(new PVector(380, 80), new PVector(520, 500), 0xF8423A35);
  optionsMenu.addChild(new ButtonContainer(new PVector(490, 0), new PVector(30, 30), 0xDFD04444));
  optionsMenu.addChild(new ButtonContainer(new PVector(70, 80), new PVector(40, 40), 0xDF696560));
  optionsMenu.addChild(new ButtonContainer(new PVector(410, 80), new PVector(40, 40), 0xDF696560)); //<>//
  optionsMenu.addChild(new ButtonContainer(new PVector(70, 230), new PVector(35, 35), 0xDF696560));
  optionsMenu.addChild(new ButtonContainer(new PVector(415, 230), new PVector(35, 35), 0xDF696560));
  optionsMenu.addChild(new ButtonContainer(new PVector(70, 315), new PVector(35, 35), 0xDF696560));
  optionsMenu.addChild(new ButtonContainer(new PVector(415, 315), new PVector(35, 35), 0xDF696560));
  optionsMenu.addChild(new ButtonContainer(new PVector(70, 400), new PVector(35, 35), 0xDF696560));
  optionsMenu.addChild(new ButtonContainer(new PVector(415, 400), new PVector(35, 35), 0xDF696560));
  optionsMenu.addChild(new ButtonContainer(new PVector(210, 460), new PVector(100, 40), 0xDF696560));
  optionsMenu.addChild(new ButtonContainer(new PVector(315, 460), new PVector(100, 40), 0xDF696560));
  optionsMenu.addChild(new ButtonContainer(new PVector(420, 460), new PVector(100, 40), 0xDF696560));
  
  optionsMenu.addChild(new VisiblePanel(new PVector(110, 80), new PVector(300, 40), 0xDF292421));
  optionsMenu.updateVisible(true);
  optionsMenu.updateAvailable(true);
}

void draw() {
  background(0);
  
  if (width != screenSize.x || height != screenSize.y) {
    checkScreenSize();
  }
  
  switch(mode) {
    case 0:
    case 1:
      // background stuff not specific to either mode
      fill(84, 73, 64);
      rect(0,560 * screenAdjust.y, 1280 * screenAdjust.x, 160 * screenAdjust.y);
      
      fill(curSkyColor);
      rect(0, 0, 1280 * screenAdjust.x, 560 * screenAdjust.y);
      
      fill(dark);
      rect(0, 0, screenSize.x, screenSize.y);
      
      
      optionsMenu.updateScreenSpace(screenAdjust);
      
      // mode specific stuff
      if (mode == 0) {
         startMenu.updateScreenSpace(screenAdjust);
         startMenu.display();
         
         
         if (startMenu.isAvailable()) {
           if (((ButtonContainer)startMenu.getChild(2)).isLeftClicked()) {
             exit();
           }
           if (((ButtonContainer)startMenu.getChild(1)).isLeftClicked()) {
             optionsMenu.updateActive(true);
             
             startMenu.updateAvailable(false);
           }
         }
         
         if (optionsMenu.isActive()) {
           if (((ButtonContainer)optionsMenu.getChild(0)).isLeftClicked()) {
             startMenu.updateAvailable(true);
             
             optionsMenu.updateActive(false);
           }
           
           // screen size choices
           if (((ButtonContainer)optionsMenu.getChild(1)).isLeftClicked()) {
             screenSizeChoice--;
             if (screenSizeChoice >= availableScreenSizeOptions.size()) {
               screenSizeChoice = 0;
             } else if (screenSizeChoice < 0) {
               screenSizeChoice = (byte) (availableScreenSizeOptions.size() - 1);
             }
             println(screenSizeChoice);
             
           } else if (((ButtonContainer)optionsMenu.getChild(2)).isLeftClicked()) {
             screenSizeChoice++;
             if (screenSizeChoice >= availableScreenSizeOptions.size()) {
               screenSizeChoice = 0;
             } else if (screenSizeChoice < 0) {
               screenSizeChoice = (byte) (availableScreenSizeOptions.size() - 1);
             }
             
             println(screenSizeChoice);
           }
           
           if (((ButtonContainer)optionsMenu.getChild(11)).isLeftClicked()) {
             surface.setResizable(true);
             surface.setSize((int) ((PVector) availableScreenSizeOptions.get(screenSizeChoice)).x, (int) ((PVector) availableScreenSizeOptions.get(screenSizeChoice)).y);
             
             startMenu.updateAvailable(true);
             
             optionsMenu.updateActive(false);
           }
         }
      } else if (mode == 1) {
        
      }
      
      if (optionsMenu.isActive()) {
         optionsMenu.display();
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
  screenSize = new PVector(width, height);
  screenAdjust = new PVector(screenSize.x / 1280, screenSize.y / 720);
}