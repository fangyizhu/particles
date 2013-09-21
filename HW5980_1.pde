ParticleSystem ps;
int mode = 0; //1: water fountain, 2: fire, 3: magic spell, 4: Gravity, 5: bouncing on the floor 6:smoke
long startTime;
int fadetime;
PVector objPosition;
PVector objSize;
boolean mouseMode = false;

void setup() {
  frameRate(60);
  background(0);
  size(800, 800);
  objPosition = new PVector(width/2, 4*height/5);
  objSize = new PVector(50, 50);
  startTime = System.currentTimeMillis();
  ps = new ParticleSystem();
}

void draw() { 
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
void drawModeObjects() {
  fill(25, 25, 122);
  rect(objPosition.x, objPosition.y, objSize.x, objSize.y);
}


void drawModeTabs() {
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

void mousePressed() {
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
  
  if (25 <= mouseX && mouseX <= 45 && 285 <= mouseY && mouseY <= 335) {
    if (mode != 5) {
      mouseMode = !mouseMode;
    }
  }
}

void keyBoard() {
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

