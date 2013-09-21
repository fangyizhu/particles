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

public class HW5980_1 extends PApplet {

ParticleSystem ps;
int mode = 0; //1: water fountain, 2: fire, 3: magic spell, 4: Gravity, 5: bouncing on the floor 6:smoke
long startTime;
int fadetime;
PVector objPosition;
PVector objSize;
boolean mouseMode = false;

public void setup() {
  frameRate(60);
  background(0);
  size(800, 800);
  objPosition = new PVector(width/2, 4*height/5);
  objSize = new PVector(50, 50);
  startTime = System.currentTimeMillis();
  ps = new ParticleSystem();
}

public void draw() { 
  keyBoard();
  switch(mode) {
  case 0:
    fadetime = 20;
    break;
  case 1: 
  case 2:
    fadetime = 40;
    break;
  case 3:
  case 4:
  case 5:
    fadetime = 100;
    break;
  }
  fill(0, fadetime); // fancy fade rendering (transparent background)
  rect(0, 0, width, height); // draw transparent background
  drawModeTabs();
  drawModeObjects();
  ps.spawParticles();
  ps.run();
}


// UI: Sorry about the ugly java
public void drawModeObjects() {
  fill(25, 25, 122);
  rect(objPosition.x, objPosition.y, objSize.x, objSize.y);
}


public void drawModeTabs() {
  noStroke();
  fill(mode == 0? 120 : 255);
  ellipse(40, 40, 15, 15);

  fill(mode == 1? 120 : 255);
  ellipse(40, 80, 15, 15);

  fill(mode == 2? 120 : 255);
  ellipse(40, 120, 15, 15);

  fill(mode == 3? 120 : 255);
  ellipse(40, 160, 15, 15);

  fill(mode == 4? 120 : 255);
  ellipse(40, 200, 15, 15);

  fill(mode == 5? 120 : 255);
  ellipse(40, 240, 15, 15);

  fill(mouseMode? 120 : 255);
  ellipse(40, 300, 15, 15);
}

public void mousePressed() {
  if (25 <= mouseX && mouseX <= 45 && 285 <= mouseY && mouseY <= 335) {
    if (mode != 5) {
      mouseMode = !mouseMode;
    }
  }

  if (25 <= mouseX && mouseX <= 45 && 25 <= mouseY && mouseY <= 45) {
    if (mode != 0) {
      mode = 0;
      redraw();
    }
  }

  if (25 <= mouseX && mouseX <= 45 && 75 <= mouseY && mouseY <= 95) {
    if (mode != 1) {
      mode = 1;
      redraw();
    }
  }

  if (25 <= mouseX && mouseX <= 45 && 105 <= mouseY && mouseY <= 135) {
    if (mode != 2) {
      mode = 2;
      redraw();
    }
  }

  if (25 <= mouseX && mouseX <= 45 && 145 <= mouseY && mouseY <= 175) {
    if (mode != 3) {
      mode = 3;
      redraw();
    }
  }

  if (25 <= mouseX && mouseX <= 45 && 185 <= mouseY && mouseY <= 215) {
    if (mode != 4) {
      mode = 4;
      redraw();
    }
  }

  if (25 <= mouseX && mouseX <= 45 && 225 <= mouseY && mouseY <= 255) {
    if (mode != 5) {
      mode = 5;
      redraw();
    }
  }
}

public void keyBoard() {
  if (keyPressed && key==CODED) {
    switch(keyCode) {
    case UP: 
      if ( objPosition.y > ps.particles.get(0).origin.y) {
        objPosition.y-=1;
      }
      break;
    case DOWN:
      objPosition.y+=1;
      break;
    case RIGHT:
      objPosition.x+=1;
      break;
    case LEFT:
      objPosition.x-=1;
      break;
    }
  }
}

class Particle {
  PVector position; //(x, y)
  PVector velocity; //(vx, vy)
  PVector acceleration; //(ax, ay)
  PVector colour; //(r,g,b)
  int life; //milliseconds
  int maxLife;
  PVector origin;
  int size;
  int opacity;

