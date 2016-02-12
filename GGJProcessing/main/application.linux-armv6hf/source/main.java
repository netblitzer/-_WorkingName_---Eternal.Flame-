import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class main extends PApplet {

byte mode; // 0 for main menu, 1 for main game, 2 for running
PVector scrSize;
PVector sizeAdjust;
float time;
float timeScale;
boolean paused;
int skyColors[];
int curSkyColor;
int dark;
Button startB;
Button optionsB;
Button exitB;
Title MainTitle;

public void setup() {
  
  scrSize = new PVector(1280, 720);
  sizeAdjust = new PVector(scrSize.x / 1280, scrSize.y / 720);
  frameRate(60);
  
  mode = 0;
  time = 200.0f;
  timeScale = 0.5f; // amount of time passed each frame
  
  paused = false;
  //startB = new Button(new PVector(959, 300), new PVector(320, 70), color(170, 140, 100), 4, color(50, 43, 30));
  //optionsB = new Button(new PVector(979, 420), new PVector(300, 50), color(170, 140, 100), 3, color(50, 43, 30));
  //exitB = new Button(new PVector(979, 490), new PVector(300, 50), color(170, 140, 100), 3, color(50, 43, 30));
  
  startB = new Button("MainScreenButton.png", "MainScreenButtonPressed.png", "MainScreenButtonHighlighted.png", new PVector(945, 300), new PVector(345, 90), color(255, 0), 0, color(0));
  optionsB = new Button("MainScreenButton.png", "MainScreenButtonPressed.png", "MainScreenButtonHighlighted.png", new PVector(988, 415), new PVector(300, 75), color(255, 0), 0, color(0));
  exitB = new Button("MainScreenButton.png", "MainScreenButtonPressed.png", "MainScreenButtonHighlighted.png", new PVector(988, 490), new PVector(300, 75), color(255, 0), 0, color(0));
  MainTitle = new Title("MainTitle.png", new PVector(256, 0), new PVector(768, 384), color(255, 0), 0, color(0));
  
  skyColors = new int[2];
  skyColors[0] = color(40, 43, 46);
  skyColors[1] = color(140, 145, 150);
  curSkyColor = skyColors[0];
  dark = color(50, 50);
}

public void draw() {
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
    if (time >= 300.0f && time < 560.0f) {
      
      curSkyColor = lerpColor(skyColors[0], skyColors[1], map(time - 300.0f, 0.0f, 260, 0.0f, 1.0f));
      darkness = (int)round(sin(map(time, 300.0f, 560.0f, 0.0f, HALF_PI)) * 205 + 50);
      dark = 50<<24|darkness<<16|darkness<<8|darkness;
    } else if (time >= 560 && time < 1020) {
      
      curSkyColor = skyColors[1];
      dark = 50<<24|255<<16|255<<8|255;
    } else if (time >= 990 && time < 1110) {
      
      curSkyColor = lerpColor(skyColors[1], skyColors[0], map(time - 990.0f, 0.0f, 120, 0.0f, 1.0f));
      darkness = (int)round(sin(map(time, 990.0f, 1110.0f, HALF_PI, PI)) * 205 + 50);
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

public void checkScreenSize() {
  
  scrSize = new PVector(width, height);
  sizeAdjust = new PVector(scrSize.x / 1280, scrSize.y / 720);
  
}
// basic "click" button, can be used for things like scroll bars too

class Button extends GUIElement {
  
  PImage pressed;
  PImage high;
  int hghCol;
  int drkCol;
  int hghBCol;
  int drkBCol;
  
  Button(PVector p, PVector s, int c, int th, int bC) {
    super(p, s, c, th, bC);
    
    shp = createShape(RECT, 0, 0, size.x, size.y);
    shp.setFill(c);
    shp.setStroke(bC);
    shp.setStrokeWeight(th);
    
    hghBCol = (int)(bC * 1.25f);
    drkBCol = (int)(bC * 0.75f);
    hghCol = (int)(c * 1.25f);
    drkCol = (int)(c * 0.75f);
  }
  Button(String path, PVector p, PVector s, int c, int th, int bC) {
    super(p, s, c, th, bC);
    
    img = loadImage("textures/" + path);
    hghCol = (int)(c * 1.25f);
    drkCol = (int)(c * 0.75f);
  }
  Button(String path, String downPath, String highPath, PVector p, PVector s, int c, int th, int bC) {
    super(p, s, c, th, bC);
    
    img = loadImage("textures/" + path);
    high = loadImage("textures/" + highPath);
    pressed = loadImage("textures/" + downPath);
  }
  
  public void display(PVector sizeAdjust) {
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
// gives basic functions for gui elements to extend off of

abstract class GUIElement {
  
  PVector pos;
  PVector size;
  int fade;
  PShape shp;
  PImage img;
  public boolean active;
  int Col;
  int BCol;

  GUIElement(PVector p, PVector s, int c, int borderThickness, int borderC) {
    pos = p.copy();
    size = s.copy();
    
    Col = c;
    BCol = borderC;
    
    fade = 0;    
    active = false;
  }
  
  public abstract void display(PVector sizeAdjust);
  
  public boolean FadeIn(int speed, PVector sizeAdjust) {
    boolean returnType = false;
    display(sizeAdjust);
    if (fade >= 255) {
      active = true;
      returnType = true;
    } else {
      fade = clamp(fade + speed, 255, 0);
    }
    Col = fade<<24|(Col>>16&0xFF)<<16|(Col>>8&0xFF)<<8|Col&0xFF;
    BCol = fade<<24|(BCol>>16&0xFF)<<16|(BCol>>8&0xFF)<<8|BCol&0xFF;
    return returnType;
  }
  
  public boolean FadeOut(int speed) {
    boolean returnType = false;
    display(sizeAdjust);
    if (fade <= 0) {
      returnType = true;
    } else {
      active = false;
      fade = clamp(fade - speed, 255, 0);
    }
    Col = fade<<24|(Col>>16&0xFF)<<16|(Col>>8&0xFF)<<8|Col&0xFF;
    BCol = fade<<24|(BCol>>16&0xFF)<<16|(BCol>>8&0xFF)<<8|BCol&0xFF;
    return returnType;
  }
  
  public boolean Active() {
    return active;
  }
  
  public int clamp(int val, int max, int min) {
    if(val > max)
      return max;
    else if(val < min)
      return min;
    else
      return val;
  }
}
// for big text

class Title extends GUIElement {
  
  
  
  Title(String path, PVector p, PVector s, int c, int borderThickness, int borderC) {
     super(p, s, c, borderThickness, borderC);
     
     img = loadImage("textures/" + path);
  }
  
  
  public void display(PVector sizeAdjust) {
    tint(Col);
    image(img, pos.x * sizeAdjust.x, pos.y * sizeAdjust.y, size.x * sizeAdjust.x, size.y * sizeAdjust.y);
  }
}
  public void settings() {  size(1280, 720, P2D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "main" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
