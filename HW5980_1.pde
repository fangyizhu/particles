ParticleSystem ps;
int mode = 0; //1: water fountain, 2: fire, 3: magic spell, 4: Gravity, 5: bouncing on the floor
long startTime;
int fadetime;

void setup() {
  frameRate(60);
  background(0);
  size(800, 800);
  startTime = System.currentTimeMillis();
  ps = new ParticleSystem();
}

void draw() { 
  switch(mode) {
    case 0:
    fadetime = 20;
      fill(0, fadetime);  // fancy fade rendering (transparent background)
  rect(0, 0, width, height); // draw transparent background
    break;
    case 1:
    fadetime = 40;
      fill(0, fadetime);  // fancy fade rendering (transparent background)
  rect(0, 0, width, height); // draw transparent background
    break;
    case 2:
        fadetime = 40;
      fill(0, fadetime);  // fancy fade rendering (transparent background)
  rect(0, 0, width, height); // draw transparent background
    break;
  }
  drawModeTabs();
  drawModeObjects();
  ps.spawParticles();
  ps.run();
}


// UI: Sorry about ugly java
void drawModeObjects() {
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
}