  Particle() {
    switch (mode) {
    case 0:
      maxLife = 500;
      acceleration = new PVector(0, 0.04f);
      velocity = new PVector(random(-1.5f, 1.5f), random(-4, -3));
      origin = new PVector(width/2, 3*height/5);
      position = origin.get();
      break;
    case 1:
      maxLife = 100;
      acceleration = new PVector(0, random(0, 0.1f));
      velocity = new PVector(0.6f*random(-1, 1), -3 + 0.03f*random(0, 1));
      origin = new PVector(width/2, 3*height/5);
      position = origin.get();
      position.add(randomPointOnDisk());
      break;
    case 2:
      maxLife = 700;
      acceleration = new PVector(0, random(0, -0.1f));
      velocity = new PVector(random(-0.7f, 0.7f), random(-2, 2));
      origin = new PVector(width/2, height/2);
      position = origin.get();
      position.add(randomPointOnDisk());
      size = (int)random(0, 15);
      break;
    case 3: 
    case 4:
      maxLife = 500;
      acceleration = new PVector(0, 0.05f);
      velocity = new PVector(random(1, 2.5f), random(-2.5f, -1));
      origin = new PVector(width/4, height/5);
      position = origin.get();
      position.add(randomPointOnDisk());
      break;
    case 5:
      maxLife = 1000;
      size = (int)random(1, 10);
      acceleration = new PVector(0, map(size, 1, 10, 0.0005f, 0.002f));
      velocity = new PVector(0, random(1, 0.5f));
      origin = new PVector(width/2, -5);
      position = origin.get();
      position.x += random(-800, 800);
      break;
    }
    life = 0;
  }

  public void run() {
    update();
    display();
  }

  public void update() {
    position.add(velocity);
    velocity.add(acceleration);
    switch (mode) {
    case 2:
      acceleration.add(new PVector(map(position.x - origin.x, -40, 40, 0.0005f, -0.0005f), 0));
      break;
    case 4:
      if (position.y > 2*height/3) {
        position.y = 2*height/3;
        velocity.y *= -0.4f;
      }
      break;
    case 5:
      velocity.x += random(-0.02f, 0.02f);
      if (position.y > 750) {
        position.y = 750;
        velocity.x = 0;
        velocity.y = 0;
      } 
      break;
    }
    if (mouseMode && dist(position.x, position.y, mouseX, mouseY) < 20) {
      velocity.x *= -1;
      velocity.y *= -1;
      position.x += velocity.x;
      position.y += velocity.y;
    }
    if (position.x > objPosition.x && position.x < (objPosition.x + objSize.x) && position.y > objPosition.y && position.y < (objPosition.y + objSize.y)) {
      position.y = objPosition.y;
      switch(mode) {
      case 0:
      case 1:
      case 3: 
      case 4:
        velocity.y *= -0.4f;
        break;
      case 2:
        velocity.y *= -random(0.5f, 1.5f);
        break;
      case 5:
        velocity.y = 0;
        velocity.x = 0;
        break;
      }
    }
    life += 1.0f;
  }

  public void display() {
    switch (mode) {
    case 0:
      fill(255, 10000/life); 
      ellipse(position.x, position.y, 3, 3);
      break;
    case 1:
      size = (int)map(life, 0, 100, 20, 2);
      opacity = (int)map(life, 0, 70, 200, 0);
      fill(255, map(dist(position.x, position.y, origin.x, origin.y), 50, 0, 0, 200), 0, opacity);
      ellipse(position.x, position.y, size, size);
      break;
    case 2:
      opacity = (int)map(life, 0, 200, 70, 30);
      int red = (int)map(life, 0, 300, 0, 255);
      int green = (int)map(velocity.y, 3, -3, 0, 255);
      int blue= (int)map(acceleration.y, -0.1f, 0.1f, 0, 255);
      fill(red, green, blue, opacity);
      ellipse(position.x, position.y, size, size);
      break;
    case 3: 
    case 4:
      fill(255, 255, 255);
      ellipse(position.x, position.y, 5, 5);
      break;
    case 5:
      fill(255, 255, 255, 30);
      ellipse(position.x, position.y, size, size);
      break;
    }
  }

  public boolean isDead() {
    if (life > maxLife) {
      return true;
    } 
    else if (mode == 1 && velocity.y > -1.3f) {
      return true;
    }
    else {
      return false;
    }
  }

  //Utils
  public PVector randomPointOnDisk() {
    int R = 0;
    switch(mode) {
    case 1: 
    case 3:
    case 4:
      R = 50;
      break;
    case 2:
      R = 70;
      break;
    case 5:
      R = 400;
      break;
    }
    float theta= random(0, 2 * 3.1415926f);
    float r = R * sqrt(random(0, 1));
    return new PVector((int)r*sin(theta), (int)r*cos(theta));
  }
}

class ParticleSystem {
  ArrayList<Particle> particles;
  int genRate; //particle/second

  ParticleSystem() {
    switch (mode) {
    case 0:
      genRate = 10;
      break;
    case 1:
      genRate = 50;
      break;
    case 2:
    case 3:
    case 4:
    case 5:
      genRate = 1;
    }
    particles = new ArrayList<Particle>();
  }

  public void spawParticles() {
    int numParticles = (int)(genRate * Math.random());
    for (int i = 0; i < numParticles; i++) {
      particles.add(new Particle());
    }
  }

  public void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
}

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "HW5980_1" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
